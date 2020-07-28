import 'package:graphql_flutter/graphql_flutter.dart';

class CurrencyService {
  final String readCurrencies = """
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

  final String readClient = """
    query{
      client {
        ipAddress {
          country {
            name
            currencies {
              name
              isoCode
            }
          }
        }
      }
    }
""";

  final HttpLink httpLink = HttpLink(
    uri: 'https://api.everbase.co/graphql',
  );

  GraphQLClient _client;

  CurrencyService() {
    _client = GraphQLClient(
      cache: InMemoryCache(),
      link: httpLink,
    );
  }

  Future<QueryResult> getCurrencies() {
    return _client.query(QueryOptions(
      documentNode: gql(readCurrencies),
      variables: {},
      pollInterval: 10,
    ));
  }

  Future<QueryResult> getClientInfo() {
    return _client.query(QueryOptions(
      documentNode: gql(readClient),
      variables: {},
      pollInterval: 10,
    ));
  }
}
