import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:todoku/core/localization/l10n_extensions.dart';

class SecurityOverlaySwitcher extends StatefulWidget {
  final Widget child;

  const SecurityOverlaySwitcher({super.key, required this.child});

  @override
  State<SecurityOverlaySwitcher> createState() =>
      _SecurityOverlaySwitcherState();
}

class _SecurityOverlaySwitcherState extends State<SecurityOverlaySwitcher> {
  bool _shouldBlur = false;
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();

    _listener = AppLifecycleListener(
      onInactive: () => _setBlur(true),
      onHide: () => _setBlur(true),
      onShow: () => _setBlur(false),
      onResume: () => _setBlur(false),
    );
  }

  void _setBlur(bool blur) {
    if (_shouldBlur == blur) return;
    setState(() {
      _shouldBlur = blur;
    });
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_shouldBlur)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
              child: Container(
                color: Colors.black.withValues(alpha: 0.15),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock_outline, color: Colors.white, size: 48),
                      SizedBox(height: 12),
                      Text(
                        context.l10n.appTitle,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
