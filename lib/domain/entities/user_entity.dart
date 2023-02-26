class UserEntity {
  String email;
  late String authToken;
  late String uid;
  late bool premium;
  late double space;
  String? premiumEndDate;
  UserEntity({required this.email});
}
