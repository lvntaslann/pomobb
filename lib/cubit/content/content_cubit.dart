import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/content_model.dart';
import '../../services/content_services.dart';
import 'content_state.dart';

class ContentCubit extends Cubit<ContentState> {
  final ContentServices _contentServices;

  ContentCubit(this._contentServices) : super(const ContentState());

  Future<void> getAllContent() async {
    emit(state.copyWith(isLoading: true));
    try {
      final contents = await _contentServices.getAllContent();
      emit(state.copyWith(isLoading: false, allContent: contents));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> addContent(ContentModel content) async {
    emit(state.copyWith(isLoading: true, isAdded: false));
    try {
      await _contentServices.addContent(content);
      final contents = await _contentServices.getAllContent();
      emit(state.copyWith(isLoading: false, isAdded: true, allContent: contents));
    } catch (e) {
      emit(state.copyWith(isLoading: false, isAdded: false, errorMessage: e.toString()));
    }
  }

  Future<void> deleteContent(int contentId) async {
    emit(state.copyWith(isDeleted: false));
    try {
      await _contentServices.deleteContent(contentId);
      final contents = await _contentServices.getAllContent();
      emit(state.copyWith(isDeleted: true, allContent: contents));
    } catch (e) {
      emit(state.copyWith(isDeleted: false, errorMessage: e.toString()));
    }
  }

  Future<void> updateContent(ContentModel updatedContent) async {
    emit(state.copyWith(isUpdated: false));
    try {
      await _contentServices.updateContent(updatedContent);
      final contents = await _contentServices.getAllContent();
      emit(state.copyWith(isUpdated: true, allContent: contents));
    } catch (e) {
      emit(state.copyWith(isUpdated: false, errorMessage: e.toString()));
    }
  }
}
