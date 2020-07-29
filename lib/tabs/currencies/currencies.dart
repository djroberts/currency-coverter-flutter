import 'dart:ffi';

import 'package:currency_converter/tabs/currencies/currencies-cubit.dart';
import 'package:currency_converter/tabs/currencies/currencies-view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OverviewCurrency {
  final String name;
  final double toDollar;

  OverviewCurrency({this.name, this.toDollar});
}

class CurrencyWidget extends StatelessWidget {
  final Color color;

  CurrencyWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CurrenciesCubit(),
      child: CurrenciesView(),
    );
  }
}
