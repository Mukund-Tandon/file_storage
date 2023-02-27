import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class UserDetails {
  @HiveField(0)
  late String uid;

  @HiveField(1)
  late String email;

  @HiveField(2)
  late bool premium;

  @HiveField(3)
  late double space;

  @HiveField(4)
  late bool cancelled;

  @HiveField(5)
  late String endTime;
}
