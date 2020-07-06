import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CurrencyWidget extends StatelessWidget {
  String readCurrencies = """
  query{
    currencies {
      id
      isoCode
      name
      unitSymbols
      toDollar: convert(amount: 1, to: "USD")
    }
  }
""";

  final Color color;

  CurrencyWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        documentNode: gql(readCurrencies),
        // this is the query string you just created
        variables: {
          'nRepositories': 50,
        },
        pollInterval: 10,
      ),
      // Just like in apollo refetch() could be used to manually trigger a refetch
      // while fetchMore() can be used for pagination purpose
      builder: (QueryResult result,
          { VoidCallback refetch, FetchMore fetchMore }) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.loading) {
          return Text('Loading');
        }

        // it can be either Map or List
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
