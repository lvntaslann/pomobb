import '../model/content_model.dart';
import '../constants/mock_contents.dart';

class ContentServices {
  final List<ContentModel> _contents = List.from(mockContents);

  Future<List<ContentModel>> getAllContent() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_contents);
  }

  Future<void> addContent(ContentModel content) async {
    _contents.add(content);
  }

  Future<void> deleteContent(int contentId) async {
    _contents.removeWhere((c) => c.id == contentId);
  }

  Future<void> updateContent(ContentModel updated) async {
    final index = _contents.indexWhere((c) => c.id == updated.id);
    if (index != -1) {
      _contents[index] = updated;
    }
  }
}
