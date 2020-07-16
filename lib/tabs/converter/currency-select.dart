import 'package:currency_converter/tabs/converter/converter.dart';
import 'package:flutter/material.dart';

class CurrencySelectWidget extends StatelessWidget {
  String dropdownValue;
  List<Currency> items = [];
  SetDropdownValue setDropdownValue;
  CurrencySelectWidget(this.dropdownValue, this.items, this.setDropdownValue);

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
      items: items
          .map<DropdownMenuItem<String>>((Currency value) {
        return DropdownMenuItem<String>(
          value: value.isoCode,
          child: Text(value.isoCode),
        );
      }).toList(),
    );
  }
}
