import 'package:flutter/material.dart';

class ShimmerWidget extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;

  const ShimmerWidget({super.key, required this.child, required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return ShaderMask(
          shaderCallback: (bounds) {
            final width = bounds.width;
            final gradient = LinearGradient(
              colors: [const Color.fromARGB(255, 7, 7, 7), const Color.fromARGB(255, 248, 213, 14), const Color.fromARGB(255, 194, 194, 193)],
              stops: [0.0, 0.5, 1.0],
              begin: Alignment(-1 + 2 * animation.value, 0),
              end: Alignment(-0.5 + 2 * animation.value, 0),
              tileMode: TileMode.clamp,
            );
            return gradient.createShader(Rect.fromLTWH(0, 0, width, bounds.height));
          },
          blendMode: BlendMode.srcIn,
          child: child,
        );
      },
    );
  }
}
