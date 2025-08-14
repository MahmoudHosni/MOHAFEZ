
import 'package:floor/floor.dart';

@Entity(tableName: "Languages")
class TranslationLanguage{
  @primaryKey
  final int LangID;
  final String Lang;
  final String Direction;
  final String Path;

  TranslationLanguage({required this.LangID,required this.Lang,required this.Direction,required this.Path});
}