// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tick_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TickModel _$TickModelFromJson(Map<String, dynamic> json) => TickModel(
      ask: (json['ask'] as num).toDouble(),
      bid: (json['bid'] as num).toDouble(),
      epoch: json['epoch'] as int,
      id: json['id'] as String,
      pipSize: json['pip_size'] as int,
      quote: (json['quote'] as num).toDouble(),
      symbol: json['symbol'] as String,
    );

Map<String, dynamic> _$TickModelToJson(TickModel instance) => <String, dynamic>{
      'ask': instance.ask,
      'bid': instance.bid,
      'epoch': instance.epoch,
      'id': instance.id,
      'pip_size': instance.pipSize,
      'quote': instance.quote,
      'symbol': instance.symbol,
    };
