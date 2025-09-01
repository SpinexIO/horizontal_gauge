import 'package:flutter/material.dart';
import 'package:horizontal_gauge/horizontal_gauge.dart';

class TicksPainter extends CustomPainter {
  final double min;
  final double max;
  final double value;
  final Size screenSize;
  final HorizontalGaugeTheme? theme;
  final bool showLabels;
  final int? customTickCount;
  final TickBuilder? tickBuilder;

  TicksPainter({
    required this.min,
    required this.max,
    required this.value,
    required this.screenSize,
    this.theme,
    this.showLabels = true,
    this.customTickCount,
    this.tickBuilder,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (tickBuilder != null) {
      tickBuilder!(canvas, size, min, max, value, screenSize);
      return;
    }

    final gaugeTheme = theme ?? const HorizontalGaugeTheme();

    final tickColor = gaugeTheme.tickColor ?? Colors.white.withValues(alpha: 0.18);
    final majorTickColor = gaugeTheme.majorTickColor ?? Colors.white.withValues(alpha: 0.28);

    final Paint tickPaint = Paint()..color = tickColor;
    final Paint majorPaint = Paint()..color = majorTickColor;

    final int totalTicks = customTickCount ?? 41;
    final double spacing = size.width / (totalTicks - 1);

    final minorTickHeight = gaugeTheme.tickHeight ?? (screenSize.height * 0.01).clamp(6.0, 10.0);
    final majorTickHeight = gaugeTheme.majorTickHeight ?? (screenSize.height * 0.02).clamp(12.0, 20.0);

    for (int i = 0; i < totalTicks; i++) {
      final x = i * spacing;
      final bool isMajor = i % 5 == 0;
      final double h = isMajor ? majorTickHeight : minorTickHeight;
      final p = isMajor ? majorPaint : tickPaint;
      canvas.drawLine(Offset(x, size.height / 2 - h / 2), Offset(x, size.height / 2 + h / 2), p);
    }

    if (!showLabels) return;

    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    final fontSize = (screenSize.width * 0.025).clamp(9.0, 13.0);
    final labelOffset = (screenSize.height * 0.025).clamp(15.0, 25.0);
    final labelColor = gaugeTheme.labelColor ?? Colors.white70;

    final leftValue = min;
    final leftLabel = _formatLabel(leftValue);
    textPainter.text = TextSpan(
      text: leftLabel,
      style: gaugeTheme.labelStyle ?? TextStyle(fontSize: fontSize, color: labelColor, fontWeight: FontWeight.w500),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(0, size.height / 2 + labelOffset));

    final middleValue = (min + max) / 2;
    final middleLabel = _formatLabel(middleValue);
    textPainter.text = TextSpan(
      text: middleLabel,
      style: gaugeTheme.labelStyle ?? TextStyle(fontSize: fontSize, color: labelColor, fontWeight: FontWeight.w500),
    );
    textPainter.layout();
    final middleX = (size.width / 2) - (textPainter.width / 2);
    textPainter.paint(canvas, Offset(middleX, size.height / 2 + labelOffset));

    final rightValue = max;
    final rightLabel = _formatLabel(rightValue);
    textPainter.text = TextSpan(
      text: rightLabel,
      style: gaugeTheme.labelStyle ?? TextStyle(fontSize: fontSize, color: labelColor, fontWeight: FontWeight.w500),
    );
    textPainter.layout();
    final rightX = size.width - textPainter.width;
    textPainter.paint(canvas, Offset(rightX, size.height / 2 + labelOffset));
  }

  String _formatLabel(double v) {
    if (v >= 1000) {
      final kValue = v / 1000;
      if ((kValue - kValue.floor()).abs() < 0.01) {
        return '${kValue.floor()}K';
      } else {
        return '${kValue.toStringAsFixed(1)}K';
      }
    }

    if ((v - v.floor()).abs() < 0.01) return v.floor().toString();
    return v.toStringAsFixed(1);
  }

  @override
  bool shouldRepaint(covariant TicksPainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.min != min ||
        oldDelegate.max != max ||
        oldDelegate.screenSize != screenSize ||
        oldDelegate.theme != theme ||
        oldDelegate.showLabels != showLabels ||
        oldDelegate.customTickCount != customTickCount ||
        oldDelegate.tickBuilder != tickBuilder;
  }
}
