import 'package:floor/floor.dart';
import '../../../entity/user/Bookmarks.dart';

@dao
abstract class BookmarkDao{
  @Query("select * from bookmarks where type=:type")
  Future<List<Bookmarks>> getBookmarks(String type);

  @Query("select * from bookmarks  ")
  Future<List<Bookmarks>> getAllBookmarks( );

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertBookmark(Bookmarks bookmark);

  @update
  Future<void> updateBookmark(Bookmarks bookmark);

  @Query("select * from bookmarks where aya_ID=:ayaID")
  Future<Bookmarks?> isBookamrkExist(int ayaID);

  @delete
  Future<void> deleteBookmark(Bookmarks bookmark);
}