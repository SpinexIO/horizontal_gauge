import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:horizontal_gauge/horizontal_gauge.dart';
import 'package:horizontal_gauge/ticks_painter.dart';

class ScaleWidget extends StatefulWidget {
  final double min;
  final double max;
  final double value;
  final Color color;
  final ValueChanged<double> onChanged;
  final HorizontalGaugeTheme? theme;
  final bool showTicks;
  final bool showLabels;
  final int? customTickCount;
  final IndicatorBuilder? indicatorBuilder;
  final TickBuilder? tickBuilder;

  const ScaleWidget({
    super.key,
    required this.min,
    required this.max,
    required this.value,
    required this.color,
    required this.onChanged,
    this.theme,
    this.showTicks = true,
    this.showLabels = true,
    this.customTickCount,
    this.indicatorBuilder,
    this.tickBuilder,
  });

  @override
  State<ScaleWidget> createState() => ScaleWidgetState();
}

class ScaleWidgetState extends State<ScaleWidget> {
  double _localValue = 0.0;
  bool _isDragging = false;
  DateTime? _boundaryReachedTime;

  @override
  void initState() {
    _localValue = widget.value;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ScaleWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _localValue = widget.value;
  }

  void _handleDragStart(DragStartDetails details) {
    _isDragging = true;
    _boundaryReachedTime = null;
  }

  void _handleDrag(DragUpdateDetails details, BoxConstraints constraints) {
    if (!_isDragging) return;

    final dx = details.delta.dx;
    final range = widget.max - widget.min;
    double perPixel = range / math.max(1, constraints.maxWidth);
    final potentialNewValue = _localValue + dx * perPixel;
    final clampedValue = potentialNewValue.clamp(widget.min, widget.max);

    bool atBoundary =
        (clampedValue == widget.min || clampedValue == widget.max);

    if (atBoundary) {
      if (_boundaryReachedTime == null) {
        _boundaryReachedTime = DateTime.now();
      } else {
        final currentTime = DateTime.now();
        if (currentTime.difference(_boundaryReachedTime!).inMilliseconds >=
            500) {
          _isDragging = false;
          _boundaryReachedTime = null;
          return;
        }
      }
    } else {
      _boundaryReachedTime = null;
    }

    setState(() {
      _localValue = clampedValue;
    });
    widget.onChanged(clampedValue);
  }

  void _handleDragEnd(DragEndDetails details) {
    _isDragging = false;
    _boundaryReachedTime = null;
  }

  void _handleTapDown(TapDownDetails details, BoxConstraints constraints) {
    final localDx = details.localPosition.dx;
    final fraction = (localDx / constraints.maxWidth).clamp(0.0, 1.0);
    final v = widget.min + fraction * (widget.max - widget.min);
    setState(() {
      _localValue = v;
    });
    widget.onChanged(v);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final scaleHeight = (screenSize.height * 0.1).clamp(60.0, 100.0);
    final gaugeTheme = widget.theme ?? const HorizontalGaugeTheme();

    final indicatorWidth =
        gaugeTheme.indicatorWidth ?? (screenSize.width * 0.01).clamp(3.0, 6.0);
    final indicatorHeight =
        gaugeTheme.indicatorHeight ??
        (screenSize.height * 0.055).clamp(35.0, 50.0);

    final indicatorColor = gaugeTheme.indicatorColor ?? widget.color;
    final shadowColor =
        gaugeTheme.indicatorShadowColor ?? widget.color.withValues(alpha: 0.35);

    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onHorizontalDragStart: _handleDragStart,
          onHorizontalDragUpdate: (d) => _handleDrag(d, constraints),
          onHorizontalDragEnd: _handleDragEnd,
          onTapDown: (t) => _handleTapDown(t, constraints),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (widget.showTicks)
                SizedBox(
                  height: scaleHeight,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: TicksPainter(
                      min: widget.min,
                      max: widget.max,
                      value: _localValue,
                      screenSize: screenSize,
                      theme: gaugeTheme,
                      showLabels: widget.showLabels,
                      customTickCount: widget.customTickCount,
                      tickBuilder: widget.tickBuilder,
                    ),
                  ),
                ),
              Positioned.fill(
                child: IgnorePointer(
                  child: Builder(
                    builder: (context) {
                      final fraction =
                          ((_localValue - widget.min) /
                                  (widget.max - widget.min))
                              .clamp(0.0, 1.0);
                      if (widget.indicatorBuilder != null) {
                        return Align(
                          alignment: Alignment(-1.0 + 2.0 * fraction, 0.0),
                          child: widget.indicatorBuilder!(
                            context,
                            _localValue,
                            widget.min,
                            widget.max,
                            widget.color,
                          ),
                        );
                      }
                      return Align(
                        alignment: Alignment(-1.0 + 2.0 * fraction, 0.0),
                        child: Container(
                          width: indicatorWidth,
                          height: indicatorHeight,
                          decoration: BoxDecoration(
                            color: gaugeTheme.indicatorGradient == null
                                ? indicatorColor
                                : null,
                            gradient: gaugeTheme.indicatorGradient,
                            borderRadius:
                                gaugeTheme.indicatorBorderRadius ??
                                BorderRadius.circular(indicatorWidth / 2),
                            boxShadow:
                                gaugeTheme.indicatorShadows ??
                                [
                                  BoxShadow(
                                    color: shadowColor,
                                    blurRadius: (screenSize.width * 0.015)
                                        .clamp(4.0, 8.0),
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
