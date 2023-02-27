class SubcribtionDetailEntity {
  bool cancelled;
  String endTime;
  SubcribtionDetailEntity({required this.cancelled, required this.endTime});

  factory SubcribtionDetailEntity.fromJson(Map<String, dynamic> json) {
    return SubcribtionDetailEntity(
        cancelled: json['cancelled'], endTime: json['end_time']);
  }
}
