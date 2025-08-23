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

  @HiveField(5)
  final int timerPageColor;

  @HiveField(6)
  final int timerStartProgressColor;

  @HiveField(7)
  final int timerProgressColor;

  @HiveField(8)
  final int timerTextColor;
  @HiveField(9)
  final int period;

  @HiveField(10)
  final int breakTime;

  @HiveField(11)
  final bool isSuccess;

  ContentModel({
    required this.id,
    required this.subject,
    required this.time,
    required this.iconPath,
    required this.containerBgColor,
    required this.timerPageColor,
    required this.timerStartProgressColor,
    required this.timerProgressColor,
    required this.timerTextColor,
    required this.period,
    required this.breakTime,
    required this.isSuccess,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "subject": subject,
        "time": time,
        "iconPath": iconPath,
        "containerBgColor": containerBgColor,
        "timerPageColor": timerPageColor,
        "timerStartProgressColor": timerStartProgressColor,
        "timerProgressColor": timerProgressColor,
        "timerTextColor": timerTextColor,
        "period": period,
        "breakTime": breakTime,
        "isSuccess": isSuccess,
      };

  /// JSON'dan oluşturma
  factory ContentModel.fromJson(Map<String, dynamic> json) => ContentModel(
        id: json["id"],
        subject: json["subject"],
        time: json["time"],
        iconPath: json["iconPath"],
        containerBgColor: json["containerBgColor"],
        timerPageColor: json["timerPageColor"],
        timerStartProgressColor: json["timerStartProgressColor"],
        timerProgressColor: json["timerProgressColor"],
        timerTextColor: json["timerTextColor"],
        period: json["period"],
        breakTime: json["breakTime"],
        isSuccess: json["isSuccess"],
      );

  @override
  String toString() {
    return 'ContentModel{id: $id, subject: $subject, time: $time, iconPath: $iconPath, containerBgColor: $containerBgColor, period: $period, breakTime: $breakTime, isSuccess: $isSuccess}';
  }
}

/// copyWith extension
extension ContentModelCopy on ContentModel {
  ContentModel copyWith({
    int? id,
    String? subject,
    int? time,
    String? iconPath,
    int? containerBgColor,
    int? period,
    int? breakTime,
    bool? isSuccess,
  }) {
    return ContentModel(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      time: time ?? this.time,
      iconPath: iconPath ?? this.iconPath,
      containerBgColor: containerBgColor ?? this.containerBgColor,
      timerPageColor: timerPageColor,
      timerStartProgressColor:
          timerStartProgressColor ,
      timerProgressColor: timerProgressColor ,
      timerTextColor: timerTextColor,
      period: period ?? this.period,
      breakTime: breakTime ?? this.breakTime,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
