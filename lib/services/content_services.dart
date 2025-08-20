// content_services.dart

import 'package:hive/hive.dart';
import '../model/content_model.dart';

class ContentServices {
  final Box<ContentModel> contentBox;

  ContentServices({required this.contentBox});

  Future<List<ContentModel>> getAllContent() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return contentBox.values.toList();
  }

  Future<void> addContent(ContentModel content) async {

    await contentBox.add(content);
  }

  Future<void> deleteContent(int contentId) async {
    final contentToDelete = contentBox.values.firstWhere(
      (content) => content.id == contentId,
    );
    await contentToDelete.delete();
  }

  Future<void> updateContent(ContentModel updated) async {
    await updated.save();
  }

  Future<void> clearAll() async {
    await contentBox.clear();
  }
}