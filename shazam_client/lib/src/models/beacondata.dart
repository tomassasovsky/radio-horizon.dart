import 'dart:convert';

class Beacondata {
  Beacondata({
    this.providername,
    this.type,
  });

  factory Beacondata.fromRawJson(String str) =>
      Beacondata.fromJson(json.decode(str) as Map);

  factory Beacondata.fromJson(Map<dynamic, dynamic> json) {
    json = json.cast<String, dynamic>();

    return Beacondata(
      providername: json['providername'] as String?,
      type: json['type'] as String?,
    );
  }
  final String? providername;
  final String? type;

  Beacondata copyWith({
    String? providername,
    String? type,
  }) =>
      Beacondata(
        providername: providername ?? this.providername,
        type: type ?? this.type,
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        'providername': providername,
        'type': type,
      };
}
