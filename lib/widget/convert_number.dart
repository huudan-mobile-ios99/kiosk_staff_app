import 'package:intl/intl.dart';

String formatDouble(dynamic value) {
  double number;
  // Check if the value is a string and convert it to double
  if (value is String) {
    try {
      number = double.parse(value.replaceAll(',', ''));
    } catch (e) {
      return 'Invalid number';
    }
  } else if (value is double) {
    number = value;
  } else {
    return 'Invalid type';
  }
  final NumberFormat formatter = NumberFormat('#,##0', 'en_US');

  bool isNegative = number < 0;
  if (value == value.toInt()) {
    return formatter.format(value.toInt());
  } else {
    String formattedValue = value.toStringAsFixed(2);
    List<String> parts = formattedValue.split('.');
    // Integer part
    String integerPart = parts[0];
    // Decimal part
    String decimalPart = parts[1];
    // Create a NumberFormat instance to format the integer part with commas

    String formattedIntegerPart = formatter.format(int.parse(integerPart));

    String result = isNegative
        ? '$formattedIntegerPart.$decimalPart'
        : '$formattedIntegerPart.$decimalPart';

    // debugPrint('result : $result');
    return result;
    // return formattedValue;
  }
}
