import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/data/local/note_dao.dart';
import 'package:notes/model/note_model.dart';
import 'package:notes/veiws/home/home_viewmodel.dart';

class NoteFormController extends GetxController {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final NoteDao _noteDao = NoteDao();

  late RxInt characterCount;

  final Rx<Note?> editingNote = Rx<Note?>(null);
  final RxBool isSaving = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Note) {
      editingNote.value = Get.arguments;
      titleController.text = editingNote.value!.title;
      contentController.text = editingNote.value!.content;
    }
      characterCount = contentController.text.length.obs;
  }

  void updateCharacterCount(String text) {
  characterCount.value = text.length;
}

  Future<void> saveNote() async {
    final title = titleController.text.trim();
    final content = contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      Get.snackbar('Validation Error', 'Title and content cannot be empty');
      return;
    }

    isSaving.value = true;

    final now = DateTime.now();

    if (editingNote.value == null) {
      // Creating a new note
      final newNote = Note(
        id: DateTime.now().millisecondsSinceEpoch, // Use a unique ID
        title: title,
        content: content,
        createdAt: now,
        updatedAt: now,
      );
      await _noteDao.insertNote(newNote);
    } else {
      // Updating existing note
      final updatedNote = Note(
        id: editingNote.value!.id,
        title: title,
        content: content,
        updatedAt: now,
        createdAt: editingNote.value!.createdAt,
      );

      await _noteDao.updateNote(updatedNote);
    }

    isSaving.value = false;
    Get.find<HomeController>().refreshNotes();
    Get.back(); 
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    super.onClose();
  }
}
