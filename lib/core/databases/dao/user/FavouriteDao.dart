import 'package:floor/floor.dart';
import '../../../entity/user/Favourite.dart';

@dao
abstract class FavouriteDao{
  @Query("select * from favourite")
  Future<List<Favourite>> getFavourites();

  @Insert(onConflict: OnConflictStrategy.ignore)
  Future<void> insertFavourite(Favourite favourite);

  @Update(onConflict: OnConflictStrategy.abort)
  Future<void> updateFavourite(Favourite favourite);

  @delete
  Future<void> deleteFavourite(Favourite favourite);

  @Query("select * from favourite where aya_ID=:ayaID")
  Future<Favourite?> isFavouriteExist(int ayaID);
}