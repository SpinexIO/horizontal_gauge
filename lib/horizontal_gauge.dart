library;

import 'package:flutter/material.dart';
import 'package:horizontal_gauge/scale_widget.dart';

///[HorizontalGaugeTheme] defines the visual properties of the horizontal gauge.
class HorizontalGaugeTheme {
  ///[backgroundColor] is the color of the gauge's background.
  final Color? backgroundColor;

  ///[borderColor] is the color of the gauge's border.
  final Color? borderColor;

  ///[titleColor] is the color of the gauge's title.
  final Color? titleColor;

  ///[valueColor] is the color of the gauge's value.
  final Color? valueColor;

  ///[unitColor] is the color of the gauge's unit.
  final Color? unitColor;

  ///[tickColor] is the color of the gauge's ticks.
  final Color? tickColor;

  ///[majorTickColor] is the color of the gauge's major ticks.
  final Color? majorTickColor;

  ///[labelColor] is the color of the gauge's labels.
  final Color? labelColor;

  ///[indicatorColor] is the color of the gauge's indicator.
  final Color? indicatorColor;

  ///[indicatorShadowColor] is the color of the gauge's indicator shadow.
  final Color? indicatorShadowColor;

  ///[titleStyle] is the text style of the gauge's title.
  final TextStyle? titleStyle;

  ///[valueStyle] is the text style of the gauge's value.
  final TextStyle? valueStyle;

  ///[unitStyle] is the text style of the gauge's unit.
  final TextStyle? unitStyle;

  ///[labelStyle] is the text style of the gauge's labels.
  final TextStyle? labelStyle;

  ///[indicatorWidth] is the width of the gauge's indicator.
  final double? indicatorWidth;

  ///[indicatorHeight] is the height of the gauge's indicator.
  final double? indicatorHeight;

  ///[tickHeight] is the height of the gauge's ticks.
  final double? tickHeight;

  ///[majorTickHeight] is the height of the gauge's major ticks.
  final double? majorTickHeight;

  ///[indicatorBorderRadius] is the border radius of the gauge's indicator.
  final BorderRadius? indicatorBorderRadius;

  ///[indicatorShadows] are the shadows of the gauge's indicator.
  final List<BoxShadow>? indicatorShadows;

  ///[backgroundGradient] is the gradient of the gauge's background.
  final Gradient? backgroundGradient;

  ///[indicatorGradient] is the gradient of the gauge's indicator.
  final Gradient? indicatorGradient;

  const HorizontalGaugeTheme({
    this.backgroundColor,
    this.borderColor,
    this.titleColor,
    this.valueColor,
    this.unitColor,
    this.tickColor,
    this.majorTickColor,
    this.labelColor,
    this.indicatorColor,
    this.indicatorShadowColor,
    this.titleStyle,
    this.valueStyle,
    this.unitStyle,
    this.labelStyle,
    this.indicatorWidth,
    this.indicatorHeight,
    this.tickHeight,
    this.majorTickHeight,
    this.indicatorBorderRadius,
    this.indicatorShadows,
    this.backgroundGradient,
    this.indicatorGradient,
  });

  HorizontalGaugeTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    Color? titleColor,
    Color? valueColor,
    Color? unitColor,
    Color? tickColor,
    Color? majorTickColor,
    Color? labelColor,
    Color? indicatorColor,
    Color? indicatorShadowColor,
    TextStyle? titleStyle,
    TextStyle? valueStyle,
    TextStyle? unitStyle,
    TextStyle? labelStyle,
    double? indicatorWidth,
    double? indicatorHeight,
    double? tickHeight,
    double? majorTickHeight,
    BorderRadius? indicatorBorderRadius,
    List<BoxShadow>? indicatorShadows,
    Gradient? backgroundGradient,
    Gradient? indicatorGradient,
  }) {
    return HorizontalGaugeTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      titleColor: titleColor ?? this.titleColor,
      valueColor: valueColor ?? this.valueColor,
      unitColor: unitColor ?? this.unitColor,
      tickColor: tickColor ?? this.tickColor,
      majorTickColor: majorTickColor ?? this.majorTickColor,
      labelColor: labelColor ?? this.labelColor,
      indicatorColor: indicatorColor ?? this.indicatorColor,
      indicatorShadowColor: indicatorShadowColor ?? this.indicatorShadowColor,
      titleStyle: titleStyle ?? this.titleStyle,
      valueStyle: valueStyle ?? this.valueStyle,
      unitStyle: unitStyle ?? this.unitStyle,
      labelStyle: labelStyle ?? this.labelStyle,
      indicatorWidth: indicatorWidth ?? this.indicatorWidth,
      indicatorHeight: indicatorHeight ?? this.indicatorHeight,
      tickHeight: tickHeight ?? this.tickHeight,
      majorTickHeight: majorTickHeight ?? this.majorTickHeight,
      indicatorBorderRadius:
          indicatorBorderRadius ?? this.indicatorBorderRadius,
      indicatorShadows: indicatorShadows ?? this.indicatorShadows,
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
      indicatorGradient: indicatorGradient ?? this.indicatorGradient,
    );
  }
}

///[TitleBuilder] is a function that builds the title widget.
typedef TitleBuilder =
    Widget Function(BuildContext context, String title, double value);

///[ValueBuilder] is a function that builds the value widget.
typedef ValueBuilder =
    Widget Function(BuildContext context, double value, String unit);

///[IndicatorBuilder] is a function that builds the indicator widget.
typedef IndicatorBuilder =
    Widget Function(
      BuildContext context,
      double value,
      double min,
      double max,
      Color color,
    );

///[TickBuilder] is a function that builds the tick widget.
typedef TickBuilder =
    Widget Function(
      Canvas canvas,
      Size size,
      double min,
      double max,
      double value,
      Size screenSize,
    );

///[HorizontalGauge] is a widget that displays a horizontal gauge.
class HorizontalGauge extends StatefulWidget {
  ///[title] is the title of the gauge.
  final String title;

  ///[min] is the minimum value of the gauge.
  final double min;

  ///[max] is the maximum value of the gauge.
  final double max;

  ///[value] is the current value of the gauge.
  final double value;

  ///[unit] is the unit of the gauge's value.
  final String unit;

  ///[color] is the color of the gauge.
  final Color color;

  ///[onChanged] is a callback that is called when the gauge's value changes.
  final ValueChanged<double>? onChanged;

  ///[height] is the height of the gauge.
  final double? height;

  ///[padding] is the padding of the gauge.
  final EdgeInsetsGeometry? padding;

  ///[borderRadius] is the border radius of the gauge.
  final double? borderRadius;

  ///[theme] is the theme of the gauge.
  final HorizontalGaugeTheme? theme;

  ///[showTicks] determines whether to show ticks on the gauge.
  final bool showTicks;

  ///[showLabels] determines whether to show labels on the gauge.
  final bool showLabels;

  ///[customTickCount] is the custom tick count for the gauge.
  final int? customTickCount;

  ///[titleBuilder] is a function that builds the title widget.
  final TitleBuilder? titleBuilder;

  ///[valueBuilder] is a function that builds the value widget.
  final ValueBuilder? valueBuilder;

  ///[indicatorBuilder] is a function that builds the indicator widget.
  final IndicatorBuilder? indicatorBuilder;

  ///[tickBuilder] is a function that builds the tick widget.
  final TickBuilder? tickBuilder;

  ///[HorizontalGauge] creates a horizontal gauge widget.
  const HorizontalGauge({
    super.key,
    required this.title,
    required this.min,
    required this.max,
    required this.value,
    required this.unit,
    required this.color,
    this.onChanged,
    this.height,
    this.padding,
    this.borderRadius,
    this.theme,
    this.showTicks = true,
    this.showLabels = true,
    this.customTickCount,
    this.titleBuilder,
    this.valueBuilder,
    this.indicatorBuilder,
    this.tickBuilder,
  });

  @override
  State<HorizontalGauge> createState() => _HorizontalGaugeState();
}

class _HorizontalGaugeState extends State<HorizontalGauge> {
  late double _value;

  @override
  void initState() {
    _value = widget.value.clamp(widget.min, widget.max);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HorizontalGauge oldWidget) {
    super.didUpdateWidget(oldWidget);
    _value = widget.value.clamp(widget.min, widget.max);
  }

  void _setValue(double v) {
    v = v.clamp(widget.min, widget.max);
    if (widget.onChanged != null) widget.onChanged!(v);
    setState(() => _value = v);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final effectiveHeight =
        widget.height ?? (screenSize.height * 0.2).clamp(120.0, 200.0);
    final effectivePadding =
        widget.padding ??
        EdgeInsets.symmetric(
          horizontal: screenSize.width * 0.045,
          vertical: screenSize.height * 0.015,
        );
    final effectiveBorderRadius =
        widget.borderRadius ?? (screenSize.width * 0.04).clamp(12.0, 20.0);

    final gaugeTheme = widget.theme ?? const HorizontalGaugeTheme();
    final backgroundColor =
        gaugeTheme.backgroundColor ??
        theme.colorScheme.surface.withValues(alpha: 0.06);
    final borderColor =
        gaugeTheme.borderColor ?? Colors.white.withValues(alpha: 0.02);
    final titleColor = gaugeTheme.titleColor ?? Colors.white;
    final valueColor = gaugeTheme.valueColor ?? Colors.white;
    final unitColor =
        gaugeTheme.unitColor ?? Colors.white.withValues(alpha: 0.7);

    return Container(
      height: effectiveHeight,
      padding: effectivePadding,
      decoration: BoxDecoration(
        color: gaugeTheme.backgroundGradient == null ? backgroundColor : null,
        gradient: gaugeTheme.backgroundGradient,
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget.titleBuilder?.call(context, widget.title, _value) ??
              Text(
                widget.title,
                style:
                    gaugeTheme.titleStyle ??
                    TextStyle(
                      fontSize: (screenSize.width * 0.04).clamp(14.0, 18.0),
                      color: titleColor,
                    ),
              ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Center(
                    child:
                        widget.valueBuilder?.call(
                          context,
                          _value,
                          widget.unit,
                        ) ??
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: _formatMainNumber(_value),
                                style:
                                    gaugeTheme.valueStyle ??
                                    TextStyle(
                                      fontSize: (screenSize.width * 0.07).clamp(
                                        24.0,
                                        32.0,
                                      ),
                                      fontWeight: FontWeight.w700,
                                      color: valueColor,
                                    ),
                              ),
                              TextSpan(
                                text: ' ${widget.unit}',
                                style:
                                    gaugeTheme.unitStyle ??
                                    TextStyle(
                                      fontSize: (screenSize.width * 0.035)
                                          .clamp(12.0, 16.0),
                                      color: unitColor,
                                    ),
                              ),
                            ],
                          ),
                        ),
                  ),
                ),

                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenSize.width * 0.03,
                    ),
                    child: ScaleWidget(
                      min: widget.min,
                      max: widget.max,
                      value: _value,
                      color: widget.color,
                      onChanged: _setValue,
                      theme: gaugeTheme,
                      showTicks: widget.showTicks,
                      showLabels: widget.showLabels,
                      customTickCount: widget.customTickCount,
                      indicatorBuilder: widget.indicatorBuilder,
                      tickBuilder: widget.tickBuilder,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Formats the main number for display.
  String _formatMainNumber(double v) {
    return v.round().toString();
  }
}
