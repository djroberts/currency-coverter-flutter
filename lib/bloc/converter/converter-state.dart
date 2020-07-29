import 'package:currency_converter/models/currency.dart';
import 'package:flutter/cupertino.dart';

class ConverterState {
  const ConverterState({
    @required this.fromCurrency,
    @required this.currencyItems,
  });

  final Currency fromCurrency;
  final List<Currency> currencyItems;

  const ConverterState.initial()
      : this(
          fromCurrency: null,
          currencyItems: const [],
        );

  const ConverterState.converterItemsLoadedSuccess(
      {@required Currency fromCurrency, @required List<Currency> currencyItems})
      : this(
          fromCurrency: fromCurrency,
          currencyItems: currencyItems,
        );
}
