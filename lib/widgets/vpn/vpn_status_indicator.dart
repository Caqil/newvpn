import 'package:flutter/cupertino.dart';
import '../../config/theme_config.dart';
import '../../utils/formatters.dart';

class VpnStatusIndicator extends StatefulWidget {
  final VpnConnectionStatus status;
  final String? serverName;
  final String? serverCountry;
  final String? serverFlag;
  final Duration? connectionDuration;
  final String? ipAddress;
  final VpnStatusStyle style;
  final bool showAnimation;
  final VoidCallback? onTap;

  const VpnStatusIndicator({
    super.key,
    required this.status,
    this.serverName,
    this.serverCountry,
    this.serverFlag,
    this.connectionDuration,
    this.ipAddress,
    this.style = VpnStatusStyle.normal,
    this.showAnimation = true,
    this.onTap,
  });

  @override
  State<VpnStatusIndicator> createState() => _VpnStatusIndicatorState();
}

class _VpnStatusIndicatorState extends State<VpnStatusIndicator>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _updateAnimations();
  }

  @override
  void didUpdateWidget(VpnStatusIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.status != widget.status) {
      _updateAnimations();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  void _setupAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _rotationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * 3.14159).animate(
      CurvedAnimation(parent: _rotationController, curve: Curves.linear),
    );
  }

  void _updateAnimations() {
    if (!widget.showAnimation) return;

    switch (widget.status) {
      case VpnConnectionStatus.connecting:
      case VpnConnectionStatus.disconnecting:
        _rotationController.repeat();
        _pulseController.stop();
        break;
      case VpnConnectionStatus.connected:
        _rotationController.stop();
        _pulseController.repeat(reverse: true);
        break;
      case VpnConnectionStatus.disconnected:
      case VpnConnectionStatus.error:
        _rotationController.stop();
        _pulseController.stop();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.style) {
      case VpnStatusStyle.compact:
        return _buildCompactIndicator();
      case VpnStatusStyle.card:
        return _buildCardIndicator();
      case VpnStatusStyle.detailed:
        return _buildDetailedIndicator();
      case VpnStatusStyle.large:
        return _buildLargeIndicator();
      case VpnStatusStyle.normal:
      default:
        return _buildNormalIndicator();
    }
  }

  Widget _buildNormalIndicator() {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(ThemeConfig.mediumSpacing),
        decoration: BoxDecoration(
          color: ThemeConfig.cardColor,
          borderRadius: BorderRadius.circular(ThemeConfig.mediumRadius),
          border: Border.all(
            color: _getStatusColor().withOpacity(0.2),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            _buildStatusIcon(48),
            const SizedBox(height: ThemeConfig.smallSpacing),
            _buildStatusText(),
            if (_shouldShowServerInfo()) ...[
              const SizedBox(height: ThemeConfig.extraSmallSpacing),
              _buildServerInfo(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCompactIndicator() {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: ThemeConfig.mediumSpacing,
          vertical: ThemeConfig.smallSpacing,
        ),
        decoration: BoxDecoration(
          color: _getStatusColor().withOpacity(0.1),
          borderRadius: BorderRadius.circular(ThemeConfig.mediumRadius),
          border: Border.all(color: _getStatusColor().withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildStatusIcon(16),
            const SizedBox(width: 8),
            Text(
              _getStatusText(),
              style: ThemeConfig.caption1.copyWith(
                color: _getStatusColor(),
                fontWeight: FontWeight.w600,
              ),
            ),
            if (_shouldShowServerInfo() && widget.serverFlag != null) ...[
              const SizedBox(width: 8),
              Text(widget.serverFlag!, style: const TextStyle(fontSize: 14)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCardIndicator() {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(ThemeConfig.largeSpacing),
        decoration: BoxDecoration(
          color: ThemeConfig.cardColor,
          borderRadius: BorderRadius.circular(ThemeConfig.mediumRadius),
          border: Border.all(color: ThemeConfig.borderColor.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'VPN Status',
                  style: ThemeConfig.subhead.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                _buildStatusIcon(24),
              ],
            ),
            const SizedBox(height: ThemeConfig.mediumSpacing),
            _buildStatusText(),
            if (_shouldShowServerInfo()) ...[
              const SizedBox(height: ThemeConfig.smallSpacing),
              _buildDetailedServerInfo(),
            ],
            if (widget.connectionDuration != null &&
                widget.status == VpnConnectionStatus.connected) ...[
              const SizedBox(height: ThemeConfig.smallSpacing),
              _buildConnectionDuration(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedIndicator() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(ThemeConfig.largeSpacing),
      decoration: BoxDecoration(
        color: ThemeConfig.cardColor,
        borderRadius: BorderRadius.circular(ThemeConfig.mediumRadius),
        border: Border.all(color: ThemeConfig.borderColor.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildStatusIcon(32),
              const SizedBox(width: ThemeConfig.mediumSpacing),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'VPN Connection',
                      style: ThemeConfig.headline.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    _buildStatusText(),
                  ],
                ),
              ),
            ],
          ),
          if (_shouldShowServerInfo()) ...[
            const SizedBox(height: ThemeConfig.mediumSpacing),
            _buildServerDetails(),
          ],
          if (widget.ipAddress != null) ...[
            const SizedBox(height: ThemeConfig.mediumSpacing),
            _buildIpAddressInfo(),
          ],
          if (widget.connectionDuration != null &&
              widget.status == VpnConnectionStatus.connected) ...[
            const SizedBox(height: ThemeConfig.mediumSpacing),
            _buildConnectionDuration(),
          ],
        ],
      ),
    );
  }

  Widget _buildLargeIndicator() {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(ThemeConfig.extraLargeSpacing),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _getStatusColor().withOpacity(0.1),
              _getStatusColor().withOpacity(0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(ThemeConfig.largeRadius),
          border: Border.all(
            color: _getStatusColor().withOpacity(0.2),
            width: 2,
          ),
        ),
        child: Column(
          children: [
            _buildLargeStatusIcon(),
            const SizedBox(height: ThemeConfig.mediumSpacing),
            Text(
              _getStatusText(),
              style: ThemeConfig.title2.copyWith(
                color: _getStatusColor(),
                fontWeight: FontWeight.w700,
              ),
            ),
            if (_shouldShowServerInfo()) ...[
              const SizedBox(height: ThemeConfig.smallSpacing),
              _buildLargeServerInfo(),
            ],
            if (widget.connectionDuration != null &&
                widget.status == VpnConnectionStatus.connected) ...[
              const SizedBox(height: ThemeConfig.mediumSpacing),
              _buildLargeConnectionDuration(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIcon(double size) {
    Widget icon = Icon(_getStatusIcon(), size: size, color: _getStatusColor());

    if (widget.showAnimation) {
      switch (widget.status) {
        case VpnConnectionStatus.connecting:
        case VpnConnectionStatus.disconnecting:
          return AnimatedBuilder(
            animation: _rotationAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationAnimation.value,
                child: icon,
              );
            },
          );
        case VpnConnectionStatus.connected:
          return AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(scale: _pulseAnimation.value, child: icon);
            },
          );
        default:
          return icon;
      }
    }

    return icon;
  }

  Widget _buildLargeStatusIcon() {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: _getStatusColor().withOpacity(0.1),
        shape: BoxShape.circle,
        border: Border.all(color: _getStatusColor().withOpacity(0.3), width: 3),
      ),
      child: Center(child: _buildStatusIcon(50)),
    );
  }

  Widget _buildStatusText() {
    return Text(
      _getStatusText(),
      style: ThemeConfig.callout.copyWith(
        color: _getStatusColor(),
        fontWeight: FontWeight.w600,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildServerInfo() {
    if (!_shouldShowServerInfo()) return const SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.serverFlag != null) ...[
          Text(widget.serverFlag!, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 6),
        ],
        Flexible(
          child: Text(
            widget.serverName ?? widget.serverCountry ?? 'Server',
            style: ThemeConfig.caption1.copyWith(
              color: ThemeConfig.secondaryTextColor,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedServerInfo() {
    if (!_shouldShowServerInfo()) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(ThemeConfig.smallSpacing),
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceColor,
        borderRadius: BorderRadius.circular(ThemeConfig.smallRadius),
      ),
      child: Row(
        children: [
          if (widget.serverFlag != null) ...[
            Text(widget.serverFlag!, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: ThemeConfig.smallSpacing),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.serverName != null)
                  Text(
                    widget.serverName!,
                    style: ThemeConfig.callout.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                if (widget.serverCountry != null)
                  Text(
                    widget.serverCountry!,
                    style: ThemeConfig.caption1.copyWith(
                      color: ThemeConfig.secondaryTextColor,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServerDetails() {
    if (!_shouldShowServerInfo()) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(ThemeConfig.mediumSpacing),
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceColor,
        borderRadius: BorderRadius.circular(ThemeConfig.smallRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Connected Server',
            style: ThemeConfig.caption1.copyWith(
              color: ThemeConfig.secondaryTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              if (widget.serverFlag != null) ...[
                Text(widget.serverFlag!, style: const TextStyle(fontSize: 24)),
                const SizedBox(width: ThemeConfig.smallSpacing),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.serverName != null)
                      Text(
                        widget.serverName!,
                        style: ThemeConfig.body.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    if (widget.serverCountry != null)
                      Text(
                        widget.serverCountry!,
                        style: ThemeConfig.callout.copyWith(
                          color: ThemeConfig.secondaryTextColor,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLargeServerInfo() {
    if (!_shouldShowServerInfo()) return const SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.serverFlag != null) ...[
          Text(widget.serverFlag!, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 8),
        ],
        Column(
          children: [
            if (widget.serverName != null)
              Text(
                widget.serverName!,
                style: ThemeConfig.headline.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            if (widget.serverCountry != null)
              Text(
                widget.serverCountry!,
                style: ThemeConfig.callout.copyWith(
                  color: ThemeConfig.secondaryTextColor,
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildIpAddressInfo() {
    if (widget.ipAddress == null) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(ThemeConfig.mediumSpacing),
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceColor,
        borderRadius: BorderRadius.circular(ThemeConfig.smallRadius),
      ),
      child: Row(
        children: [
          Icon(CupertinoIcons.globe, color: ThemeConfig.primaryColor, size: 20),
          const SizedBox(width: ThemeConfig.smallSpacing),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'IP Address',
                style: ThemeConfig.caption1.copyWith(
                  color: ThemeConfig.secondaryTextColor,
                ),
              ),
              Text(
                widget.ipAddress!,
                style: ThemeConfig.callout.copyWith(
                  fontWeight: FontWeight.w600,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildConnectionDuration() {
    if (widget.connectionDuration == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: ThemeConfig.smallSpacing,
        vertical: ThemeConfig.extraSmallSpacing,
      ),
      decoration: BoxDecoration(
        color: ThemeConfig.connectedColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(ThemeConfig.extraSmallSpacing),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            CupertinoIcons.clock,
            color: ThemeConfig.connectedColor,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            'Connected for ${Formatters.formatDuration(widget.connectionDuration!)}',
            style: ThemeConfig.caption2.copyWith(
              color: ThemeConfig.connectedColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLargeConnectionDuration() {
    if (widget.connectionDuration == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: ThemeConfig.mediumSpacing,
        vertical: ThemeConfig.smallSpacing,
      ),
      decoration: BoxDecoration(
        color: ThemeConfig.connectedColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(ThemeConfig.mediumRadius),
        border: Border.all(color: ThemeConfig.connectedColor.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            CupertinoIcons.clock_fill,
            color: ThemeConfig.connectedColor,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            Formatters.formatDuration(widget.connectionDuration!),
            style: ThemeConfig.callout.copyWith(
              color: ThemeConfig.connectedColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  bool _shouldShowServerInfo() {
    return widget.status == VpnConnectionStatus.connected &&
        (widget.serverName != null || widget.serverCountry != null);
  }

  Color _getStatusColor() {
    switch (widget.status) {
      case VpnConnectionStatus.connected:
        return ThemeConfig.connectedColor;
      case VpnConnectionStatus.connecting:
      case VpnConnectionStatus.disconnecting:
        return ThemeConfig.connectingColor;
      case VpnConnectionStatus.disconnected:
        return ThemeConfig.disconnectedColor;
      case VpnConnectionStatus.error:
        return ThemeConfig.errorColor;
    }
  }

  IconData _getStatusIcon() {
    switch (widget.status) {
      case VpnConnectionStatus.connected:
        return CupertinoIcons.checkmark_shield_fill;
      case VpnConnectionStatus.connecting:
        return CupertinoIcons.arrow_clockwise;
      case VpnConnectionStatus.disconnecting:
        return CupertinoIcons.arrow_clockwise;
      case VpnConnectionStatus.disconnected:
        return CupertinoIcons.shield;
      case VpnConnectionStatus.error:
        return CupertinoIcons.exclamationmark_shield_fill;
    }
  }

  String _getStatusText() {
    switch (widget.status) {
      case VpnConnectionStatus.connected:
        return 'Connected';
      case VpnConnectionStatus.connecting:
        return 'Connecting...';
      case VpnConnectionStatus.disconnecting:
        return 'Disconnecting...';
      case VpnConnectionStatus.disconnected:
        return 'Disconnected';
      case VpnConnectionStatus.error:
        return 'Connection Error';
    }
  }
}

enum VpnConnectionStatus {
  disconnected,
  connecting,
  connected,
  disconnecting,
  error,
}

enum VpnStatusStyle { normal, compact, card, detailed, large }
