import 'package:bloc/bloc.dart';
import 'package:currency_converter/bloc/converter/converter-event.dart';
import 'package:currency_converter/bloc/converter/converter-state.dart';
import 'package:currency_converter/models/currency.dart';
import 'package:currency_converter/services/ConvertService.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ConverterBloc extends Bloc<ConverterEvent, ConverterState> {
  GraphQLClient client;

  ConverterBloc(this.client) : super(ConverterState.initial());

  @override
  Stream<ConverterState> mapEventToState(
    ConverterEvent event,
  ) async* {
    if (event is ConverterItemsLoaded) {
      yield* _mapConverterItemsLoadedToState();
    }
  }

  Stream<ConverterState> _mapConverterItemsLoadedToState() async* {
    // todo: set loading status
    final QueryResult result = await client.query(QueryOptions(
      documentNode: gql(readCurrencies),
      variables: {},
      pollInterval: 10,
    ));

    List<Currency> currencies = result.data['currencies'].map<Currency>((item) {
      return new Currency(
          id: item['id'], isoCode: item['isoCode'], name: item['name']);
    }).toList();

    yield ConverterState.converterItemsLoadedSuccess(fromCurrency: state.fromCurrency, currencyItems: currencies);
  }
}
