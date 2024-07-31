import 'dart:convert';

class Action {
  Action({
    this.id,
    this.name,
    this.type,
    this.uri,
  });

  factory Action.fromRawJson(String str) =>
      Action.fromJson(json.decode(str) as Map);

  factory Action.fromJson(Map<dynamic, dynamic> json) {
    json = json.cast<String, dynamic>();

    return Action(
      id: json['id'] as String?,
      name: json['name'] as String?,
      type: json['type'] as String?,
      uri: json['uri'] as String?,
    );
  }
  final String? id;
  final String? name;
  final String? type;
  final String? uri;

  Action copyWith({
    String? id,
    String? name,
    String? type,
    String? uri,
  }) =>
      Action(
        id: id ?? this.id,
        name: name ?? this.name,
        type: type ?? this.type,
        uri: uri ?? this.uri,
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'uri': uri,
      };
}
