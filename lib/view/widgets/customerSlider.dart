import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final double minValue;
  final double maxValue;
  final double initialValue;
  final Function(double) onValueChanged;

  CustomSlider({
    required this.minValue,
    required this.maxValue,
    required this.initialValue,
    required this.onValueChanged,
  });

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _currentValue = 0.0;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          _updateValue(details.localPosition.dx);
        });
      },
      onTapDown: (details) {
        setState(() {
          _updateValue(details.localPosition.dx);
        });
      },
      child: Container(
        width: double.infinity,
        height: 55.0,
        child: CustomPaint(
          painter: _SliderPainter(
            minValue: widget.minValue,
            maxValue: widget.maxValue,
            value: _currentValue,
          ),
        ),
      ),
    );
  }

  void _updateValue(double position) {
    final double width = context.size!.width;
    double newValue = widget.minValue + (position / width) * (widget.maxValue - widget.minValue);
    newValue = newValue.clamp(widget.minValue, widget.maxValue);
    _currentValue = newValue;
    widget.onValueChanged(newValue);
  }
}

class _SliderPainter extends CustomPainter {
  final double minValue;
  final double maxValue;
  final double value;

  _SliderPainter({
    required this.minValue,
    required this.maxValue,
    required this.value,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint trackPaint = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round;

    final Paint activeTrackPaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 8.0
      ..strokeCap = StrokeCap.round;

    final double trackLength = size.width - 16.0;
    final double trackY = size.height / 2;

    // Draw inactive track
    canvas.drawLine(
      Offset(8.0, trackY),
      Offset(size.width - 8.0, trackY),
      trackPaint,
    );

    // Draw active track
    final double activeTrackEnd = 8.0 + (trackLength * (value - minValue) / (maxValue - minValue));
    canvas.drawLine(
      Offset(8.0, trackY),
      Offset(activeTrackEnd, trackY),
      activeTrackPaint,
    );

    // Draw thumb
    final Paint thumbPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(activeTrackEnd, trackY),
      18.0,
      thumbPaint,
    );

    // Draw value inside the thumb
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: '${value.toInt()}',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(activeTrackEnd - textPainter.width / 2, trackY - textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
