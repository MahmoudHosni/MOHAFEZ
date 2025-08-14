import 'package:floor/floor.dart';
import '../../../entity/user/Note.dart';

@dao
abstract class NoteDao{
  @Query("select * from note")
  Future<List<Note>> getNotes();

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertNote(Note note);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateNote(Note note);

  @Query('DELETE FROM note WHERE aya_ID=:ayaID')
  Future<void> deleteNote(int ayaID);

  @Query("select * from note where aya_ID=:ayaID")
  Future<Note?> isNoteExist(int ayaID);
}