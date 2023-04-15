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
  DateTime created_at;
  FileFromServerEntity(
      {required this.url,
      required this.name,
      required this.created_at,
      required this.fileType});
  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'name': name,
      'created_at': created_at.toString(),
      'fileType': fileType.value()
    };
  }

  factory FileFromServerEntity.fromJson(Map<String, dynamic> json) {
    return FileFromServerEntity(
        url: json['url'],
        name: json['name'],
        fileType: FileTypeParser.fromString(json['fileType']),
        created_at: DateTime.parse(json['created_at']));
  }
}
