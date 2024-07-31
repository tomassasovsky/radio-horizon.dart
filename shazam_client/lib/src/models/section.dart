import 'dart:convert';

import 'package:shazam_client/shazam_client.dart';

class Section {
  Section({
    this.metadata,
    this.metapages,
    this.tabname,
    this.type,
    this.url,
  });

  factory Section.fromRawJson(String str) =>
      Section.fromJson(json.decode(str) as Map);

  factory Section.fromJson(Map<dynamic, dynamic> json) {
    json = json.cast<String, dynamic>();

    return Section(
      metadata: json['metadata'] == null
          ? null
          : List<Metadatum>.from(
              (json['metadata'] as List)
                  .cast<Map<dynamic, dynamic>>()
                  .map(Metadatum.fromJson),
            ),
      metapages: json['metapages'] == null
          ? null
          : List<Metapage>.from(
              (json['metapages'] as List)
                  .cast<Map<dynamic, dynamic>>()
                  .map(Metapage.fromJson),
            ),
      tabname: json['tabname'] as String?,
      type: json['type'] as String?,
      url: json['url'] as String?,
    );
  }
  final List<Metadatum>? metadata;
  final List<Metapage>? metapages;
  final String? tabname;
  final String? type;
  final String? url;

  Section copyWith({
    List<Metadatum>? metadata,
    List<Metapage>? metapages,
    String? tabname,
    String? type,
    String? url,
  }) =>
      Section(
        metadata: metadata ?? this.metadata,
        metapages: metapages ?? this.metapages,
        tabname: tabname ?? this.tabname,
        type: type ?? this.type,
        url: url ?? this.url,
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'metadata': metadata == null
            ? null
            : List<dynamic>.from(metadata!.map((x) => x.toJson())),
        'metapages': metapages == null
            ? null
            : List<dynamic>.from(metapages!.map((x) => x.toJson())),
        'tabname': tabname,
        'type': type,
        'url': url,
      };
}
