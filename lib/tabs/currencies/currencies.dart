import 'package:currency_converter/services/CurrencyService.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CurrencyWidget extends StatelessWidget {
  final Color color;

  CurrencyWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QueryResult>(
      future: new CurrencyService().getCurrencies(),
      builder: (BuildContext context, AsyncSnapshot<QueryResult> queryResult) {
        QueryResult result = queryResult.data;

        if (result == null || result.loading) {
          return Text('Loading');
        }

        if (result.hasException) {
          return Text(result.exception.toString());
        }

        List currencies = result.data['currencies'];

        return ListView.builder(
            itemCount: currencies.length,
            itemBuilder: (context, index) {
              final currency = currencies[index];
              String o = currency['name'];
              if (currency['toDollar'] != null) {
                o += ' ' + currency['toDollar'].toString();
              }

              return Text(o);
            });
      },
    );
  }
}
