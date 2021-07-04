import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ColorState extends Equatable {
  final Color color;
  ColorState({required this.color});

  @override
  List<Object> get props => [color];

  @override
  bool get stringify => true;

  ColorState copyWith({
    Color? color,
  }) {
    return ColorState(
      color: color ?? this.color,
    );
  }
}
