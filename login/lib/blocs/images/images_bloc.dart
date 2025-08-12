import 'package:flutter_bloc/flutter_bloc.dart';
import 'images_event.dart';
import 'images_state.dart';
import '../../repositories/picsum_repository.dart';

class ImagesBloc extends Bloc<ImagesEvent, ImagesState> {
  final PicsumRepository repository;
  ImagesBloc({required this.repository}) : super(const ImagesState()) {
    on<ImagesRequested>((event, emit) async {
      emit(state.copyWith(status: ImagesStatus.loading));
      try {
        final imgs = await repository.getImages(limit: event.limit);
        emit(state.copyWith(status: ImagesStatus.success, images: imgs));
      } catch (e) {
        emit(state.copyWith(status: ImagesStatus.failure, message: e.toString()));
      }
    });
  }
}
