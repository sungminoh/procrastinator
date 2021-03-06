import 'package:json_annotation/json_annotation.dart';

part 'time.g.dart';

@JsonSerializable()
class Time {
  const Time(
      {this.year,
      this.month,
      this.day,
      this.hour,
      this.minute,
      this.second,
      this.weekday,
      this.absolute})
      : assert(day == null || weekday == null);
  final int year;
  final int month;
  final int day;
  final int weekday;
  final int hour;
  final int minute;
  final int second;
  final bool absolute;

  factory Time.fromJson(Map<String, dynamic> json) => _$TimeFromJson(json);

  Map<String, dynamic> toJson() => _$TimeToJson(this);
}
