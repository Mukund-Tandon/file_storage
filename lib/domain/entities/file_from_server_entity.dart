class FileFromServerEntity {
  String url;
  String name;
  DateTime createdAt;
  FileFromServerEntity(
      {required this.url, required this.name, required this.createdAt});
  Map<String, dynamic> toJson() {
    return {'url': url, 'name': name, 'createdAt': createdAt};
  }

  factory FileFromServerEntity.fromJson(Map<String, dynamic> json) {
    return FileFromServerEntity(
        url: json['url'],
        name: json['name'],
        createdAt: DateTime.parse(json['created_at']));
  }
}
