import 'package:equatable/equatable.dart';
import '../../models/picsum_image.dart';

enum ImagesStatus { initial, loading, success, failure }

class ImagesState extends Equatable {
  final ImagesStatus status;
  final List<PicsumImage> images;
  final String? message;
  const ImagesState({
    this.status = ImagesStatus.initial,
    this.images = const [],
    this.message,
  });

  ImagesState copyWith({
    ImagesStatus? status,
    List<PicsumImage>? images,
    String? message,
  }) {
    return ImagesState(
      status: status ?? this.status,
      images: images ?? this.images,
      message: message ?? this.message,
    );
  }

  @override List<Object?> get props => [status, images, message];
}
