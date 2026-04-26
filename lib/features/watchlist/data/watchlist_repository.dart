import '../domain/entities/stock.dart';
import 'stocks_data.dart';

class WatchlistRepository {
  List<Stock> _stocks = List.from(stocksData);

  List<Stock> getWatchlist() => List.from(_stocks);

  List<Stock> reorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex--;

    final item = _stocks.removeAt(oldIndex);
    _stocks.insert(newIndex, item);

    return List.from(_stocks);
  }

  List<Stock> delete(int index) {
    if (index >= 0 && index < _stocks.length) {
      _stocks.removeAt(index);
    }
    return List.from(_stocks);
  }

  List<Stock> updateWatchlist(List<Stock> stocks) {
    _stocks = List.from(stocks);
    return List.from(_stocks);
  }
}
