class Tick {
  final double ask;
  final double bid;
  final int epoch;
  final String id;
  final int pipSize;
  final double quote;
  final String symbol;

  Tick({
    required this.ask,
    required this.bid,
    required this.epoch,
    required this.id,
    required this.pipSize,
    required this.quote,
    required this.symbol,
  });
}
