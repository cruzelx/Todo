import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Task extends Equatable {
  String activity;
  bool isComplete;

  Task({@required this.activity, @required this.isComplete});
  @override
  List<Object> get props => [activity, isComplete];
}
