import 'package:currency_converter/bloc/converter/converter-bloc.dart';
import 'package:currency_converter/bloc/converter/converter-state.dart';
import 'package:currency_converter/tabs/converter/currency-select.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConverterView extends StatelessWidget {
  void setDropdownValue(value) {
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConverterBloc, ConverterState>(
        builder: (context, state) {
      return CurrencySelect(
        dropdownValue:
            state.fromCurrency != null ? state.fromCurrency.isoCode : null,
        items: state.currencyItems,
        setDropdownValue: setDropdownValue,
      );
    });
  }
}
