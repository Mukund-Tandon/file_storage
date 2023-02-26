class FileFromServerEntity {
  String location;
  FileFromServerEntity({required this.location});
  Map<String, dynamic> toJson() {
    return {'location': location};
  }

  factory FileFromServerEntity.fromJson(Map<String, dynamic> json) {
    return FileFromServerEntity(location: json['location']);
  }
}
