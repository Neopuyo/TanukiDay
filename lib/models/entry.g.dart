// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Entry _$EntryFromJson(Map<String, dynamic> json) => Entry(
      usermail: json['usermail'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      feeling: json['feeling'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$EntryToJson(Entry instance) => <String, dynamic>{
      'usermail': instance.usermail,
      'date': instance.date.toIso8601String(),
      'title': instance.title,
      'content': instance.content,
      'feeling': instance.feeling,
    };
