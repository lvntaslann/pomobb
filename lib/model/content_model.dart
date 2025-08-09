import 'package:flutter/material.dart';

class ContentModel {
  final int id;
  final String subject;
  final int time;
  final String iconPath;
  final Color containerBgColor;

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
        "containerBgColor": containerBgColor.value,
      };

  factory ContentModel.fromJson(Map<String, dynamic> json) => ContentModel(
        id: json["id"],
        subject: json["subject"],
        time: json["time"],
        iconPath: json["iconPath"],
        containerBgColor: Color(json["containerBgColor"]),
      );
}
