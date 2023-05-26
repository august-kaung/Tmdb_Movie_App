import 'package:hive/hive.dart';
import 'package:tmdb_app/persistent/dao/search_history_dao/search_history_dao.dart';

import '../../../constant/hive_constant.dart';

class SearchHistoryDAOImpl extends SearchHistoryDAO {
  SearchHistoryDAOImpl._();

  static final SearchHistoryDAOImpl _singleton = SearchHistoryDAOImpl._();

  factory SearchHistoryDAOImpl() => _singleton;

  @override
  List<String>? getSearchHistory() => _getSearchHistoryBox().values.toList();

  @override
  void save(String query) {
    _getSearchHistoryBox().put(DateTime.now().microsecondsSinceEpoch, query);
  }

  Box<String> _getSearchHistoryBox() =>
      Hive.box<String>(kBoxNameForSearchHistoryVO);
}
