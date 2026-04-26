import '../../domain/entities/stock.dart';

abstract class WatchlistState {}

class WatchlistLoading extends WatchlistState {}

class WatchlistLoaded extends WatchlistState {
  final List<Stock> stocks;

  WatchlistLoaded(this.stocks);
}
