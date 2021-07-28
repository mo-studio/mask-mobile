import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class Task {
  final int id;
  final String title;
  final String text;
  final bool verificationRequired;
  final String location;
  final String office;
  final String pocName;
  final String pocPhoneNumber;
  final String pocEmail;

  Task({@required this.id, @required this.title, @required this.text, this.verificationRequired = false, this.location = "1234 Main St", this.office = "Finance", this.pocName = "Joan Moneybags", this.pocPhoneNumber = "123-456-7890", this.pocEmail = "joan@finance.mil"});

  // These methods are required for the @JsonSerializable
  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}

@JsonSerializable()
class Tasks extends Object {
  final List<Task> tasks;

  Tasks({@required this.tasks});

  // These methods are required for the @JsonSerializable
  factory Tasks.fromJson(Map<String, dynamic> json) =>
      _$TasksFromJson(json);
  Map<String, dynamic> toJson() => _$TasksToJson(this);
}
