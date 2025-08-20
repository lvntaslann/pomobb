import 'package:hive/hive.dart';

part 'content_model.g.dart';

@HiveType(typeId: 1)
class ContentModel extends HiveObject {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String subject;
  @HiveField(2)
  final int time;
  @HiveField(3)
  final String iconPath;
  @HiveField(4)
  final int containerBgColor;

  ContentModel({
    required this.id,
    required this.subject,
    required this.time,
    required this.iconPath,
    required this.containerBgColor,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "subject": subject,
        "time": time,
        "iconPath": iconPath,
        "containerBgColor": containerBgColor,
      };

  factory ContentModel.fromJson(Map<String, dynamic> json) => ContentModel(
        id: json["id"],
        subject: json["subject"],
        time: json["time"],
        iconPath: json["iconPath"],
        containerBgColor: json["containerBgColor"],
      );

  @override
  String toString() {
    return 'ContentModel{id: $id, subject: $subject, time: $time, iconPath: $iconPath, containerBgColor: $containerBgColor}';
  }
}
