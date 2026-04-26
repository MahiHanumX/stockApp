import 'package:equatable/equatable.dart';

class Stock extends Equatable {
  final String id;
  final String name;
  final double price;
  final double percentageChange;
  final String exchange;

  const Stock({
    required this.id,
    required this.name,
    required this.price,
    this.percentageChange = 0.0,
    this.exchange = 'NSE | EQ',
  });

  @override
  List<Object?> get props => [id, name, price, percentageChange, exchange];
}
