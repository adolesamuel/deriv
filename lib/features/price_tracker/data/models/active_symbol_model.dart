import 'package:json_annotation/json_annotation.dart';

part 'active_symbol_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ActiveSymbolModel {
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

  ActiveSymbolModel({
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

  factory ActiveSymbolModel.fromJson(Map<String, dynamic> json) =>
      _$ActiveSymbolModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActiveSymbolModelToJson(this);
}
