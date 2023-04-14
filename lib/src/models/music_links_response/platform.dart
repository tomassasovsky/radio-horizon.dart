class MusicLinksPlatform {
  const MusicLinksPlatform({
    this.name,
    this.url,
  });

  static List<MusicLinksPlatform> listFromJson(Map<String, dynamic> json) {
    return json
        .cast<String, String>()
        .entries
        .map((entry) => MusicLinksPlatform(name: entry.key, url: entry.value))
        .toList();
  }

  final String? name;
  final String? url;
}
