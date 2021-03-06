// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Time _$TimeFromJson(Map<String, dynamic> json) {
  return Time(
    year: json['year'] as int,
    month: json['month'] as int,
    day: json['day'] as int,
    hour: json['hour'] as int,
    minute: json['minute'] as int,
    second: json['second'] as int,
    weekday: json['weekday'] as int,
    absolute: json['absolute'] as bool,
  );
}

Map<String, dynamic> _$TimeToJson(Time instance) => <String, dynamic>{
      'year': instance.year,
      'month': instance.month,
      'day': instance.day,
      'weekday': instance.weekday,
      'hour': instance.hour,
      'minute': instance.minute,
      'second': instance.second,
      'absolute': instance.absolute,
    };
