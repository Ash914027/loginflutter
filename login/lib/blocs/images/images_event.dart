import 'package:equatable/equatable.dart';
abstract class ImagesEvent extends Equatable {
  const ImagesEvent();
  @override List<Object?> get props => [];
}
class ImagesRequested extends ImagesEvent {
  final int limit;
  const ImagesRequested({this.limit = 10});
  @override List<Object?> get props => [limit];
}
