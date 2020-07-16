import 'package:graphql_flutter/graphql_flutter.dart';

class ConvertService {
  final String readConversion = """
   query Exchange(\$currency: String!, \$toCurrency: String!) {
        exchange(currency: \$currency, toCurrency: \$toCurrency) {
            currency
            name
            rate
        }
    }
""";


  final HttpLink httpLink = HttpLink(
    uri: 'https://z69m3.sse.codesandbox.io',
  );

  GraphQLClient _client;

  ConvertService() {
    _client = GraphQLClient(
      cache: InMemoryCache(),
      link: httpLink,
    );
  }

  Future<QueryResult> convertCurrency(String from, String to) {
    return _client.query(QueryOptions(
      documentNode: gql(readConversion),
      variables: {
        'currency': from,
        'toCurrency': to,
      },
    ));
  }
}
