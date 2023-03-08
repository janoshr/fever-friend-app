import 'dart:math' as math;
import 'package:flutter/material.dart';

class SpritePainter extends CustomPainter {
  final Animation<double> _animation;
  final Color stateColor;

  SpritePainter(this._animation, {required this.stateColor})
      : super(repaint: _animation);

  void circle(Canvas canvas, Rect rect, double value) {
    double opacity = (1.0 - (value / 4.0)).clamp(0.0, 1.0);
    Color color = stateColor.withOpacity(opacity);

    double size = rect.width / 2;
    double area = size * size;
    double radius = math.sqrt(area * value / 4);

    final Paint paint = Paint()..color = color;
    canvas.drawCircle(rect.center, radius, paint);
  }

  @override
  void paint(Canvas canvas, Size size) {
    Rect rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);

    for (int wave = 3; wave >= 0; wave--) {
      circle(canvas, rect, wave + _animation.value);
    }
  }

  @override
  bool shouldRepaint(SpritePainter oldDelegate) {
    return true;
  }
}

class IPulseIcon extends StatefulWidget {
  final Color stateColor;

  const IPulseIcon({Key? key, required this.stateColor}) : super(key: key);

  @override
  IPulseIconState createState() => IPulseIconState();
}

class IPulseIconState extends State<IPulseIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );
    _startAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller
      ..stop()
      ..reset()
      ..repeat(period: const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SpritePainter(_controller, stateColor: widget.stateColor),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Icon(
          Icons.circle,
          color: widget.stateColor,
        ),
      ),
    );
  }
}
