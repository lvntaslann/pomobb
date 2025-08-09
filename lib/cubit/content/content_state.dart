import 'package:pomobb/model/content_model.dart';

class ContentState {
  final bool isLoading;
  final bool isAdded;
  final bool isDeleted;
  final bool isUpdated;
  final String? errorMessage;
  final List<ContentModel> allContent;

  const ContentState({
    this.isLoading = false,
    this.isAdded = false,
    this.isDeleted = false,
    this.isUpdated = false,
    this.errorMessage,
    this.allContent = const [],
  });

  ContentState copyWith({
    bool? isLoading,
    bool? isAdded,
    bool? isDeleted,
    bool? isUpdated,
    String? errorMessage,
    List<ContentModel>? allContent,
  }) {
    return ContentState(
      isLoading: isLoading ?? this.isLoading,
      isAdded: isAdded ?? this.isAdded,
      isDeleted: isDeleted ?? this.isDeleted,
      isUpdated: isUpdated ?? this.isUpdated,
      errorMessage: errorMessage,
      allContent: allContent ?? this.allContent,
    );
  }
}
