import 'package:currency_converter/models/currency.dart';
import 'package:flutter/material.dart';

typedef void SetDropdownValue(String value);

class CurrencySelect extends StatelessWidget {
  final String dropdownValue;
  final List<Currency> items;
  final SetDropdownValue setDropdownValue;

  CurrencySelect(
      {@required this.dropdownValue,
      @required this.items,
      @required this.setDropdownValue});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setDropdownValue(newValue);
      },
      items: items.map<DropdownMenuItem<String>>((Currency value) {
        return DropdownMenuItem<String>(
          value: value.isoCode,
          child: Text(value.isoCode),
        );
      }).toList(),
    );
  }
}
