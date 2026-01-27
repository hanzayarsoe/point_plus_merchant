import 'dart:async';

import 'package:flutter/material.dart';
import 'package:merchant/core/injection/injection_container.dart';

enum ToastType { success, error, info }

OverlayEntry? _activeToastEntry;
Timer? _activeToastTimer;
GlobalKey<_ToastOverlayState>? _activeToastKey;

void showToast({
  required String message,
  String? title,
  ToastType type = ToastType.info,
  Duration duration = const Duration(seconds: 3),
  Alignment alignment = Alignment.topCenter,
}) {
  _activeToastTimer?.cancel();
  _activeToastTimer = null;
  _activeToastKey = null;
  if (_activeToastEntry?.mounted ?? false) {
    _activeToastEntry?.remove();
  }
  _activeToastEntry = null;

  final overlay = sl<GlobalKey<NavigatorState>>().currentState?.overlay;
  if (overlay == null) {
    debugPrint('showToast: overlay not available');
    return;
  }

  late final OverlayEntry entry;
  final key = GlobalKey<_ToastOverlayState>();

  entry = OverlayEntry(
    builder: (context) => _ToastOverlay(
      key: key,
      message: message,
      title: title,
      type: type,
      alignment: alignment,
      onDismissed: () {
        if (entry.mounted) {
          entry.remove();
        }
        if (_activeToastEntry == entry) {
          _activeToastEntry = null;
          _activeToastKey = null;
        }
      },
    ),
  );

  overlay.insert(entry);
  _activeToastEntry = entry;
  _activeToastKey = key;
  _activeToastTimer = Timer(duration, () {
    if (_activeToastEntry != entry) {
      return;
    }
    final state = _activeToastKey?.currentState;
    if (state == null) {
      if (entry.mounted) {
        entry.remove();
      }
      _activeToastEntry = null;
      _activeToastKey = null;
      return;
    }
    state.dismiss();
    _activeToastTimer = null;
  });
}

class _ToastOverlay extends StatefulWidget {
  const _ToastOverlay({
    super.key,
    required this.message,
    required this.type,
    required this.alignment,
    required this.onDismissed,
    this.title,
  });

  final String message;
  final String? title;
  final ToastType type;
  final Alignment alignment;
  final VoidCallback onDismissed;

  @override
  State<_ToastOverlay> createState() => _ToastOverlayState();
}

class _ToastOverlayState extends State<_ToastOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;
  bool _dismissed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
      reverseDuration: const Duration(milliseconds: 180),
    );
    _opacity = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    final beginOffset = widget.alignment.y < 0
        ? const Offset(0, -0.08)
        : const Offset(0, 0.08);
    _slide = Tween<Offset>(
      begin: beginOffset,
      end: Offset.zero,
    ).animate(_opacity);
    _controller.forward();
  }

  void dismiss() {
    if (_dismissed) {
      return;
    }
    _dismissed = true;
    _controller.reverse().then((_) {
      if (mounted) {
        widget.onDismissed();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iconBackgroundColor = switch (widget.type) {
      ToastType.error => Theme.of(context).colorScheme.error,
      ToastType.success => const Color(0xff4AC462),
      ToastType.info => const Color.fromARGB(255, 59, 123, 234),
    };

    final iconData = switch (widget.type) {
      ToastType.error => Icons.error,
      ToastType.success => Icons.check,
      ToastType.info => Icons.info,
    };

    final titleStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.w600,
    );
    final messageStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      color: Colors.white,
      fontWeight: FontWeight.w500,
    );

    final content = widget.title == null
        ? Text(
            widget.message,
            style: messageStyle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title ?? '',
                style: titleStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                widget.message,
                style: messageStyle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );

    return SafeArea(
      minimum: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Padding(
        padding:
            widget.alignment.y < 0
                ? const EdgeInsets.only(top: 24)
                : const EdgeInsets.only(bottom: 24),
        child: Align(
          alignment: widget.alignment,
          child: Material(
            color: Colors.transparent,
            child: FadeTransition(
              opacity: _opacity,
              child: SlideTransition(
                position: _slide,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4A4A4A),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: iconBackgroundColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(iconData, size: 18, color: Colors.white),
                        ),
                        const SizedBox(width: 12),
                        Flexible(child: content),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
