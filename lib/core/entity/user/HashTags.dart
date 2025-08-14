import 'package:floor/floor.dart';

@entity
class HashTags{
  @PrimaryKey(autoGenerate:true) int? ID;
  final String name;
  final int ayaID;

  HashTags({this.ID,required this.name,required this.ayaID});
}