import { DiscordSDK } from '@discord/embedded-app-sdk';
import './style.css';

type SessionKind = 'idle' | 'radio' | 'music' | 'lavalink_error';
type SearchMode = 'radio' | 'music';
type MusicSource = 'ytsearch' | 'dzsearch';

interface StationHit {
  stationUuid: string;
  name: string;
}

interface TrackHit {
  encoded: string;
  title: string;
  author: string;
}

const blockedCopy =
  'Open Radio Horizon from a server voice channel to control playback.';

const mounted = document.querySelector('#app');
if (!(mounted instanceof HTMLElement)) {
  throw new Error('missing #app');
}
const app = mounted;

let accessToken = '';
let instanceId = '';
let pollTimer = 0;
let recognizing = false;
let skipMessage = '';
let notice = '';
let recognizedTitle = '';
let searchMode: SearchMode = 'radio';
let musicSource: MusicSource = 'ytsearch';
let sessionKind: SessionKind = 'idle';
let stationName: string | null = null;
let trackTitle: string | null = null;
let volume = 80;
let panelReady = false;

const els = {
  kind: document.createElement('p'),
  nowTitle: document.createElement('p'),
  liveDot: document.createElement('span'),
  lavalinkError: document.createElement('p'),
  skipNotice: document.createElement('p'),
  notice: document.createElement('p'),
  recognized: document.createElement('p'),
  skip: document.createElement('button'),
  stop: document.createElement('button'),
  recognize: document.createElement('button'),
  upvote: document.createElement('button'),
  volumeLabel: document.createElement('span'),
  volume: document.createElement('input'),
  radioMode: document.createElement('button'),
  musicMode: document.createElement('button'),
  youtube: document.createElement('button'),
  deezer: document.createElement('button'),
  query: document.createElement('input'),
  results: document.createElement('ul'),
};

function discordClientId(): string {
  const injected = window.__DISCORD_CLIENT_ID__;
  if (injected && injected !== '__DISCORD_CLIENT_ID_PLACEHOLDER__') {
    return injected;
  }
  const fromEnv = import.meta.env.VITE_DISCORD_CLIENT_ID;
  if (fromEnv) {
    return fromEnv;
  }
  const match = /^(\d+)\.discordsays\.com$/.exec(window.location.hostname);
  if (match) {
    return match[1];
  }
  throw new Error('missing Discord client id');
}

function withTimeout<T>(promise: Promise<T>, ms: number): Promise<T> {
  return new Promise((resolve, reject) => {
    const timer = window.setTimeout(() => reject(new Error('timeout')), ms);
    promise.then(
      (value) => {
        window.clearTimeout(timer);
        resolve(value);
      },
      (error: unknown) => {
        window.clearTimeout(timer);
        reject(error);
      },
    );
  });
}

function setText(el: Element, value: string): void {
  el.textContent = value;
}

function showBlocked(message: string): void {
  window.clearInterval(pollTimer);
  panelReady = false;
  app.replaceChildren();
  const card = document.createElement('section');
  card.className = 'card blocked';
  const kicker = document.createElement('p');
  kicker.className = 'kicker';
  setText(kicker, 'Off air');
  const copy = document.createElement('p');
  setText(copy, message);
  card.append(kicker, copy);
  const mast = document.createElement('header');
  mast.className = 'mast';
  const wordmark = document.createElement('h1');
  wordmark.className = 'wordmark';
  setText(wordmark, 'Radio Horizon');
  const sig = document.createElement('p');
  sig.className = 'sig';
  setText(sig, 'Guild voice only');
  mast.append(wordmark, sig);
  app.append(mast, card);
}

function kindLabel(): string {
  switch (sessionKind) {
    case 'radio':
      return 'Radio';
    case 'music':
      return 'Music';
    case 'lavalink_error':
      return 'Signal lost';
    case 'idle':
      return 'Idle';
  }
}

function nowPlayingTitle(): string {
  if (sessionKind === 'radio') {
    return stationName ?? 'Live station';
  }
  if (sessionKind === 'music') {
    return trackTitle ?? 'Queued track';
  }
  if (sessionKind === 'lavalink_error') {
    return 'Playback is unavailable.';
  }
  return 'Nothing playing in this channel.';
}

async function api(
  path: string,
  init: RequestInit = {},
): Promise<{ status: number; body: Record<string, unknown> }> {
  const headers = new Headers(init.headers);
  if (accessToken) {
    headers.set('Authorization', `Bearer ${accessToken}`);
  }
  if (instanceId) {
    headers.set('X-Discord-Instance-Id', instanceId);
  }
  if (init.body && !headers.has('Content-Type')) {
    headers.set('Content-Type', 'application/json');
  }
  const response = await fetch(path, { ...init, headers });
  let body: Record<string, unknown> = {};
  try {
    const parsed: unknown = await response.json();
    if (parsed && typeof parsed === 'object') {
      body = parsed as Record<string, unknown>;
    }
  } catch {
    body = {};
  }
  return { status: response.status, body };
}

function errorCode(body: Record<string, unknown>): string {
  return typeof body.error === 'string' ? body.error : '';
}

function paintNowPlaying(): void {
  const isRadio = sessionKind === 'radio';
  const canTransport = isRadio || sessionKind === 'music';
  setText(els.kind, kindLabel());
  setText(els.nowTitle, nowPlayingTitle());
  if (sessionKind === 'idle' || sessionKind === 'lavalink_error') {
    els.liveDot.dataset.off = 'true';
  } else {
    delete els.liveDot.dataset.off;
  }
  els.lavalinkError.hidden = sessionKind !== 'lavalink_error';
  els.skipNotice.hidden = skipMessage.length === 0;
  setText(els.skipNotice, skipMessage);
  els.notice.hidden = notice.length === 0;
  setText(els.notice, notice);
  els.recognized.hidden = recognizedTitle.length === 0;
  setText(els.recognized, recognizedTitle);
  els.skip.disabled = !canTransport;
  els.stop.disabled = !canTransport;
  els.recognize.hidden = !isRadio;
  els.upvote.hidden = !isRadio;
  els.recognize.disabled = !isRadio || recognizing;
  els.upvote.disabled = !isRadio;
  setText(els.recognize, recognizing ? 'Listening…' : 'Recognize');
  els.volume.disabled = !canTransport;
  els.volume.value = String(volume);
  setText(els.volumeLabel, `Vol ${volume}`);
  els.radioMode.setAttribute('aria-pressed', String(searchMode === 'radio'));
  els.musicMode.setAttribute('aria-pressed', String(searchMode === 'music'));
  els.youtube.hidden = searchMode !== 'music';
  els.deezer.hidden = searchMode !== 'music';
  els.youtube.setAttribute('aria-pressed', String(musicSource === 'ytsearch'));
  els.deezer.setAttribute('aria-pressed', String(musicSource === 'dzsearch'));
  els.query.placeholder =
    searchMode === 'radio' ? 'Search stations' : 'Search tracks';
}

function renderResults(stations: StationHit[], tracks: TrackHit[]): void {
  els.results.replaceChildren();
  if (searchMode === 'radio') {
    for (const station of stations) {
      const item = document.createElement('li');
      const play = document.createElement('button');
      setText(play, station.name);
      play.addEventListener('click', () => {
        void playRadio(station.stationUuid);
      });
      item.append(play);
      els.results.append(item);
    }
    return;
  }
  for (const track of tracks) {
    const item = document.createElement('li');
    const play = document.createElement('button');
    setText(play, `${track.title} — ${track.author}`);
    play.addEventListener('click', () => {
      void playMusic(track.encoded);
    });
    item.append(play);
    els.results.append(item);
  }
}

function mountPanel(): void {
  if (panelReady) {
    paintNowPlaying();
    return;
  }
  panelReady = true;
  app.replaceChildren();

  els.kind.className = 'sig';
  els.nowTitle.className = 'title';
  els.liveDot.className = 'live-dot';
  els.lavalinkError.className = 'error';
  setText(els.lavalinkError, 'Play will not start until Lavalink is back.');
  els.skipNotice.className = 'notice';
  els.notice.className = 'notice';
  els.recognized.className = 'notice';
  setText(els.skip, 'Skip');
  setText(els.stop, 'Stop');
  setText(els.recognize, 'Recognize');
  setText(els.upvote, 'Upvote');
  els.volume.type = 'range';
  els.volume.min = '0';
  els.volume.max = '100';
  setText(els.radioMode, 'Radio');
  setText(els.musicMode, 'Music');
  setText(els.youtube, 'YouTube');
  setText(els.deezer, 'Deezer');
  els.query.type = 'search';
  els.results.className = 'results';

  const mast = document.createElement('header');
  mast.className = 'mast';
  const wordmark = document.createElement('h1');
  wordmark.className = 'wordmark';
  setText(wordmark, 'Radio Horizon');
  mast.append(wordmark, els.kind);

  const card = document.createElement('section');
  card.className = 'card now';
  const kicker = document.createElement('p');
  kicker.className = 'kicker';
  kicker.append(els.liveDot, document.createTextNode('Now on this channel'));
  const controls = document.createElement('div');
  controls.className = 'controls';
  controls.append(els.skip, els.stop, els.recognize, els.upvote);
  const volumeRow = document.createElement('label');
  volumeRow.className = 'volume';
  volumeRow.append(els.volumeLabel, els.volume);
  card.append(
    kicker,
    els.nowTitle,
    els.lavalinkError,
    els.skipNotice,
    els.notice,
    els.recognized,
    controls,
    volumeRow,
  );

  const search = document.createElement('section');
  search.className = 'search';
  const modes = document.createElement('div');
  modes.className = 'modes';
  modes.append(els.radioMode, els.musicMode, els.youtube, els.deezer);
  const row = document.createElement('div');
  row.className = 'search-row';
  const go = document.createElement('button');
  setText(go, 'Search');
  row.append(els.query, go);
  search.append(modes, row, els.results);

  els.skip.addEventListener('click', () => {
    void (async () => {
      skipMessage = '';
      const code = await mutate('/api/skip');
      skipMessage = code === 'nothing_to_skip' ? 'Nothing to skip.' : '';
      paintNowPlaying();
    })();
  });
  els.stop.addEventListener('click', () => {
    void (async () => {
      skipMessage = '';
      notice = '';
      recognizedTitle = '';
      await mutate('/api/stop');
    })();
  });
  els.recognize.addEventListener('click', () => {
    void recognizeSong();
  });
  els.upvote.addEventListener('click', () => {
    void (async () => {
      const code = await mutate('/api/upvote');
      notice = code ? 'Could not upvote this station.' : 'Voted.';
      paintNowPlaying();
    })();
  });
  els.volume.addEventListener('input', () => {
    volume = Number(els.volume.value);
    setText(els.volumeLabel, `Vol ${volume}`);
  });
  els.volume.addEventListener('change', () => {
    volume = Number(els.volume.value);
    void mutate('/api/volume', { volume });
  });
  els.radioMode.addEventListener('click', () => {
    searchMode = 'radio';
    els.results.replaceChildren();
    paintNowPlaying();
  });
  els.musicMode.addEventListener('click', () => {
    searchMode = 'music';
    els.results.replaceChildren();
    paintNowPlaying();
  });
  els.youtube.addEventListener('click', () => {
    musicSource = 'ytsearch';
    paintNowPlaying();
  });
  els.deezer.addEventListener('click', () => {
    musicSource = 'dzsearch';
    paintNowPlaying();
  });
  go.addEventListener('click', () => {
    void searchCatalog();
  });
  els.query.addEventListener('keydown', (event) => {
    if (event.key === 'Enter') {
      event.preventDefault();
      void searchCatalog();
    }
  });

  app.append(mast, card, search);
  paintNowPlaying();
}

async function refreshNowPlaying(): Promise<void> {
  const { status, body } = await api('/api/now-playing');
  if (status === 401 || status === 403) {
    showBlocked(blockedCopy);
    return;
  }
  if (status !== 200) {
    return;
  }
  const kind = body.kind;
  if (
    kind === 'idle' ||
    kind === 'radio' ||
    kind === 'music' ||
    kind === 'lavalink_error'
  ) {
    sessionKind = kind;
  }
  stationName = typeof body.stationName === 'string' ? body.stationName : null;
  trackTitle = typeof body.trackTitle === 'string' ? body.trackTitle : null;
  mountPanel();
}

async function mutate(
  path: string,
  body?: Record<string, unknown>,
): Promise<string> {
  const { status, body: json } = await api(path, {
    method: 'POST',
    body: body ? JSON.stringify(body) : undefined,
  });
  if (status === 401 || status === 403) {
    showBlocked(blockedCopy);
    return 'not_in_voice';
  }
  await refreshNowPlaying();
  return status >= 400 ? errorCode(json) : '';
}

async function playRadio(stationUuid: string): Promise<void> {
  skipMessage = '';
  notice = '';
  const code = await mutate('/api/play/radio', { stationUuid });
  if (code === 'lavalink_unavailable') {
    notice = 'Playback is unavailable.';
    paintNowPlaying();
  }
}

async function playMusic(encodedTrack: string): Promise<void> {
  skipMessage = '';
  notice = '';
  const code = await mutate('/api/play/music', { encodedTrack });
  if (code === 'lavalink_unavailable') {
    notice = 'Playback is unavailable.';
    paintNowPlaying();
  }
}

async function recognizeSong(): Promise<void> {
  recognizing = true;
  recognizedTitle = '';
  paintNowPlaying();
  const { status, body } = await api('/api/recognize', { method: 'POST' });
  recognizing = false;
  if (status === 401 || status === 403) {
    showBlocked(blockedCopy);
    return;
  }
  if (status >= 400) {
    notice =
      errorCode(body) === 'radio_only'
        ? 'Recognize is for radio only.'
        : 'Could not recognize this station.';
  } else {
    const titleText = typeof body.title === 'string' ? body.title : '';
    const subtitle = typeof body.subtitle === 'string' ? body.subtitle : '';
    recognizedTitle = [titleText, subtitle].filter(Boolean).join(' — ');
    notice = recognizedTitle ? '' : 'Could not recognize this station.';
  }
  await refreshNowPlaying();
}

async function searchCatalog(): Promise<void> {
  const q = els.query.value.trim();
  if (!q) {
    els.results.replaceChildren();
    return;
  }
  if (searchMode === 'radio') {
    const { status, body } = await api(
      `/api/search/radio?q=${encodeURIComponent(q)}`,
    );
    if (status === 401 || status === 403) {
      showBlocked(blockedCopy);
      return;
    }
    const stations = Array.isArray(body.stations)
      ? (body.stations as StationHit[])
      : [];
    renderResults(stations, []);
    return;
  }
  const { status, body } = await api(
    `/api/search/music?q=${encodeURIComponent(q)}&source=${musicSource}`,
  );
  if (status === 401 || status === 403) {
    showBlocked(blockedCopy);
    return;
  }
  const tracks = Array.isArray(body.tracks) ? (body.tracks as TrackHit[]) : [];
  renderResults([], tracks);
}

async function authorize(
  sdk: DiscordSDK,
  clientId: string,
): Promise<{ code: string }> {
  try {
    return await sdk.commands.authorize({
      client_id: clientId,
      response_type: 'code',
      state: '',
      prompt: 'none',
      scope: ['identify'],
    });
  } catch {
    return sdk.commands.authorize({
      client_id: clientId,
      response_type: 'code',
      state: '',
      scope: ['identify'],
    });
  }
}

async function boot(): Promise<void> {
  let clientId: string;
  try {
    clientId = discordClientId();
  } catch {
    showBlocked(blockedCopy);
    return;
  }

  const sdk = new DiscordSDK(clientId);
  try {
    await withTimeout(sdk.ready(), 4000);
  } catch {
    showBlocked(blockedCopy);
    return;
  }

  instanceId = sdk.instanceId;

  try {
    const { code } = await authorize(sdk, clientId);
    const { status, body } = await api('/api/token', {
      method: 'POST',
      body: JSON.stringify({ code }),
    });
    const token = body.access_token;
    if (status >= 400 || typeof token !== 'string' || token.length === 0) {
      showBlocked(blockedCopy);
      return;
    }
    accessToken = token;
    const auth = await sdk.commands.authenticate({ access_token: token });
    if (auth == null) {
      showBlocked(blockedCopy);
      return;
    }
  } catch {
    showBlocked(blockedCopy);
    return;
  }

  mountPanel();
  await refreshNowPlaying();
  pollTimer = window.setInterval(() => {
    void refreshNowPlaying();
  }, 2000);
}

void boot();
