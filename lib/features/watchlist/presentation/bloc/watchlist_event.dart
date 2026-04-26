import '../../domain/entities/stock.dart';

abstract class WatchlistEvent {}

class LoadWatchlist extends WatchlistEvent {}

class ReorderWatchlist extends WatchlistEvent {
  final int oldIndex;
  final int newIndex;

  ReorderWatchlist(this.oldIndex, this.newIndex);
}

class DeleteStock extends WatchlistEvent {
  final int index;

  DeleteStock(this.index);
}

class UpdateWatchlist extends WatchlistEvent {
  final List<Stock> stocks;

  UpdateWatchlist(this.stocks);
}
