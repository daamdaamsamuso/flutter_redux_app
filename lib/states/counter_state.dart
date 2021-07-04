import 'package:equatable/equatable.dart';

class CounterState extends Equatable {
  final int counter;
  CounterState({required this.counter});

  @override
  List<Object> get props => [counter];

  @override
  bool get stringify => true;

  CounterState copyWith({
    int? counter,
  }) {
    return CounterState(
      counter: counter ?? this.counter,
    );
  }
}
