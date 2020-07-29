import 'package:currency_converter/tabs/currencies/currencies-cubit.dart';
import 'package:currency_converter/tabs/currencies/currencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrenciesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.bloc<CurrenciesCubit>().fetchCurrencies();

    return BlocBuilder<CurrenciesCubit, List<OverviewCurrency>>(
        builder: (BuildContext context, List<OverviewCurrency> currencies) {
          return ListView.builder(
            itemCount: currencies.length,
            itemBuilder: (BuildContext context, int index) {
              final currency = currencies[index];
              String o = currency.name;

              if (currency.toDollar != null) {
                o += ' ' + currency.toDollar.toString();
              }

              return Text(o);
            },
          );
        }
    );
  }
}
