import 'package:base_structure/core/shared_widgets/texts/base_text.dart';
import 'package:base_structure/core/singletons/app_colors.dart';
import 'package:base_structure/core/singletons/font_sizes.dart';
import 'package:base_structure/core/singletons/font_weights.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class DropCountdownTimer extends StatefulWidget {
  final Duration duration;
  final VoidCallback onCountdownComplete;

  const DropCountdownTimer({
    super.key,
    required this.duration,
    required this.onCountdownComplete,
  });

  @override
  _DropCountdownTimerState createState() => _DropCountdownTimerState();
}

class _DropCountdownTimerState extends State<DropCountdownTimer>
    with TickerProviderStateMixin {
  late Duration remainingDuration;
  Timer? countdownTimer;

  late AnimationController dropController;
  late Animation<Offset> dropAnimation;

  @override
  void initState() {
    super.initState();
    remainingDuration = widget.duration;

    // Animation controller for the "drop" effect
    dropController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    dropAnimation = Tween<Offset>(
      begin: const Offset(0, -.5),
      end: const Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: dropController,
      curve: Curves.easeIn,
    ));

    startCountdown();
  }

  void startCountdown() {
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingDuration.inSeconds > 0) {
        setState(() {
          dropController.forward(from: 0.0);
          remainingDuration = remainingDuration - const Duration(seconds: 1);
        });
      } else {
        timer.cancel();
        widget.onCountdownComplete();
      }
    });
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    dropController.dispose();
    super.dispose();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return seconds;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BaseText(
          "${((remainingDuration.inMinutes ~/ 60))}:${remainingDuration.inMinutes.remainder(60)}:",
          size: FontSizes.xLarge,
          textColor: AppColors.primary,
          fontWeight: FontWeights.bold,
        ),
        SlideTransition(
          position: dropAnimation,
          child: BaseText(
            formatDuration(remainingDuration),
            size: FontSizes.xLarge,
            textColor: AppColors.primary,
            fontWeight: FontWeights.bold,
          ),
        ),
      ],
    );
  }
}
