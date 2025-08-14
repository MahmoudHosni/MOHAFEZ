import 'package:floor/floor.dart';

@entity
class LastSearching {

  @primaryKey
  final int id;

  final String searchText;

  LastSearching({
    required this.id,
    required this.searchText,
  });
}
