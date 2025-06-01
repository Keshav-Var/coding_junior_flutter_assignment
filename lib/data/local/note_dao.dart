import 'package:notes/core/service/database_service.dart';
import 'package:notes/model/note_model.dart';

class NoteDao {
  final db = DatabaseService.to.database;

  Future<Iterable<Note>> getAllNotes() async {
    final maps = await db.query('notes', orderBy: 'updatedAt DESC');
    return maps.map((map) => Note.fromMap(map));
  }

  Future<int> insertNote(Note note) async {
    return await db.insert('notes', note.toMap());
  }

  Future<int> updateNote(Note note) async {
    return await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(int id) async {
    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  Future<Note?> getNoteById(int id) async {
    final result = await db.query(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (result.isNotEmpty) {
      return Note.fromMap(result.first);
    }
    return null;
  }

  Future<Iterable<Note>> searchNotes(String keyword) async {
    final maps = await db.query(
      'notes',
      where: 'title LIKE ? OR content LIKE ?',
      whereArgs: ['%$keyword%', '%$keyword%'],
      orderBy: 'updatedAt DESC',
    );
    return maps.map((map) => Note.fromMap(map));
  }

  Future<Iterable<Note>> getNotesSortedByTitle() async {
    final maps = await db.query('notes', orderBy: 'title COLLATE NOCASE ASC');
    return maps.map((map) => Note.fromMap(map));
  }
}
