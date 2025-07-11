import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../config/theme_config.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;
  final LoadingSize size;
  final Color? color;
  final bool showMessage;
  final double? progress;

  const LoadingWidget({
    super.key,
    this.message,
    this.size = LoadingSize.medium,
    this.color,
    this.showMessage = true,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIndicator(),
          if (showMessage && message != null) ...[
            SizedBox(height: _getSpacing()),
            _buildMessage(),
          ],
        ],
      ),
    );
  }

  Widget _buildIndicator() {
    if (progress != null) {
      return _buildProgressIndicator();
    }

    return CupertinoActivityIndicator(
      radius: _getRadius(),
      color: color ?? ThemeConfig.primaryColor,
    );
  }

  Widget _buildProgressIndicator() {
    return Column(
      children: [
        SizedBox(
          width: _getProgressSize(),
          height: _getProgressSize(),
          child: CircularProgressIndicator.adaptive(
            value: progress,
            strokeWidth: _getStrokeWidth(),
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? ThemeConfig.primaryColor,
            ),
            backgroundColor: ThemeConfig.borderColor.withOpacity(0.3),
          ),
        ),
        const SizedBox(height: 8),
        Text('${(progress! * 100).toInt()}%', style: _getProgressTextStyle()),
      ],
    );
  }

  Widget _buildMessage() {
    return Text(
      message!,
      style: _getMessageStyle(),
      textAlign: TextAlign.center,
    );
  }

  double _getRadius() {
    switch (size) {
      case LoadingSize.small:
        return 8.0;
      case LoadingSize.medium:
        return 12.0;
      case LoadingSize.large:
        return 16.0;
    }
  }

  double _getProgressSize() {
    switch (size) {
      case LoadingSize.small:
        return 32.0;
      case LoadingSize.medium:
        return 48.0;
      case LoadingSize.large:
        return 64.0;
    }
  }

  double _getStrokeWidth() {
    switch (size) {
      case LoadingSize.small:
        return 2.0;
      case LoadingSize.medium:
        return 3.0;
      case LoadingSize.large:
        return 4.0;
    }
  }

  double _getSpacing() {
    switch (size) {
      case LoadingSize.small:
        return 8.0;
      case LoadingSize.medium:
        return 12.0;
      case LoadingSize.large:
        return 16.0;
    }
  }

  TextStyle _getMessageStyle() {
    switch (size) {
      case LoadingSize.small:
        return ThemeConfig.caption1.copyWith(
          color: ThemeConfig.secondaryTextColor,
        );
      case LoadingSize.medium:
        return ThemeConfig.callout.copyWith(
          color: ThemeConfig.secondaryTextColor,
        );
      case LoadingSize.large:
        return ThemeConfig.body.copyWith(color: ThemeConfig.secondaryTextColor);
    }
  }

  TextStyle _getProgressTextStyle() {
    return ThemeConfig.caption1.copyWith(
      color: color ?? ThemeConfig.primaryColor,
      fontWeight: FontWeight.w600,
    );
  }
}

// Specialized loading widgets for VPN app scenarios
class VpnConnectingWidget extends StatefulWidget {
  final String? serverName;
  final VoidCallback? onCancel;

  const VpnConnectingWidget({super.key, this.serverName, this.onCancel});

  @override
  State<VpnConnectingWidget> createState() => _VpnConnectingWidgetState();
}

class _VpnConnectingWidgetState extends State<VpnConnectingWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: ThemeConfig.connectingColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: ThemeConfig.connectingColor,
                      width: 2,
                    ),
                  ),
                  child: const Icon(
                    CupertinoIcons.wifi,
                    size: 40,
                    color: ThemeConfig.connectingColor,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: ThemeConfig.mediumSpacing),
          Text(
            'Connecting to VPN',
            style: ThemeConfig.headline.copyWith(fontWeight: FontWeight.w600),
          ),
          if (widget.serverName != null) ...[
            const SizedBox(height: ThemeConfig.smallSpacing),
            Text(
              widget.serverName!,
              style: ThemeConfig.callout.copyWith(
                color: ThemeConfig.secondaryTextColor,
              ),
            ),
          ],
          const SizedBox(height: ThemeConfig.largeSpacing),
          const CupertinoActivityIndicator(
            radius: 12,
            color: ThemeConfig.connectingColor,
          ),
          if (widget.onCancel != null) ...[
            const SizedBox(height: ThemeConfig.largeSpacing),
            CupertinoButton(
              onPressed: widget.onCancel,
              child: Text(
                'Cancel',
                style: ThemeConfig.callout.copyWith(
                  color: ThemeConfig.errorColor,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class ServerLoadingWidget extends StatelessWidget {
  final String message;

  const ServerLoadingWidget({super.key, this.message = 'Loading servers...'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: ThemeConfig.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              CupertinoIcons.globe,
              size: 30,
              color: ThemeConfig.primaryColor,
            ),
          ),
          const SizedBox(height: ThemeConfig.mediumSpacing),
          Text(
            message,
            style: ThemeConfig.callout.copyWith(
              color: ThemeConfig.secondaryTextColor,
            ),
          ),
          const SizedBox(height: ThemeConfig.mediumSpacing),
          const CupertinoActivityIndicator(
            radius: 10,
            color: ThemeConfig.primaryColor,
          ),
        ],
      ),
    );
  }
}

class SubscriptionLoadingWidget extends StatelessWidget {
  final String message;

  const SubscriptionLoadingWidget({
    super.key,
    this.message = 'Processing subscription...',
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: ThemeConfig.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              CupertinoIcons.creditcard,
              size: 30,
              color: ThemeConfig.primaryColor,
            ),
          ),
          const SizedBox(height: ThemeConfig.mediumSpacing),
          Text(
            message,
            style: ThemeConfig.callout.copyWith(
              color: ThemeConfig.secondaryTextColor,
            ),
          ),
          const SizedBox(height: ThemeConfig.mediumSpacing),
          const CupertinoActivityIndicator(
            radius: 10,
            color: ThemeConfig.primaryColor,
          ),
        ],
      ),
    );
  }
}

// Inline loading widgets for smaller spaces
class InlineLoadingWidget extends StatelessWidget {
  final String? message;
  final LoadingSize size;
  final Color? color;

  const InlineLoadingWidget({
    super.key,
    this.message,
    this.size = LoadingSize.small,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CupertinoActivityIndicator(
          radius: _getRadius(),
          color: color ?? ThemeConfig.primaryColor,
        ),
        if (message != null) ...[
          SizedBox(width: _getSpacing()),
          Text(message!, style: _getTextStyle()),
        ],
      ],
    );
  }

  double _getRadius() {
    switch (size) {
      case LoadingSize.small:
        return 6.0;
      case LoadingSize.medium:
        return 8.0;
      case LoadingSize.large:
        return 10.0;
    }
  }

  double _getSpacing() {
    switch (size) {
      case LoadingSize.small:
        return 6.0;
      case LoadingSize.medium:
        return 8.0;
      case LoadingSize.large:
        return 10.0;
    }
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case LoadingSize.small:
        return ThemeConfig.caption1.copyWith(
          color: color ?? ThemeConfig.secondaryTextColor,
        );
      case LoadingSize.medium:
        return ThemeConfig.callout.copyWith(
          color: color ?? ThemeConfig.secondaryTextColor,
        );
      case LoadingSize.large:
        return ThemeConfig.body.copyWith(
          color: color ?? ThemeConfig.secondaryTextColor,
        );
    }
  }
}

// Shimmer loading widget for list items
class ShimmerLoadingWidget extends StatefulWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const ShimmerLoadingWidget({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  State<ShimmerLoadingWidget> createState() => _ShimmerLoadingWidgetState();
}

class _ShimmerLoadingWidgetState extends State<ShimmerLoadingWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
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
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(4),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [0.0, 0.5, 1.0],
              colors: [
                ThemeConfig.surfaceColor,
                ThemeConfig.borderColor.withOpacity(0.2),
                ThemeConfig.surfaceColor,
              ],
              transform: GradientRotation(_animation.value * 3.14159),
            ),
          ),
        );
      },
    );
  }
}

// Overlay loading widget
class OverlayLoadingWidget extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final String? message;
  final Color? backgroundColor;

  const OverlayLoadingWidget({
    super.key,
    required this.child,
    required this.isLoading,
    this.message,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: Container(
              color: (backgroundColor ?? CupertinoColors.black).withOpacity(
                0.5,
              ),
              child: LoadingWidget(
                message: message,
                color: CupertinoColors.white,
              ),
            ),
          ),
      ],
    );
  }
}

enum LoadingSize { small, medium, large }
