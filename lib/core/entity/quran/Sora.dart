import 'package:floor/floor.dart';

@entity
class Sora {
  @primaryKey
  final int Id;
  final String Name;
  final int AyatCount;
  final int PageNum;
  final int Type;
  final String SearchText;
  final String name_ar;
  final String name_en;
  final int start_aya;
  final int end_aya;

  Sora(
      this.Id,
      this.Name,
      this.AyatCount,
      this.PageNum,
      this.Type,
      this.SearchText,
      this.name_ar,
      this.name_en,
      this.start_aya,
      this.end_aya);
}
