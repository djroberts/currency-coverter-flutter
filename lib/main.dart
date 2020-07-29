import 'dart:convert';

import 'package:currency_converter/tabs/converter/converter.dart';
import 'package:currency_converter/tabs/currencies/currencies.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final HttpLink httpLink = HttpLink(
    uri: 'https://z69m3.sse.codesandbox.io',
  );

  final Link link = httpLink;

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      cache: InMemoryCache(),
      link: link,
    ),
  );

  runApp(CurrencyConverter(client));
}

class CurrencyConverter extends StatelessWidget {
  final ValueNotifier<GraphQLClient> client;

  CurrencyConverter(this.client);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Currency converter',
        home: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    CurrencyWidget(Colors.deepOrange),
    ConverterWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency converter'),
      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped, // new
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              title: Text('Currencies'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Converter'),
            ),
          ]),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
