import 'package:bloc/bloc.dart';
import 'package:currency_converter/services/ConvertService.dart';
import 'package:currency_converter/tabs/currencies/currencies.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CurrenciesCubit extends Cubit<List<OverviewCurrency>> {
  CurrenciesCubit() : super([]);

  void fetchCurrencies() {
    ConvertService().getCurrencies().then((QueryResult queryResult) {
      List<OverviewCurrency> overviewCurrencies =
      queryResult.data['currencies'].where((item) {
        return item['toDollar'] != null;
      }).map<OverviewCurrency>((item) {
        return OverviewCurrency(
          name: item['name'],
          toDollar: item['toDollar'] != null ? item['toDollar'].toDouble() : null,
        );
      }).toList();

      emit(overviewCurrencies);
    });
  }
}
