import 'package:flutter/material.dart';
import 'package:weather_app/helpers/temperature_converter.dart';
import 'package:weather_app/utils/values/theme.dart';

class DegreesCelsiusValue extends StatelessWidget {
  DegreesCelsiusValue({
    super.key,
    required this.value,
    this.textStyle,
  });
  final CustomTheme theme = CustomTheme();
  final double value;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          TemperatureConverter.kelvinToCelsius(value).toString(),
          style: textStyle ?? theme.getPrimaryText,
        ),
        const SizedBox(
          width: 2,
        ),
        Baseline(
          baseline: 14.0,
          baselineType: TextBaseline.alphabetic,
          child: Text("\u00B0", style: textStyle ?? theme.getPrimaryText),
        ),
      ],
    );
  }
}
