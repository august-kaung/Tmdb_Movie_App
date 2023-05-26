abstract class SearchHistoryDAO {
  void save(String query);

  List<String>? getSearchHistory();
}
