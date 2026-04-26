import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/watchlist_bloc.dart';
import '../bloc/watchlist_state.dart';
import '../bloc/watchlist_event.dart';

class EditWatchlistPage extends StatefulWidget {
  final String watchlistName;

  const EditWatchlistPage({super.key, required this.watchlistName});

  @override
  State<EditWatchlistPage> createState() => _EditWatchlistPageState();
}

class _EditWatchlistPageState extends State<EditWatchlistPage> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.watchlistName);
  }


  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _showRenameDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Rename Watchlist'),
        content: TextField(
          controller: _nameController,
          decoration: const InputDecoration(hintText: "Enter watchlist name"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {});
              Navigator.pop(context);
            },
            child: const Text('Rename'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Edit ${_nameController.text}',
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: BlocBuilder<WatchlistBloc, WatchlistState>(
        builder: (context, state) {
          if (state is! WatchlistLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          final stocks = state.stocks;

          return Column(
            children: [
              InkWell(
                onTap: _showRenameDialog,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _nameController.text,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Icon(Icons.edit, color: Colors.grey, size: 20),
                    ],
                  ),
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: ReorderableListView.builder(
                  itemCount: stocks.length,
                  onReorder: (oldIndex, newIndex) {
                    context
                        .read<WatchlistBloc>()
                        .add(ReorderWatchlist(oldIndex, newIndex));
                  },
                  itemBuilder: (context, index) {
                    final stock = stocks[index];
                    return ListTile(
                      key: ValueKey(stock.id),
                      leading: ReorderableDragStartListener(
                        index: index,
                        child: const Icon(Icons.menu, color: Colors.grey),
                      ),

                      title: Text(
                        stock.id,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '${stock.exchange} • ${stock.name}',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                stock.price.toStringAsFixed(2),
                                style: TextStyle(
                                  color: stock.percentageChange >= 0
                                      ? Colors.green
                                      : Colors.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "${stock.percentageChange > 0 ? '+' : ''}${stock.percentageChange.toStringAsFixed(2)}%",
                                style: TextStyle(
                                  color: stock.percentageChange >= 0
                                      ? Colors.green
                                      : Colors.red,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.black),
                            onPressed: () {
                              context
                                  .read<WatchlistBloc>()
                                  .add(DeleteStock(index));
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        side: const BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Edit other watchlists',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Done',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
