import 'package:flutter/material.dart';
import 'package:horizontal_gauge/horizontal_gauge.dart';
import 'package:horizontal_gauge/circular_gauge.dart';
import 'dart:async';
import 'dart:math' as math;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gauge Examples',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.light),
      themeMode: ThemeMode.light,
      home: const ExampleScreen(),
    );
  }
}

class ExampleScreen extends StatefulWidget {
  const ExampleScreen({super.key});

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> with TickerProviderStateMixin {
  double weightValue = 65.0;
  double heightValue = 175.0;
  double temperatureValue = 23.5;
  double speedValue = 50.0;
  double batteryValue = 80.0;

  double speedometerValue = 80.0;
  double fuelValue = 60.0;
  double rpmValue = 3500.0;
  double temperatureCircularValue = 85.0;
  double pressureValue = 25.0;

  late AnimationController _simulationController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _simulationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        speedometerValue = 60 + (math.Random().nextDouble() * 80);
        fuelValue = 20 + (math.Random().nextDouble() * 60); 
        rpmValue = 1000 + (math.Random().nextDouble() * 5000);
        temperatureCircularValue = 70 + (math.Random().nextDouble() * 40);
        pressureValue = 15 + (math.Random().nextDouble() * 25);
      });
    });
  }

  @override
  void dispose() {
    _simulationController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFF1A1A1A),
        appBar: AppBar(
          title: const Text('Gauge Examples', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xFF2A2A2A),
          elevation: 0,
          bottom: const TabBar(
            labelColor: Colors.white,
            tabs: [
              Tab(text: 'Horizontal Gauges'),
              Tab(text: 'Circular Gauges'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildHorizontalGauges(),
            _buildCircularGauges(),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalGauges() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Interactive Horizontal Gauges',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            const Text('Tap or drag to change values', style: TextStyle(fontSize: 16, color: Colors.white70)),
            const SizedBox(height: 32),
            HorizontalGauge(
              title: 'Weight Goal',
              min: 40.0,
              max: 120.0,
              value: weightValue,
              unit: 'kg',
              color: Colors.blue,
              onChanged: (value) {
                setState(() {
                  weightValue = value;
                });
              },
            ),
            const SizedBox(height: 24),
            HorizontalGauge(
              title: 'Height',
              min: 140.0,
              max: 200.0,
              value: heightValue,
              unit: 'cm',
              color: Colors.green,
              theme: HorizontalGaugeTheme(
                backgroundColor: Colors.green.withValues(alpha:0.1),
                borderColor: Colors.green.withValues(alpha:0.3),
                titleColor: Colors.green[300],
                valueColor: Colors.green[100],
                unitColor: Colors.green[200],
                indicatorGradient: LinearGradient(colors: [Colors.green[400]!, Colors.green[600]!]),
                indicatorShadows: [
                  BoxShadow(color: Colors.green.withValues(alpha:0.5), blurRadius: 10, offset: const Offset(0, 3)),
                ],
              ),
              onChanged: (value) {
                setState(() {
                  heightValue = value;
                });
              },
            ),
            const SizedBox(height: 24),
            HorizontalGauge(
              title: 'Temperature',
              min: -10.0,
              max: 50.0,
              value: temperatureValue,
              unit: '°C',
              color: Colors.orange,
              theme: HorizontalGaugeTheme(
                backgroundGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.orange.withValues(alpha:0.1), Colors.red.withValues(alpha:0.1)],
                ),
                titleStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange),
                valueStyle: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white),
                indicatorWidth: 8,
                indicatorHeight: 60,
                indicatorBorderRadius: BorderRadius.circular(10),
              ),
              onChanged: (value) {
                setState(() {
                  temperatureValue = value;
                });
              },
            ),
            const SizedBox(height: 24),
            HorizontalGauge(
              title: 'Speed Limit',
              min: 0.0,
              max: 120.0,
              value: speedValue,
              unit: 'km/h',
              color: Colors.red,
              theme: HorizontalGaugeTheme(
                backgroundColor: Colors.red.withValues(alpha:0.05),
                borderColor: Colors.red.withValues(alpha:0.2),
                tickColor: Colors.red.withValues(alpha:0.3),
                majorTickColor: Colors.red.withValues(alpha:0.5),
                labelColor: Colors.red[300],
                indicatorColor: Colors.red[600],
                tickHeight: 8,
                majorTickHeight: 16,
              ),
              customTickCount: 25,
              onChanged: (value) {
                setState(() {
                  speedValue = value;
                });
              },
            ),
            const SizedBox(height: 24),
            HorizontalGauge(
              title: 'Battery Level',
              min: 0.0,
              max: 100.0,
              value: batteryValue,
              unit: '%',
              color: Colors.purple,
              height: 200.0,
              showTicks: false,
              theme: HorizontalGaugeTheme(
                backgroundColor: const Color(0xFF2A1A3A),
                borderColor: Colors.purple.withValues(alpha:0.4),
                titleColor: Colors.purple[200],
                valueColor: Colors.white,
                unitColor: Colors.purple[300],
                indicatorGradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.purple[300]!, Colors.purple[700]!],
                ),
                indicatorWidth: 6,
                indicatorHeight: 80,
                titleStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                valueStyle: const TextStyle(fontSize: 36, fontWeight: FontWeight.w800),
              ),
              onChanged: (value) {
                setState(() {
                  batteryValue = value;
                });
              },
            ),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha:0.03),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha:0.1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Custom Builder Examples:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  HorizontalGauge(
                    title: 'Custom Title',
                    min: 0.0,
                    max: 100.0,
                    value: 75.0,
                    unit: 'pts',
                    color: Colors.cyan,
                    height: 120,
                    titleBuilder: (context, title, value) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.cyan.withValues(alpha:0.3), Colors.blue.withValues(alpha:0.3)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: Colors.cyan, size: 16),
                            const SizedBox(width: 8),
                            Text(
                              '$title (${value.round()})',
                              style: const TextStyle(color: Colors.cyan, fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    },
                    onChanged: null,
                  ),
                  const SizedBox(height: 20),
                  HorizontalGauge(
                    title: 'Score',
                    min: 0.0,
                    max: 1000.0,
                    value: 850.0,
                    unit: 'pts',
                    color: Colors.amber,
                    height: 150,
                    valueBuilder: (context, value, unit) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [Colors.amber.withValues(alpha:0.3), Colors.orange.withValues(alpha:0.1)],
                              ),
                              border: Border.all(color: Colors.amber, width: 2),
                            ),
                            child: Text(
                              value.round().toString(),
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: Colors.amber),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(unit, style: TextStyle(fontSize: 12, color: Colors.amber.withValues(alpha:0.8))),
                        ],
                      );
                    },
                    onChanged: null,
                  ),
                  const SizedBox(height: 20),

                  HorizontalGauge(
                    title: 'Progress',
                    min: 0.0,
                    max: 100.0,
                    value: 60.0,
                    unit: '%',
                    color: Colors.teal,
                    height: 120,
                    indicatorBuilder: (context, value, min, max, color) {
                      return Container(
                        width: 20,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [BoxShadow(color: Colors.teal.withValues(alpha:0.6), blurRadius: 8, spreadRadius: 2)],
                        ),
                        child: const Icon(Icons.arrow_drop_down, color: Colors.white, size: 16),
                      );
                    },
                    onChanged: null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha:0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha:0.1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Features:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  const _FeatureItem(text: '• Responsive design for all screen sizes'),
                  const _FeatureItem(text: '• Drag or tap to change values'),
                  const _FeatureItem(text: '• Smart boundary detection (500ms limit)'),
                  const _FeatureItem(text: '• Smooth animations'),
                  const _FeatureItem(text: '• Highly customizable themes'),
                  const _FeatureItem(text: '• Gradient backgrounds and indicators'),
                  const _FeatureItem(text: '• Custom colors for all elements'),
                  const _FeatureItem(text: '• Configurable tick marks'),
                  const _FeatureItem(text: '• Custom text styles'),
                  const _FeatureItem(text: '• Custom builder patterns for all components'),
                  const _FeatureItem(text: '• Title, value, indicator, and tick builders'),
                  const SizedBox(height: 16),
                  Text(
                    'Current Values:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white.withValues(alpha:0.9)),
                  ),
                  const SizedBox(height: 8),
                  _ValueDisplay(label: 'Weight', value: weightValue.toStringAsFixed(1), unit: 'kg'),
                  _ValueDisplay(label: 'Height', value: heightValue.toStringAsFixed(1), unit: 'cm'),
                  _ValueDisplay(label: 'Temperature', value: temperatureValue.toStringAsFixed(1), unit: '°C'),
                  _ValueDisplay(label: 'Speed', value: speedValue.toStringAsFixed(1), unit: 'km/h'),
                  _ValueDisplay(label: 'Battery', value: batteryValue.toStringAsFixed(1), unit: '%'),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularGauges() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Dashboard Style Gauges',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            const Text('Live simulation - values change automatically', style: TextStyle(fontSize: 16, color: Colors.white70)),
            const SizedBox(height: 32),
            CircularGauge(
              title: 'Speed',
              min: 0.0,
              max: 200.0,
              value: speedometerValue,
              unit: 'km/h',
              color: Colors.blue,
              size: 250,
              theme: CircularGaugeTheme(
                backgroundColor: Colors.blue.withValues(alpha:0.1),
                titleColor: Colors.blue[300],
                valueColor: Colors.white,
                unitColor: Colors.blue[200],
                needleColor: Colors.blue[400],
                centerDotColor: Colors.white,
                arcColor: Colors.white.withValues(alpha:0.1),
                progressColor: Colors.blue,
                progressGradient: LinearGradient(
                  colors: [Colors.blue[300]!, Colors.blue[600]!],
                ),
                arcStrokeWidth: 12,
                progressStrokeWidth: 12,
                needleWidth: 4,
                centerDotRadius: 8,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: CircularGauge(
                    title: 'Fuel',
                    min: 0.0,
                    max: 100.0,
                    value: fuelValue,
                    unit: '%',
                    color: Colors.green,
                    size: 180,
                    theme: CircularGaugeTheme(
                      titleColor: Colors.green[300],
                      valueColor: Colors.white,
                      unitColor: Colors.green[200],
                      needleColor: Colors.green[400],
                      centerDotColor: Colors.white,
                      arcColor: Colors.white.withValues(alpha:0.1),
                      progressGradient: LinearGradient(
                        colors: [Colors.red, Colors.yellow, Colors.green],
                        stops: [0.0, 0.5, 1.0],
                      ),
                      arcStrokeWidth: 8,
                      progressStrokeWidth: 8,
                      needleWidth: 3,
                      centerDotRadius: 6,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CircularGauge(
                    title: 'RPM',
                    min: 0.0,
                    max: 8000.0,
                    value: rpmValue,
                    unit: 'rpm',
                    color: Colors.red,
                    size: 180,
                    theme: CircularGaugeTheme(
                      titleColor: Colors.red[300],
                      valueColor: Colors.white,
                      unitColor: Colors.red[200],
                      needleColor: Colors.red[400],
                      centerDotColor: Colors.white,
                      arcColor: Colors.white.withValues(alpha:0.1),
                      progressColor: Colors.red,
                      progressGradient: LinearGradient(
                        colors: [Colors.orange, Colors.red],
                      ),
                      arcStrokeWidth: 8,
                      progressStrokeWidth: 8,
                      needleWidth: 3,
                      centerDotRadius: 6,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: CircularGauge(
                    title: 'Engine Temp',
                    min: 60.0,
                    max: 120.0,
                    value: temperatureCircularValue,
                    unit: '°C',
                    color: Colors.orange,
                    size: 180,
                    theme: CircularGaugeTheme(
                      titleColor: Colors.orange[300],
                      valueColor: Colors.white,
                      unitColor: Colors.orange[200],
                      needleColor: Colors.orange[400],
                      centerDotColor: Colors.white,
                      arcColor: Colors.white.withValues(alpha:0.1),
                      progressGradient: LinearGradient(
                        colors: [Colors.blue, Colors.green, Colors.yellow, Colors.red],
                        stops: [0.0, 0.3, 0.7, 1.0],
                      ),
                      arcStrokeWidth: 8,
                      progressStrokeWidth: 8,
                      needleWidth: 3,
                      centerDotRadius: 6,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CircularGauge(
                    title: 'Oil Pressure',
                    min: 0.0,
                    max: 50.0,
                    value: pressureValue,
                    unit: 'psi',
                    color: Colors.purple,
                    size: 180,
                    theme: CircularGaugeTheme(
                      titleColor: Colors.purple[300],
                      valueColor: Colors.white,
                      unitColor: Colors.purple[200],
                      needleColor: Colors.purple[400],
                      centerDotColor: Colors.white,
                      arcColor: Colors.white.withValues(alpha:0.1),
                      progressColor: Colors.purple,
                      arcStrokeWidth: 8,
                      progressStrokeWidth: 8,
                      needleWidth: 3,
                      centerDotRadius: 6,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha:0.03),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha:0.1)),
              ),
              child: Column(
                children: [
                  const Text(
                    'Premium Dashboard Style',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  CircularGauge(
                    title: 'Vehicle Speed',
                    min: 0.0,
                    max: 300.0,
                    value: speedometerValue * 1.5,
                    unit: 'km/h',
                    color: Colors.cyan,
                    size: 280,
                    theme: CircularGaugeTheme(
                      titleStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.cyan),
                      valueStyle: const TextStyle(fontSize: 42, fontWeight: FontWeight.w900, color: Colors.white),
                      unitStyle: const TextStyle(fontSize: 20, color: Colors.cyan),
                      needleGradient: LinearGradient(
                        colors: [Colors.cyan[300]!, Colors.cyan[600]!],
                      ),
                      centerDotColor: Colors.cyan,
                      arcColor: Colors.white.withValues(alpha:0.05),
                      progressGradient: SweepGradient(
                        colors: [
                          Colors.green,
                          Colors.yellow,
                          Colors.orange,
                          Colors.red,
                        ],
                        stops: [0.0, 0.4, 0.7, 1.0],
                      ),
                      arcStrokeWidth: 15,
                      progressStrokeWidth: 15,
                      needleWidth: 5,
                      centerDotRadius: 12,
                      majorTickColor: Colors.white.withValues(alpha:0.8),
                      tickColor: Colors.white.withValues(alpha:0.4),
                      labelColor: Colors.white.withValues(alpha:0.9),
                    ),
                    titleBuilder: (context, title, value) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.cyan.withValues(alpha:0.3), Colors.blue.withValues(alpha:0.3)],
                          ),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.cyan.withValues(alpha:0.5)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.speed, color: Colors.cyan, size: 20),
                            const SizedBox(width: 10),
                            Text(
                              title,
                              style: const TextStyle(
                                color: Colors.cyan,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha:0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha:0.1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.auto_graph, color: Colors.green, size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        'Live Dashboard Values:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _ValueDisplay(label: 'Speed', value: speedometerValue.toStringAsFixed(1), unit: 'km/h'),
                  _ValueDisplay(label: 'Fuel', value: fuelValue.toStringAsFixed(1), unit: '%'),
                  _ValueDisplay(label: 'RPM', value: rpmValue.toStringAsFixed(0), unit: 'rpm'),
                  _ValueDisplay(label: 'Engine Temp', value: temperatureCircularValue.toStringAsFixed(1), unit: '°C'),
                  _ValueDisplay(label: 'Oil Pressure', value: pressureValue.toStringAsFixed(1), unit: 'psi'),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha:0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.green.withValues(alpha:0.3)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.green, size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Circular gauges are read-only and update automatically',
                            style: TextStyle(fontSize: 12, color: Colors.green[300]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String text;

  const _FeatureItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text(text, style: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha:0.8))),
    );
  }
}

class _ValueDisplay extends StatelessWidget {
  final String label;
  final String value;
  final String unit;

  const _ValueDisplay({required this.label, required this.value, required this.unit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha:0.7))),
          Text(
            '$value $unit',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.white.withValues(alpha:0.9)),
          ),
        ],
      ),
    );
  }
}
