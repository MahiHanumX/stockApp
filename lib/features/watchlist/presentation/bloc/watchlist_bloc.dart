import 'package:flutter_bloc/flutter_bloc.dart';
import 'watchlist_event.dart';
import 'package:stock_watchlist_bloc/features/watchlist/data/watchlist_repository.dart';
import 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final WatchlistRepository repository;

  WatchlistBloc(this.repository) : super(WatchlistLoading()) {
    on<LoadWatchlist>((event, emit) {
      final stocks = repository.getWatchlist();
      emit(WatchlistLoaded(stocks));
    });

    on<ReorderWatchlist>((event, emit) {
      if (state is WatchlistLoaded) {
        final updated = repository.reorder(event.oldIndex, event.newIndex);
        emit(WatchlistLoaded(updated));
      }
    });

    on<DeleteStock>((event, emit) {
      if (state is WatchlistLoaded) {
        final updated = repository.delete(event.index);
        emit(WatchlistLoaded(updated));
      }
    });

    on<UpdateWatchlist>((event, emit) {
      final updated = repository.updateWatchlist(event.stocks);
      emit(WatchlistLoaded(updated));
    });
  }
}
