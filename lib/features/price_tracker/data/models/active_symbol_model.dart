import 'package:deriv/features/price_tracker/domain/entity/active_symbol.dart';
import 'package:json_annotation/json_annotation.dart';

part 'active_symbol_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ActiveSymbolModel extends ActiveSymbol {
  ActiveSymbolModel({
    required super.allowForwardStarting,
    required super.displayName,
    required super.displayOrder,
    required super.exchangeIsOpen,
    required super.isTradingSuspended,
    required super.market,
    required super.marketDisplayName,
    required super.pip,
    required super.subgroup,
    required super.subgroupDisplayName,
    required super.submarket,
    required super.submarketDisplayName,
    required super.symbol,
    required super.symbolType,
  });

  factory ActiveSymbolModel.fromJson(Map<String, dynamic> json) =>
      _$ActiveSymbolModelFromJson(json);

  Map<String, dynamic> toJson() => _$ActiveSymbolModelToJson(this);
}
