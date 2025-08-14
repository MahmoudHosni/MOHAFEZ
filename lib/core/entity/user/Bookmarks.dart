import 'package:floor/floor.dart';

@entity
class Bookmarks{
  @PrimaryKey(autoGenerate:true) int? ID;
  final int aya_ID;
  final String name;
  final String type;

   Bookmarks({
     this.ID,
    required this.aya_ID,required this.name,required this.type
  });
}