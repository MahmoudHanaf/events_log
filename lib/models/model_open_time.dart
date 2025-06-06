import 'package:charging_station/models/model.dart';

class OpenTimeModel {
  final int dayOfWeek;
  final String key;
  final List<ScheduleModel> schedule;

  OpenTimeModel({
    required this.dayOfWeek,
    required this.key,
    required this.schedule,
  });

  factory OpenTimeModel.fromJson(Map<String, dynamic> json) {
    return OpenTimeModel(
      dayOfWeek: json['day_of_week'] ?? 1,
      key: json['key'] ?? "mon",
      schedule:
          List.from(json['schedule'] ?? []).map((e) {
            return ScheduleModel.fromJson(e);
          }).toList(),
    );
  }
}
