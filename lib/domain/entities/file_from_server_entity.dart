enum FileType { image, notImage }

extension FileTypeParser on FileType {
  String value() {
    return this.toString().split('.').last;
  }

//static keyword for class level methors with can be accessed without creating an object
  static FileType fromString(String status) {
    return FileType.values.firstWhere((element) => element.value() == status);
  }
}

class FileFromServerEntity {
  String url;
  String name;
  FileType fileType;
  DateTime createdAt;
  FileFromServerEntity(
      {required this.url,
      required this.name,
      required this.createdAt,
      required this.fileType});
  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'name': name,
      'createdAt': createdAt,
      'fileType': fileType.value()
    };
  }

  factory FileFromServerEntity.fromJson(Map<String, dynamic> json) {
    return FileFromServerEntity(
        url: json['url'],
        name: json['name'],
        fileType: FileTypeParser.fromString(json['fileType']),
        createdAt: DateTime.parse(json['created_at']));
  }
}
