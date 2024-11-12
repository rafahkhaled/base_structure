import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DottedBorderContainer extends StatelessWidget {
  final double radius;
  final Color borderColor;
  final double borderWidth;
  final Widget child;
  final double dotSpacing;
  final double dotRadius;
  final double minHeight;
  final double minWidth;
  final Color backgroundColor;
final EdgeInsetsGeometry? padding;

  const DottedBorderContainer({
    super.key,
    this.radius = 12.0,
    this.borderColor = Colors.black,
    this.borderWidth = 2.0,
    required this.child,
    this.dotSpacing = 5.0,
    this.dotRadius = 2.0,
    this.minHeight = 100,
    this.minWidth = 100,
    this.padding,
    this.backgroundColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DottedBorderPainter(
        radius: radius,
        borderColor: borderColor,
        borderWidth: borderWidth,
        dotSpacing: dotSpacing,
        dotRadius: dotRadius,
      ),
      child: Container(
        constraints: BoxConstraints(minWidth: minWidth, minHeight: minHeight),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Padding(
          padding: padding?? EdgeInsets.all(16.r),
          child: child,
        ),
      ),
    );
  }
}

class _DottedBorderPainter extends CustomPainter {
  final double radius;
  final Color borderColor;
  final double borderWidth;
  final double dotSpacing;
  final double dotRadius;

  _DottedBorderPainter({
    required this.radius,
    required this.borderColor,
    required this.borderWidth,
    required this.dotSpacing,
    required this.dotRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..strokeWidth = borderWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius)));

    _drawDottedLine(canvas, path, paint);
  }

  void _drawDottedLine(Canvas canvas, Path path, Paint paint) {
    // Measure the total length of the path
    final totalLength = path.computeMetrics().fold(0.0, (sum, metric) => sum + metric.length);

    // Draw dots along the path
    double currentLength = 0.0;
    while (currentLength < totalLength) {
      for (final metric in path.computeMetrics()) {
        final tangent = metric.getTangentForOffset(currentLength);
        if (tangent != null) {
          canvas.drawCircle(tangent.position, dotRadius, paint);
        }
      }
      currentLength += dotSpacing + dotRadius * 2;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
