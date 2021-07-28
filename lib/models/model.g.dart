// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
    id: json['id'] as int,
    title: json['title'] as String,
    text: json['text'] as String,
    verificationRequired: json['verificationRequired'] as bool,
    location: json['location'] as String,
    office: json['office'] as String,
    pocName: json['pocName'] as String,
    pocPhoneNumber: json['pocPhoneNumber'] as String,
    pocEmail: json['pocEmail'] as String,
  );
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'text': instance.text,
      'verificationRequired': instance.verificationRequired,
      'location': instance.location,
      'office': instance.office,
      'pocName': instance.pocName,
      'pocPhoneNumber': instance.pocPhoneNumber,
      'pocEmail': instance.pocEmail,
    };

Tasks _$TasksFromJson(Map<String, dynamic> json) {
  return Tasks(
    tasks: (json['tasks'] as List)
        ?.map(
            (e) => e == null ? null : Task.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$TasksToJson(Tasks instance) => <String, dynamic>{
      'tasks': instance.tasks,
    };
