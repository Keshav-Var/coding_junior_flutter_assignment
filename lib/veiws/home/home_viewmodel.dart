import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notes/data/local/note_dao.dart';
import 'package:notes/model/note_model.dart';

class HomeController extends GetxController {
  final RxBool isDarkMode = Get.isDarkMode.obs;
  final RxList<Note> notes = <Note>[].obs;
  final RxBool isSortedByTitle = false.obs;
  final RxString query = ''.obs;
  final NoteDao _noteDao = NoteDao();
  Note? _recentlyDeleted;

  @override
  void onInit() {
    super.onInit();
    fetchNotes();
  }

  void changeChip() async {
  if (isSortedByTitle.value) {
    await resetSort();        
  } else {
    await sortByTitle();      
  }
}

void changeTheme() {
  final box = GetStorage();
  isDarkMode.value = !(box.read('isDarkMode')??false);
  box.write('isDarkMode', isDarkMode.value);
  Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
}


  Future<void> fetchNotes() async {
    final data = await _noteDao.getAllNotes();
    notes.assignAll(data);
  }

  Future<void> sortByTitle() async {
    final sortedData = await _noteDao.getNotesSortedByTitle();
    notes.assignAll(sortedData);
    isSortedByTitle.value = true;
  }

  Future<void> resetSort() async {
    await fetchNotes();
    isSortedByTitle.value = false;
  }

  Future<List<Note>> searchNotes(String query) async {
    final results = await _noteDao.searchNotes(query);
    notes.assignAll(results);
    return results.toList();
  }

  void refreshNotes() => fetchNotes();

  Future<void> deleteNoteWithUndo(BuildContext context, Note note) async {
    // Delete from DB
    await _noteDao.deleteNote(note.id!);
    _recentlyDeleted = note;
    notes.remove(note);

    // Show Snackbar
    Get.snackbar(
      "Note deleted",
      "You can restore it.",
      mainButton: TextButton(
        child: Text("UNDO"),
        onPressed: () async {
          await restoreLastDeleted();
        },
      ),
      duration: const Duration(seconds: 3),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> restoreLastDeleted() async {
    if (_recentlyDeleted != null) {
      await _noteDao.insertNote(_recentlyDeleted!);
      fetchNotes();
      _recentlyDeleted = null;
    }
  }
}
