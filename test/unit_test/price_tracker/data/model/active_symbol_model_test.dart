import 'package:deriv/features/price_tracker/data/models/active_symbol_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("ActiveSymbol Model Class Test", () {
    //Arrange
    Map<String, dynamic> activeSymbolJson = {
      "allow_forward_starting": 1,
      "display_name": "AUD/USD",
      "display_order": 2,
      "exchange_is_open": 0,
      "is_trading_suspended": 0,
      "market": "forex",
      "market_display_name": "Forex",
      "pip": 1e-05,
      "subgroup": "none",
      "subgroup_display_name": "None",
      "submarket": "major_pairs",
      "submarket_display_name": "Major Pairs",
      "symbol": "frxAUDUSD",
      "symbol_type": "forex"
    };

    ActiveSymbolModel activeSymbolModel = const ActiveSymbolModel(
        allowForwardStarting: 1,
        displayName: "AUD/USD",
        displayOrder: 2,
        exchangeIsOpen: 0,
        isTradingSuspended: 0,
        market: "forex",
        marketDisplayName: "Forex",
        pip: 1e-05,
        subgroup: "none",
        subgroupDisplayName: "None",
        submarket: "major_pairs",
        submarketDisplayName: "Major Pairs",
        symbol: "frxAUDUSD",
        symbolType: "forex");
  });
}
