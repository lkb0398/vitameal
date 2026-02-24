import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:vitameal/core/theme/app_theme.dart';

class SwipeDownHint extends StatefulWidget {
  const SwipeDownHint({super.key});

  @override
  State<SwipeDownHint> createState() => _SwipeDownHintState();
}

class _SwipeDownHintState extends State<SwipeDownHint>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _slideY;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    )..repeat();

    _slideY = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 28.0)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 55,
      ),
      TweenSequenceItem(
        tween: ConstantTween(28.0),
        weight: 10,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 28.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 35,
      ),
    ]).animate(_ctrl);

    _opacity = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.15),
        weight: 55,
      ),
      TweenSequenceItem(
        tween: ConstantTween(0.15),
        weight: 10,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 0.15, end: 1.0),
        weight: 35,
      ),
    ]).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        return Transform.translate(
          offset: Offset(0, _slideY.value),
          child: Opacity(
            opacity: _opacity.value,
            child: Icon(
              PhosphorIcons.handPointing(),
              color: vrc(context).text,
              size: 32,
            ),
          ),
        );
      },
    );
  }
}
