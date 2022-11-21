// Copyright (c) 2022, Tomás Sasovsky
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:convert';

RadioGardenSearchResponse radioGardenSearchResponseFromJson(String str) =>
    RadioGardenSearchResponse.fromJson(json.decode(str) as Map);

String radioGardenSearchResponseToJson(RadioGardenSearchResponse data) =>
    json.encode(data.toJson());

class RadioGardenSearchResponse {
  const RadioGardenSearchResponse({
    this.took,
    this.hits,
    this.query,
    this.version,
    this.apiVersion,
  });

  factory RadioGardenSearchResponse.fromJson(Map<dynamic, dynamic> json) {
    json = json.cast<String, dynamic>();
    return RadioGardenSearchResponse(
      took: json['took'] as int?,
      hits: json['hits'] == null ? null : Hits.fromJson(json['hits'] as Map),
      query: json['query'] == null ? null : json['query'] as String?,
      version: json['version'] == null ? null : json['version'] as String?,
      apiVersion:
          json['apiVersion'] == null ? null : json['apiVersion'] as int?,
    );
  }

  final int? took;
  final Hits? hits;
  final String? query;
  final String? version;
  final int? apiVersion;

  /// The title of the first track
  String? get title => hits?.hits?.first.source?.title;

  /// The play url of the first track
  String? get uri => hits?.hits?.first.source?.playUrl;

  String get radioId {
    final uriSplit = uri?.split('/');
    // uri ends as **/radioId/song.mp3
    return uriSplit?[uriSplit.length - 2] ?? '';
  }

  Map<String, dynamic> toJson() => {
        'took': took,
        'hits': hits?.toJson(),
        'query': query,
        'version': version,
        'apiVersion': apiVersion,
      };
}

class Hits {
  const Hits({
    this.hits,
  });

  factory Hits.fromJson(Map<dynamic, dynamic> json) {
    json = json.cast<String, dynamic>();
    final hits = json['hits'] as List?;
    return Hits(
      hits: hits == null
          ? null
          : List<Hit>.from(
              hits.cast<Map<dynamic, dynamic>>().map(Hit.fromJson),
            ),
    );
  }

  final List<Hit>? hits;

  Map<String, dynamic> toJson() {
    return {
      if (hits != null)
        'hits': List<dynamic>.from(hits!.map((x) => x.toJson())),
    };
  }
}

class Hit {
  Hit({
    this.id,
    this.score,
    this.source,
  });

  factory Hit.fromJson(Map<dynamic, dynamic> json) {
    json = json.cast<String, dynamic>();
    return Hit(
      id: json['_id'] as String,
      score: json['_score'] as num,
      source: Source.fromJson(json['_source'] as Map),
    );
  }

  final String? id;
  final num? score;
  final Source? source;

  Map<String, dynamic> toJson() => {
        '_id': id,
        '_score': score,
        '_source': source?.toJson(),
      };
}

class Source {
  Source({
    required this.url,
    this.code,
    this.subtitle,
    this.type,
    this.title,
    this.secure,
  });

  factory Source.fromJson(Map<dynamic, dynamic> json) {
    json = json.cast<String, dynamic>();
    return Source(
      code: json['code'] as String?,
      subtitle: json['subtitle'] as String?,
      type: json['type'] == null ? null : Type.fromJson(json['type'] as String),
      title: json['title'] as String?,
      secure: json['secure'] == null ? null : json['secure'] as bool?,
      url: json['url'] as String,
    );
  }

  final String? code;
  final String? subtitle;
  final Type? type;
  final String? title;
  final bool? secure;
  final String url;

  String get playUrl {
    final split = Uri.parse(url).pathSegments;
    final playId = split.last;
    return _basePlayUrl + playId + _playUrlSuffix;
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'subtitle': subtitle,
        'type': type?.name,
        'title': title,
        'secure': secure,
        'url': url,
      };

  static const _basePlayUrl = 'https://radio.garden/api/ara/content/listen/';
  static const _playUrlSuffix = '/channel.mp3';
}

enum Type {
  channel,
  place,
  country;

  factory Type.fromJson(String str) {
    switch (str.toLowerCase()) {
      case 'channel':
        return Type.channel;
      case 'place':
        return Type.place;
      case 'country':
        return Type.country;
    }

    throw Exception('Unknown type: $str');
  }
}
