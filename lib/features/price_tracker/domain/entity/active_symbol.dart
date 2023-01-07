import 'package:equatable/equatable.dart';

class ActiveSymbol extends Equatable {
  final int allowForwardStarting;
  final String displayName;
  final int displayOrder;
  final int exchangeIsOpen;
  final int isTradingSuspended;
  final String market;
  final String marketDisplayName;
  final double pip;
  final String subgroup;
  final String subgroupDisplayName;
  final String submarket;
  final String submarketDisplayName;
  final String symbol;
  final String symbolType;

  ActiveSymbol({
    required this.allowForwardStarting,
    required this.displayName,
    required this.displayOrder,
    required this.exchangeIsOpen,
    required this.isTradingSuspended,
    required this.market,
    required this.marketDisplayName,
    required this.pip,
    required this.subgroup,
    required this.subgroupDisplayName,
    required this.submarket,
    required this.submarketDisplayName,
    required this.symbol,
    required this.symbolType,
  });

  @override
  String toString() {
    return symbol;
  }

  @override
  List<Object?> get props => [symbol];
}
