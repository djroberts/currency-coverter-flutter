import 'package:bloc/bloc.dart';
import 'package:currency_converter/services/ConvertService.dart';
import 'package:currency_converter/tabs/currencies/currencies.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CurrenciesCubit extends Cubit<List<OverviewCurrency>> {
  final GraphQLClient client;

  CurrenciesCubit(this.client) : super([]);

  void fetchCurrencies() {
    client
        .query(QueryOptions(
      documentNode: gql(readCurrencies),
      variables: {},
      pollInterval: 10,
    ))
        .then((QueryResult queryResult) {
      List<OverviewCurrency> overviewCurrencies =
          queryResult.data['currencies'].where((item) {
        return item['toDollar'] != null;
      }).map<OverviewCurrency>((item) {
        return OverviewCurrency(
          name: item['name'],
          toDollar:
              item['toDollar'] != null ? item['toDollar'].toDouble() : null,
        );
      }).toList();

      emit(overviewCurrencies);
    });
  }
}
