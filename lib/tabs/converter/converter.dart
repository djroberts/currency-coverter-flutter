import 'package:currency_converter/services/ConvertService.dart';
import 'package:currency_converter/services/CurrencyService.dart';
import 'package:currency_converter/tabs/converter/currency-select.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Currency {
  final String id;
  final String isoCode;
  final String name;

  Currency(this.id, this.isoCode, this.name);
}

typedef void SetDropdownValue(String value);

class ConverterWidget extends StatefulWidget {
  ConverterWidget({Key key}) : super(key: key);

  @override
  _ConverterWidget createState() => _ConverterWidget();
}

class _ConverterWidget extends State<ConverterWidget> {
  String fromCurrency;
  String toCurrency;
  List<Currency> items = [];
  String converted;
  String amount;
  final amountController = TextEditingController();

  _ConverterWidget(): super() {
    amount = '';
    converted = '';
    CurrencyService service = new CurrencyService();
    service.getCurrencies().then((QueryResult result) {
      List<Currency> temp = result.data['currencies'].map<Currency>((item) {
        return new Currency(item['id'], item['isoCode'], item['name']);
      }).toList();

      setState(() {
        items = temp;
      });
    });

    service.getClientInfo().then((QueryResult result) {
      List clientCurrencies = result.data['client']['ipAddress']['country']['currencies'];
      if (clientCurrencies.length > 0) {
        setState(() {
          fromCurrency = clientCurrencies[0]['isoCode'];
        });
      }
    });
  }

  setFromCurrency(String value) {
    setState(() {
      fromCurrency = value;
    });
  }

  setToCurrency(String value) {
    setState(() {
      toCurrency = value;
    });
  }

  convert() {
    ConvertService service = new ConvertService();
    service.convertCurrency(fromCurrency, toCurrency).then((QueryResult value) {
      if (value.data != null && value.data['exchange'] != null) {
        print(value.data['exchange']);
        print(amount);
        setState(() {
          converted = (double.parse(amount) * double.parse(value.data['exchange']['rate'])).toStringAsFixed(2);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        new CurrencySelectWidget(fromCurrency, items, setFromCurrency),
        new CurrencySelectWidget(toCurrency, items, setToCurrency),
        RaisedButton(
          onPressed: convert,
          child: const Text('Convert', style: TextStyle(fontSize: 15)),
        ),
      ],
    ),
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                width: 100,
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Amount'
                  ),
                  onChanged: (text) {
                    amount = text;
                  },
                )
            ),
            new Text(converted),
          ]
      ),
    ]);
  }
}
