import 'package:flutter/material.dart';

class JumpingDotsIndicator extends StatefulWidget {
  final int numberOfDots;
  final Duration animationDuration;
  final double dotSize;
  final Color activeDotColor;
  final Color inactiveDotColor;

  JumpingDotsIndicator({
    required this.numberOfDots,
    this.animationDuration = const Duration(seconds: 2),
    this.dotSize = 10.0,
    this.activeDotColor = Colors.blue,
    this.inactiveDotColor = Colors.grey,
  });

  @override
  _JumpingDotsIndicatorState createState() => _JumpingDotsIndicatorState();
}

class _JumpingDotsIndicatorState extends State<JumpingDotsIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    // Tween from 0 to numberOfDots-1 and repeat indefinitely
    _animation = Tween<double>(begin: 0.0, end: (widget.numberOfDots - 1).toDouble()).animate(_animationController);

    // Start animation
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.numberOfDots, (index) {
            double scaleFactor = 1.0;
            if ((index - _animation.value).abs() < 1.0) {
              scaleFactor = 2.0 - ((index - _animation.value).abs());
            }
            return Container(
              width: widget.dotSize * scaleFactor,
              height: widget.dotSize,
              margin: EdgeInsets.symmetric(horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (index == _animation.value.toInt())
                    ? widget.activeDotColor // Active dot color
                    : widget.inactiveDotColor.withOpacity(0.5), // Inactive dot color
              ),
            );
          }),
        );
      },
    );
  }
}
