enum FileUploadStatus { starting, started, completed, error }

extension FileUploadStatusParser on FileUploadStatus {
  String value() {
    return this.toString().split('.').last;
  }

//static keyword for class level methors with can be accessed without creating an object
  static FileUploadStatus fromString(String status) {
    return FileUploadStatus.values
        .firstWhere((element) => element.value() == status);
  }
}

class FileUploadingFetailStreamEntity {
  FileUploadStatus fileUploadStatus;
  String? percentage;
  FileUploadingFetailStreamEntity(
      {required this.fileUploadStatus, this.percentage});

  factory FileUploadingFetailStreamEntity.fromJson(Map<String, dynamic> json) {
    return FileUploadingFetailStreamEntity(
        fileUploadStatus: FileUploadStatusParser.fromString(json['status']),
        percentage: json['percentage']);
  }

  Map<String, dynamic> toJson() {
    return {
      'status': fileUploadStatus.value(),
      'percentage': percentage,
    };
  }
}
