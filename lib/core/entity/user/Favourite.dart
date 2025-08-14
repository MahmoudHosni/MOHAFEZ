import 'package:floor/floor.dart';

@entity
class Favourite{
  @PrimaryKey(autoGenerate:true) int? ID;
  int aya_ID;


   Favourite({
      this.ID,
    required this.aya_ID,
  });
}