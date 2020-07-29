import 'package:flutter/cupertino.dart';

@immutable
abstract class ConverterEvent {
  ConverterEvent();
}

class ConverterItemsLoaded extends ConverterEvent {}
