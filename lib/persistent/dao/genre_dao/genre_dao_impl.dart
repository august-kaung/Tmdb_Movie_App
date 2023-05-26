import 'package:hive/hive.dart';
import 'package:tmdb_app/constant/hive_constant.dart';
import 'package:tmdb_app/data/vos/genre_vo/genre_vo.dart';
import 'package:tmdb_app/persistent/dao/genre_dao/genre_dao.dart';

class GenreDAOImpl extends GenreDAO {
  @override
  List<GenreVO>? getGenreListFromDataBase() {
    final genreList = _getGenreBox().values.toList();
    if (genreList.isNotEmpty) {
      final temp = genreList.first;
      genreList.removeAt(0);
      temp.isSelect = true;
      genreList.insert(0, temp);
    }
    return genreList;
  }

  @override
  Stream<List<GenreVO>?> getGenreListFromDataBaseStream() =>
      Stream.value(getGenreListFromDataBase());

  @override
  void save(List<GenreVO> genre) {
    for (GenreVO genreVO in genre) {
      _getGenreBox().put(genreVO.id, genreVO);
    }
  }

  @override
  Stream watchGenreBox() => _getGenreBox().watch();

  Box<GenreVO> _getGenreBox() => Hive.box(kBoxNameForGenreVO);

  @override
  void clearGenreBox() => _getGenreBox().clear();

  @override
  String getGenresListByID(List<int> genresID) {
    List<String> result = [];
    final genreList = _getGenreBox().values.toList();
    for (var element1 in genreList) {
      for (var element2 in genresID) {
        if (element1.id == element2) {
          result.add(element1.name ?? '');
        }
      }
    }
    return result.join(',');
  }
}
