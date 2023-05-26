import 'package:tmdb_app/data/vos/genre_vo/genre_vo.dart';

abstract class GenreDAO {
  void save(List<GenreVO> genre);

  List<GenreVO>? getGenreListFromDataBase();

  Stream<List<GenreVO>?> getGenreListFromDataBaseStream();

  Stream watchGenreBox();

  void clearGenreBox();

  String getGenresListByID(List<int> genresID);
}
