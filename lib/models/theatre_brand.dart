class TheatreBrand {
  final String id;
  final String name;
  final String logo;

  TheatreBrand({this.id, this.name, this.logo});

  TheatreBrand copyWith({String id, String name, String logo}) {
    return TheatreBrand(
        id: id ?? this.id, name: name ?? this.name, logo: logo ?? this.logo);
  }

  factory TheatreBrand.fromJson(Map<String, dynamic> json) {
    return TheatreBrand(
        id: json['maHeThongRap'] as String,
        name: json['tenHeThongRap'] as String,
        logo: json['logo'] as String);
  }
}
