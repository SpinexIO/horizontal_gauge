library;

import 'dart:math' as math;
import 'package:flutter/material.dart';

///[CircularGaugeTheme] defines the visual properties of the circular gauge.
class CircularGaugeTheme {
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

  ///[needleColor] is the color of the gauge's needle.
  final Color? needleColor;

  ///[centerDotColor] is the color of the gauge's center dot.
  final Color? centerDotColor;

  ///[arcColor] is the color of the gauge's arc background.
  final Color? arcColor;

  ///[progressColor] is the color of the gauge's progress arc.
  final Color? progressColor;

  ///[titleStyle] is the text style of the gauge's title.
  final TextStyle? titleStyle;

  ///[valueStyle] is the text style of the gauge's value.
  final TextStyle? valueStyle;

  ///[unitStyle] is the text style of the gauge's unit.
  final TextStyle? unitStyle;

  ///[labelStyle] is the text style of the gauge's labels.
  final TextStyle? labelStyle;

  ///[needleWidth] is the width of the gauge's needle.
  final double? needleWidth;

  ///[centerDotRadius] is the radius of the gauge's center dot.
  final double? centerDotRadius;

  ///[arcStrokeWidth] is the stroke width of the gauge's arc.
  final double? arcStrokeWidth;

  ///[progressStrokeWidth] is the stroke width of the gauge's progress arc.
  final double? progressStrokeWidth;

  ///[backgroundGradient] is the gradient of the gauge's background.
  final Gradient? backgroundGradient;

  ///[needleGradient] is the gradient of the gauge's needle.
  final Gradient? needleGradient;

  ///[progressGradient] is the gradient of the gauge's progress arc.
  final Gradient? progressGradient;

  const CircularGaugeTheme({
    this.backgroundColor,
    this.borderColor,
    this.titleColor,
    this.valueColor,
    this.unitColor,
    this.tickColor,
    this.majorTickColor,
    this.labelColor,
    this.needleColor,
    this.centerDotColor,
    this.arcColor,
    this.progressColor,
    this.titleStyle,
    this.valueStyle,
    this.unitStyle,
    this.labelStyle,
    this.needleWidth,
    this.centerDotRadius,
    this.arcStrokeWidth,
    this.progressStrokeWidth,
    this.backgroundGradient,
    this.needleGradient,
    this.progressGradient,
  });

  CircularGaugeTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    Color? titleColor,
    Color? valueColor,
    Color? unitColor,
    Color? tickColor,
    Color? majorTickColor,
    Color? labelColor,
    Color? needleColor,
    Color? centerDotColor,
    Color? arcColor,
    Color? progressColor,
    TextStyle? titleStyle,
    TextStyle? valueStyle,
    TextStyle? unitStyle,
    TextStyle? labelStyle,
    double? needleWidth,
    double? centerDotRadius,
    double? arcStrokeWidth,
    double? progressStrokeWidth,
    Gradient? backgroundGradient,
    Gradient? needleGradient,
    Gradient? progressGradient,
  }) {
    return CircularGaugeTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      titleColor: titleColor ?? this.titleColor,
      valueColor: valueColor ?? this.valueColor,
      unitColor: unitColor ?? this.unitColor,
      tickColor: tickColor ?? this.tickColor,
      majorTickColor: majorTickColor ?? this.majorTickColor,
      labelColor: labelColor ?? this.labelColor,
      needleColor: needleColor ?? this.needleColor,
      centerDotColor: centerDotColor ?? this.centerDotColor,
      arcColor: arcColor ?? this.arcColor,
      progressColor: progressColor ?? this.progressColor,
      titleStyle: titleStyle ?? this.titleStyle,
      valueStyle: valueStyle ?? this.valueStyle,
      unitStyle: unitStyle ?? this.unitStyle,
      labelStyle: labelStyle ?? this.labelStyle,
      needleWidth: needleWidth ?? this.needleWidth,
      centerDotRadius: centerDotRadius ?? this.centerDotRadius,
      arcStrokeWidth: arcStrokeWidth ?? this.arcStrokeWidth,
      progressStrokeWidth: progressStrokeWidth ?? this.progressStrokeWidth,
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
      needleGradient: needleGradient ?? this.needleGradient,
      progressGradient: progressGradient ?? this.progressGradient,
    );
  }
}

///[CircularTitleBuilder] is a function that builds the title widget.
typedef CircularTitleBuilder = Widget Function(BuildContext context, String title, double value);

///[CircularValueBuilder] is a function that builds the value widget.
typedef CircularValueBuilder = Widget Function(BuildContext context, double value, String unit);

///[CircularNeedleBuilder] is a function that builds the needle widget.
typedef CircularNeedleBuilder =
    Widget Function(Canvas canvas, Size size, double value, double min, double max, Color color);

///[CircularGauge] is a widget that displays a circular gauge.
class CircularGauge extends StatefulWidget {
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

  ///[size] is the size of the gauge.
  final double? size;

  ///[padding] is the padding of the gauge.
  final EdgeInsetsGeometry? padding;

  ///[theme] is the theme of the gauge.
  final CircularGaugeTheme? theme;

  ///[showTicks] determines whether to show ticks on the gauge.
  final bool showTicks;

  ///[showLabels] determines whether to show labels on the gauge.
  final bool showLabels;

  ///[showProgressArc] determines whether to show progress arc on the gauge.
  final bool showProgressArc;

  ///[titleBuilder] is a function that builds the title widget.
  final CircularTitleBuilder? titleBuilder;

  ///[valueBuilder] is a function that builds the value widget.
  final CircularValueBuilder? valueBuilder;

  ///[needleBuilder] is a function that builds the needle widget.
  final CircularNeedleBuilder? needleBuilder;

  ///[CircularGauge] creates a circular gauge widget.
  const CircularGauge({
    super.key,
    required this.title,
    required this.min,
    required this.max,
    required this.value,
    required this.unit,
    required this.color,
    this.size,
    this.padding,
    this.theme,
    this.showTicks = true,
    this.showLabels = true,
    this.showProgressArc = true,
    this.titleBuilder,
    this.valueBuilder,
    this.needleBuilder,
  });

  @override
  State<CircularGauge> createState() => _CircularGaugeState();
}

class _CircularGaugeState extends State<CircularGauge> with TickerProviderStateMixin {
  late double _value;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _value = widget.value.clamp(widget.min, widget.max);
    _animationController = AnimationController(duration: const Duration(milliseconds: 800), vsync: this);
    _animation = Tween<double>(
      begin: widget.min,
      end: _value,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
    _animationController.forward();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CircularGauge oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newValue = widget.value.clamp(widget.min, widget.max);
    if (newValue != _value) {
      _animation = Tween<double>(
        begin: _value,
        end: newValue,
      ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut));
      _value = newValue;
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final effectiveSize = widget.size ?? math.min(screenSize.width * 0.8, 300.0);
    final effectivePadding = widget.padding ?? const EdgeInsets.all(16.0);

    return Container(
      padding: effectivePadding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.titleBuilder?.call(context, widget.title, _value) ??
              Text(
                widget.title,
                style:
                    widget.theme?.titleStyle ??
                    TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: widget.theme?.titleColor ?? Colors.white,
                    ),
              ),
          SizedBox(
            width: effectiveSize,
            height: effectiveSize * 1,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return CustomPaint(
                  painter: _CircularGaugePainter(
                    min: widget.min,
                    max: widget.max,
                    value: _animation.value,
                    color: widget.color,
                    theme: widget.theme ?? const CircularGaugeTheme(),
                    showTicks: widget.showTicks,
                    showLabels: widget.showLabels,
                    showProgressArc: widget.showProgressArc,
                    needleBuilder: widget.needleBuilder,
                  ),
                  size: Size(effectiveSize, effectiveSize * 0.7),
                );
              },
            ),
          ),
          widget.valueBuilder?.call(context, _value, widget.unit) ??
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: _value.round().toString(),
                      style:
                          widget.theme?.valueStyle ??
                          TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: widget.theme?.valueColor ?? Colors.white,
                          ),
                    ),
                    TextSpan(
                      text: ' ${widget.unit}',
                      style:
                          widget.theme?.unitStyle ??
                          TextStyle(fontSize: 18, color: widget.theme?.unitColor ?? Colors.white70),
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }
}

class _CircularGaugePainter extends CustomPainter {
  final double min;
  final double max;
  final double value;
  final Color color;
  final CircularGaugeTheme theme;
  final bool showTicks;
  final bool showLabels;
  final bool showProgressArc;
  final CircularNeedleBuilder? needleBuilder;

  _CircularGaugePainter({
    required this.min,
    required this.max,
    required this.value,
    required this.color,
    required this.theme,
    required this.showTicks,
    required this.showLabels,
    required this.showProgressArc,
    this.needleBuilder,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 1.3);
    final radius = math.min(size.width, size.height) * 0.4;
    if (showProgressArc) {
      _drawArcBackground(canvas, center, radius);
      _drawProgressArc(canvas, center, radius);
    }
    if (showTicks) {
      _drawTicks(canvas, center, radius);
    }
    if (showLabels) {
      _drawLabels(canvas, center, radius, size);
    }
    _drawNeedle(canvas, center, radius, size);
    _drawCenterDot(canvas, center);
  }

  void _drawArcBackground(Canvas canvas, Offset center, double radius) {
    final paint = Paint()
      ..color = theme.arcColor ?? Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = theme.arcStrokeWidth ?? 8.0
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), math.pi, math.pi, false, paint);
  }

  void _drawProgressArc(Canvas canvas, Offset center, double radius) {
    final fraction = (value - min) / (max - min);
    final sweepAngle = math.pi * fraction;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = theme.progressStrokeWidth ?? 8.0
      ..strokeCap = StrokeCap.round;

    if (theme.progressGradient != null) {
      paint.shader = theme.progressGradient!.createShader(Rect.fromCircle(center: center, radius: radius));
    } else {
      paint.color = theme.progressColor ?? color;
    }

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), math.pi, sweepAngle, false, paint);
  }

  void _drawTicks(Canvas canvas, Offset center, double radius) {
    final tickPaint = Paint()
      ..color = theme.tickColor ?? Colors.white.withValues(alpha: 0.3)
      ..strokeWidth = 1.0;

    final majorTickPaint = Paint()
      ..color = theme.majorTickColor ?? Colors.white.withValues(alpha: 0.6)
      ..strokeWidth = 2.0;

    const int totalTicks = 21;
    for (int i = 0; i < totalTicks; i++) {
      final angle = math.pi + (math.pi * i / (totalTicks - 1));
      final isMajor = i % 5 == 0;
      final paint = isMajor ? majorTickPaint : tickPaint;
      final tickLength = isMajor ? 15.0 : 8.0;

      final startRadius = radius + 10;
      final endRadius = startRadius + tickLength;

      final startX = center.dx + startRadius * math.cos(angle);
      final startY = center.dy + startRadius * math.sin(angle);
      final endX = center.dx + endRadius * math.cos(angle);
      final endY = center.dy + endRadius * math.sin(angle);

      canvas.drawLine(Offset(startX, startY), Offset(endX, endY), paint);
    }
  }

  void _drawLabels(Canvas canvas, Offset center, double radius, Size size) {
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final labelRadius = radius + 35;

    textPainter.text = TextSpan(
      text: _formatValue(min),
      style:
          theme.labelStyle ??
          TextStyle(fontSize: 14, color: theme.labelColor ?? Colors.white70, fontWeight: FontWeight.w500),
    );
    textPainter.layout();
    final leftX = center.dx + labelRadius * math.cos(math.pi) - textPainter.width / 2;
    final leftY = center.dy + labelRadius * math.sin(math.pi) - textPainter.height / 2;
    textPainter.paint(canvas, Offset(leftX, leftY));

    textPainter.text = TextSpan(
      text: _formatValue(max),
      style:
          theme.labelStyle ??
          TextStyle(fontSize: 14, color: theme.labelColor ?? Colors.white70, fontWeight: FontWeight.w500),
    );
    textPainter.layout();
    final rightX = center.dx + labelRadius * math.cos(0) - textPainter.width / 2;
    final rightY = center.dy + labelRadius * math.sin(0) - textPainter.height / 2;
    textPainter.paint(canvas, Offset(rightX, rightY));
  }

  void _drawNeedle(Canvas canvas, Offset center, double radius, Size size) {
    if (needleBuilder != null) {
      needleBuilder!(canvas, size, value, min, max, color);
      return;
    }

    final fraction = (value - min) / (max - min);
    final angle = math.pi + (math.pi * fraction);

    final needleLength = radius * 0.8;
    final needleEndX = center.dx + needleLength * math.cos(angle);
    final needleEndY = center.dy + needleLength * math.sin(angle);

    final needlePaint = Paint()
      ..strokeWidth = theme.needleWidth ?? 3.0
      ..strokeCap = StrokeCap.round;

    if (theme.needleGradient != null) {
      needlePaint.shader = theme.needleGradient!.createShader(Rect.fromPoints(center, Offset(needleEndX, needleEndY)));
    } else {
      needlePaint.color = theme.needleColor ?? color;
    }

    canvas.drawLine(center, Offset(needleEndX, needleEndY), needlePaint);
  }

  void _drawCenterDot(Canvas canvas, Offset center) {
    final paint = Paint()
      ..color = theme.centerDotColor ?? Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, theme.centerDotRadius ?? 6.0, paint);
  }

  String _formatValue(double v) {
    if (v >= 1000) {
      final kValue = v / 1000;
      return '${kValue.toStringAsFixed(kValue == kValue.floor() ? 0 : 1)}K';
    }
    return v == v.floor() ? v.floor().toString() : v.toStringAsFixed(1);
  }

  @override
  bool shouldRepaint(covariant _CircularGaugePainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.min != min ||
        oldDelegate.max != max ||
        oldDelegate.color != color ||
        oldDelegate.theme != theme;
  }
}
