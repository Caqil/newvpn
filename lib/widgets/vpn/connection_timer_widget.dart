import 'dart:async';
import 'package:flutter/cupertino.dart';
import '../../config/theme_config.dart';
import '../../utils/formatters.dart';

class ConnectionTimerWidget extends StatefulWidget {
  final DateTime? connectedAt;
  final bool isConnected;
  final Duration? remainingTime;
  final bool isPremiumUser;
  final TimerStyle style;
  final bool showWarning;
  final VoidCallback? onTimerExpired;

  const ConnectionTimerWidget({
    super.key,
    this.connectedAt,
    required this.isConnected,
    this.remainingTime,
    this.isPremiumUser = false,
    this.style = TimerStyle.normal,
    this.showWarning = true,
    this.onTimerExpired,
  });

  @override
  State<ConnectionTimerWidget> createState() => _ConnectionTimerWidgetState();
}

class _ConnectionTimerWidgetState extends State<ConnectionTimerWidget> {
  Timer? _timer;
  Duration _currentDuration = Duration.zero;
  Duration _currentRemaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _updateTimers();
    _startTimer();
  }

  @override
  void didUpdateWidget(ConnectionTimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.connectedAt != oldWidget.connectedAt ||
        widget.isConnected != oldWidget.isConnected) {
      _updateTimers();
      if (widget.isConnected) {
        _startTimer();
      } else {
        _stopTimer();
      }
    }
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void _startTimer() {
    _stopTimer();
    if (widget.isConnected) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _updateTimers();
      });
    }
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _updateTimers() {
    if (!mounted) return;

    setState(() {
      if (widget.isConnected && widget.connectedAt != null) {
        _currentDuration = DateTime.now().difference(widget.connectedAt!);
      } else {
        _currentDuration = Duration.zero;
      }

      if (!widget.isPremiumUser && widget.remainingTime != null) {
        _currentRemaining = widget.remainingTime! - _currentDuration;
        if (_currentRemaining.isNegative) {
          _currentRemaining = Duration.zero;
          widget.onTimerExpired?.call();
        }
      } else {
        _currentRemaining = Duration.zero;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(_getPadding()),
      decoration: _getDecoration(),
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    switch (widget.style) {
      case TimerStyle.compact:
        return _buildCompactTimer();
      case TimerStyle.card:
        return _buildCardTimer();
      case TimerStyle.circular:
        return _buildCircularTimer();
      case TimerStyle.normal:
      default:
        return _buildNormalTimer();
    }
  }

  Widget _buildNormalTimer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildConnectionStatus(),
        if (widget.isConnected) ...[
          const SizedBox(height: 8),
          _buildDurationDisplay(),
          if (!widget.isPremiumUser) ...[
            const SizedBox(height: 8),
            _buildRemainingTimeDisplay(),
          ],
        ],
      ],
    );
  }

  Widget _buildCompactTimer() {
    if (!widget.isConnected) {
      return _buildConnectionStatus();
    }

    return Row(
      children: [
        _buildStatusIndicator(),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Connected',
                style: ThemeConfig.caption1.copyWith(
                  color: ThemeConfig.connectedColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                Formatters.formatDuration(_currentDuration),
                style: ThemeConfig.caption2.copyWith(
                  color: ThemeConfig.secondaryTextColor,
                ),
              ),
            ],
          ),
        ),
        if (!widget.isPremiumUser && _currentRemaining > Duration.zero)
          Text(
            Formatters.formatDuration(_currentRemaining),
            style: ThemeConfig.caption1.copyWith(
              color: _getRemainingTimeColor(),
              fontWeight: FontWeight.w600,
            ),
          ),
      ],
    );
  }

  Widget _buildCardTimer() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(ThemeConfig.mediumSpacing),
      decoration: BoxDecoration(
        color: ThemeConfig.cardColor,
        borderRadius: BorderRadius.circular(ThemeConfig.mediumRadius),
        border: Border.all(color: ThemeConfig.borderColor.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Connection Time',
                style: ThemeConfig.subhead.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              _buildStatusIndicator(),
            ],
          ),
          const SizedBox(height: ThemeConfig.mediumSpacing),
          _buildLargeDurationDisplay(),
          if (!widget.isPremiumUser && _currentRemaining > Duration.zero) ...[
            const SizedBox(height: ThemeConfig.smallSpacing),
            _buildRemainingTimeCard(),
          ],
        ],
      ),
    );
  }

  Widget _buildCircularTimer() {
    final progress = widget.isPremiumUser ? 1.0 : _getProgress();

    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 120,
            height: 120,
            child: CupertinoActivityIndicator(
              radius: 60,
              color: _getProgressColor(),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Formatters.formatDuration(_currentDuration),
                style: ThemeConfig.headline.copyWith(
                  fontWeight: FontWeight.w700,
                  color: ThemeConfig.primaryTextColor,
                ),
              ),
              if (!widget.isPremiumUser &&
                  _currentRemaining > Duration.zero) ...[
                const SizedBox(height: 2),
                Text(
                  '${Formatters.formatDuration(_currentRemaining)} left',
                  style: ThemeConfig.caption2.copyWith(
                    color: _getRemainingTimeColor(),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConnectionStatus() {
    return Row(
      children: [
        _buildStatusIndicator(),
        const SizedBox(width: 8),
        Text(
          widget.isConnected ? 'Connected' : 'Disconnected',
          style: ThemeConfig.callout.copyWith(
            color: widget.isConnected
                ? ThemeConfig.connectedColor
                : ThemeConfig.disconnectedColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusIndicator() {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: widget.isConnected
            ? ThemeConfig.connectedColor
            : ThemeConfig.disconnectedColor,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget _buildDurationDisplay() {
    return Row(
      children: [
        const Icon(
          CupertinoIcons.time,
          size: 16,
          color: ThemeConfig.secondaryTextColor,
        ),
        const SizedBox(width: 6),
        Text(
          'Connected for ${Formatters.formatDuration(_currentDuration)}',
          style: ThemeConfig.caption1.copyWith(
            color: ThemeConfig.secondaryTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildLargeDurationDisplay() {
    return Text(
      Formatters.formatDuration(_currentDuration),
      style: ThemeConfig.largeTitle.copyWith(
        fontWeight: FontWeight.w700,
        color: ThemeConfig.primaryColor,
      ),
    );
  }

  Widget _buildRemainingTimeDisplay() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getRemainingTimeColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(ThemeConfig.smallRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(CupertinoIcons.clock, size: 14, color: _getRemainingTimeColor()),
          const SizedBox(width: 4),
          Text(
            '${Formatters.formatDuration(_currentRemaining)} remaining',
            style: ThemeConfig.caption2.copyWith(
              color: _getRemainingTimeColor(),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRemainingTimeCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(ThemeConfig.smallSpacing),
      decoration: BoxDecoration(
        color: _getRemainingTimeColor().withOpacity(0.1),
        borderRadius: BorderRadius.circular(ThemeConfig.smallRadius),
        border: Border.all(color: _getRemainingTimeColor().withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(
            CupertinoIcons.clock_fill,
            size: 20,
            color: _getRemainingTimeColor(),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Free Time Remaining',
                  style: ThemeConfig.caption2.copyWith(
                    color: _getRemainingTimeColor(),
                  ),
                ),
                Text(
                  Formatters.formatDuration(_currentRemaining),
                  style: ThemeConfig.callout.copyWith(
                    color: _getRemainingTimeColor(),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getRemainingTimeColor() {
    if (_currentRemaining.inMinutes <= 10) {
      return ThemeConfig.errorColor;
    } else if (_currentRemaining.inMinutes <= 20) {
      return ThemeConfig.warningColor;
    } else {
      return ThemeConfig.connectedColor;
    }
  }

  Color _getProgressColor() {
    if (widget.isPremiumUser) {
      return ThemeConfig.connectedColor;
    }

    final progress = _getProgress();
    if (progress < 0.2) {
      return ThemeConfig.errorColor;
    } else if (progress < 0.5) {
      return ThemeConfig.warningColor;
    } else {
      return ThemeConfig.connectedColor;
    }
  }

  double _getProgress() {
    if (widget.isPremiumUser || widget.remainingTime == null) {
      return 1.0;
    }

    final totalTime = widget.remainingTime!.inSeconds;
    final usedTime = _currentDuration.inSeconds;

    if (totalTime <= 0) return 0.0;

    final progress = (totalTime - usedTime) / totalTime;
    return progress.clamp(0.0, 1.0);
  }

  BoxDecoration _getDecoration() {
    switch (widget.style) {
      case TimerStyle.card:
        return const BoxDecoration();
      case TimerStyle.compact:
      case TimerStyle.normal:
      case TimerStyle.circular:
      default:
        return BoxDecoration(
          color: ThemeConfig.cardColor,
          borderRadius: BorderRadius.circular(ThemeConfig.smallRadius),
          border: Border.all(color: ThemeConfig.borderColor.withOpacity(0.1)),
        );
    }
  }

  double _getPadding() {
    switch (widget.style) {
      case TimerStyle.compact:
        return ThemeConfig.smallSpacing;
      case TimerStyle.card:
        return 0; // Card has its own padding
      case TimerStyle.circular:
        return ThemeConfig.smallSpacing;
      case TimerStyle.normal:
      default:
        return ThemeConfig.mediumSpacing;
    }
  }
}

// Warning widget for when time is running low
class TimerWarningWidget extends StatelessWidget {
  final Duration remainingTime;
  final VoidCallback? onUpgrade;
  final VoidCallback? onDismiss;

  const TimerWarningWidget({
    super.key,
    required this.remainingTime,
    this.onUpgrade,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(ThemeConfig.mediumSpacing),
      padding: const EdgeInsets.all(ThemeConfig.mediumSpacing),
      decoration: BoxDecoration(
        color: ThemeConfig.warningColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(ThemeConfig.mediumRadius),
        border: Border.all(color: ThemeConfig.warningColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(
            CupertinoIcons.clock_fill,
            color: ThemeConfig.warningColor,
            size: 24,
          ),
          const SizedBox(width: ThemeConfig.mediumSpacing),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Time Running Low',
                  style: ThemeConfig.callout.copyWith(
                    color: ThemeConfig.warningColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${Formatters.formatDuration(remainingTime)} remaining. Upgrade for unlimited time.',
                  style: ThemeConfig.caption1.copyWith(
                    color: ThemeConfig.warningColor,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              if (onUpgrade != null)
                CupertinoButton(
                  onPressed: onUpgrade,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  color: ThemeConfig.warningColor,
                  borderRadius: BorderRadius.circular(ThemeConfig.smallRadius),
                  child: Text(
                    'Upgrade',
                    style: ThemeConfig.caption1.copyWith(
                      color: CupertinoColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              if (onDismiss != null) ...[
                const SizedBox(height: 4),
                CupertinoButton(
                  onPressed: onDismiss,
                  padding: EdgeInsets.zero,
                  minSize: 0,
                  child: Icon(
                    CupertinoIcons.xmark,
                    color: ThemeConfig.warningColor,
                    size: 18,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

// Timer expired widget
class TimerExpiredWidget extends StatelessWidget {
  final VoidCallback? onUpgrade;
  final VoidCallback? onDismiss;

  const TimerExpiredWidget({super.key, this.onUpgrade, this.onDismiss});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(ThemeConfig.mediumSpacing),
      padding: const EdgeInsets.all(ThemeConfig.mediumSpacing),
      decoration: BoxDecoration(
        color: ThemeConfig.errorColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(ThemeConfig.mediumRadius),
        border: Border.all(color: ThemeConfig.errorColor.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.exclamationmark_triangle_fill,
                color: ThemeConfig.errorColor,
                size: 28,
              ),
              const SizedBox(width: ThemeConfig.mediumSpacing),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Free Time Expired',
                      style: ThemeConfig.headline.copyWith(
                        color: ThemeConfig.errorColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Your daily 1-hour limit has been reached. VPN has been disconnected.',
                      style: ThemeConfig.callout.copyWith(
                        color: ThemeConfig.errorColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (onUpgrade != null) ...[
            const SizedBox(height: ThemeConfig.mediumSpacing),
            SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                onPressed: onUpgrade,
                color: ThemeConfig.primaryColor,
                borderRadius: BorderRadius.circular(ThemeConfig.mediumRadius),
                child: Text(
                  'Upgrade to Premium',
                  style: ThemeConfig.callout.copyWith(
                    color: CupertinoColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

enum TimerStyle { normal, compact, card, circular }
