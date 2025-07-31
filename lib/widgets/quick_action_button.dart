import 'package:flutter/material.dart';
import '../utils/theme.dart';

class QuickActionButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const QuickActionButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  State<QuickActionButton> createState() => _QuickActionButtonState();
}

class _QuickActionButtonState extends State<QuickActionButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: CustomPaint(
          painter: DashedBorderPainter(
            color: _isHovered ? AppTheme.primaryColor : AppTheme.borderColor,
            strokeWidth: 2,
            dashPattern: const [4, 1],
          ),
          child: AnimatedContainer(
            duration: AppTheme.transition,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _isHovered ? AppTheme.bgPrimary : AppTheme.bgSecondary,
              borderRadius: BorderRadius.circular(AppTheme.borderRadius),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.icon,
                  size: 24, // 1.5rem equivalent
                  color: _isHovered ? AppTheme.primaryColor : AppTheme.textSecondary,
                ),
                const SizedBox(height: 10),
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: _isHovered ? AppTheme.primaryColor : AppTheme.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final List<double> dashPattern;

  DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashPattern,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(8),
      ));

    final dashPath = Path();
    double distance = 0;
    bool draw = true;

    for (final pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        if (draw) {
          dashPath.addPath(
            pathMetric.extractPath(distance, distance + dashPattern[0]),
            Offset.zero,
          );
        }
        distance += dashPattern[0];
        if (dashPattern.length > 1) {
          draw = !draw;
          distance += dashPattern[1];
        }
      }
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
} 