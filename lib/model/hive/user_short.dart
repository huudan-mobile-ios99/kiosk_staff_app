
import 'dart:convert';
import 'package:hive/hive.dart';
part 'user_short.g.dart';

@HiveType(typeId: 0) // Unique typeId
class UserShort extends HiveObject{
  UserShort({
    this.name,
    this.number,
    this.createAt
  });

  @override
  String toString() {
    return jsonEncode({
      'name': name,
      'number': number,
      'createAt': createAt,
    });
  }
  @HiveField(0)
  String? name;
  @HiveField(1)
  int? number;
  @HiveField(2)
  String? createAt;

factory UserShort.fromJson(Map<String, dynamic> json) => UserShort(
        number: json["number"] ?? "",
        name: json["name"] ?? "",
        createAt: json["createAt"] ?? "",
    );

 UserShort copy() => UserShort(
    name: name,
    number: number,
    createAt: createAt,
  );

}
