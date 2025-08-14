import 'package:floor/floor.dart';

@entity
class Note{
  @PrimaryKey(autoGenerate:true) int? ID;
  final String note_txt;
  final int aya_ID;

  Note({
    this.ID,
    required this.note_txt,
    required this.aya_ID
  });
}