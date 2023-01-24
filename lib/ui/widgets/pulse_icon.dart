import 'package:flutter/material.dart';

class PulsingIcon extends StatefulWidget {
  final Color stateColor;

  const PulsingIcon({Key? key, required this.stateColor}) : super(key: key);

  @override
  _PulsingIconState createState() => _PulsingIconState();
}

class _PulsingIconState extends State<PulsingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animationController.repeat(reverse: true);
    _animation = Tween(begin: 2.0, end: 5.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
                color: widget.stateColor,
                blurRadius: _animation.value,
                spreadRadius: _animation.value)
          ],
        ),
        child: Icon(
          Icons.circle,
          color: widget.stateColor,
        ),
      ),
    );
  }
}
