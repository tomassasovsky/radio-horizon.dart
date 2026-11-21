/// <reference types="vite/client" />

interface Window {
  __DISCORD_CLIENT_ID__?: string;
}

interface ImportMetaEnv {
  readonly VITE_DISCORD_CLIENT_ID?: string;
}

interface ImportMeta {
  readonly env: ImportMetaEnv;
}
