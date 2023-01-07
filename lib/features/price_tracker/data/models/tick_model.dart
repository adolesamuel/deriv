import 'package:deriv/features/price_tracker/domain/entity/tick.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tick_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TickModel extends Tick {
  TickModel(
      {required super.ask,
      required super.bid,
      required super.epoch,
      required super.id,
      required super.pipSize,
      required super.quote,
      required super.symbol});

  factory TickModel.fromJson(Map<String, dynamic> json) =>
      _$TickModelFromJson(json);

  Map<String, dynamic> toJson() => _$TickModelToJson(this);
}
