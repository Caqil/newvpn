import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../config/theme_config.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonStyle style;
  final ButtonSize size;
  final IconData? icon;
  final bool isLoading;
  final bool isDisabled;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? width;
  final EdgeInsetsGeometry? padding;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.style = ButtonStyle.primary,
    this.size = ButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.isDisabled = false,
    this.backgroundColor,
    this.foregroundColor,
    this.width,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = !isDisabled && !isLoading && onPressed != null;

    return SizedBox(
      width: width,
      height: _getHeight(),
      child: CupertinoButton(
        onPressed: isEnabled ? onPressed : null,
        padding: padding ?? _getPadding(),
        color: _getBackgroundColor(isEnabled),
        borderRadius: BorderRadius.circular(_getBorderRadius()),
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (isLoading) {
      return _buildLoadingContent();
    }

    if (icon != null) {
      return _buildIconContent();
    }

    return _buildTextContent();
  }

  Widget _buildLoadingContent() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: _getIconSize(),
          height: _getIconSize(),
          child: CupertinoActivityIndicator(
            color: _getForegroundColor(true),
            radius: _getIconSize() / 2,
          ),
        ),
        const SizedBox(width: 8),
        Text('Loading...', style: _getTextStyle(true)),
      ],
    );
  }

  Widget _buildIconContent() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: _getIconSize(),
          color: _getForegroundColor(!isDisabled && !isLoading),
        ),
        if (text.isNotEmpty) ...[
          const SizedBox(width: 8),
          Text(text, style: _getTextStyle(!isDisabled && !isLoading)),
        ],
      ],
    );
  }

  Widget _buildTextContent() {
    return Text(
      text,
      style: _getTextStyle(!isDisabled && !isLoading),
      textAlign: TextAlign.center,
    );
  }

  double _getHeight() {
    switch (size) {
      case ButtonSize.small:
        return 32;
      case ButtonSize.medium:
        return 44;
      case ButtonSize.large:
        return 56;
    }
  }

  EdgeInsetsGeometry _getPadding() {
    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 10);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 20, vertical: 14);
    }
  }

  double _getBorderRadius() {
    switch (size) {
      case ButtonSize.small:
        return ThemeConfig.smallRadius;
      case ButtonSize.medium:
        return ThemeConfig.mediumRadius;
      case ButtonSize.large:
        return ThemeConfig.largeRadius;
    }
  }

  double _getIconSize() {
    switch (size) {
      case ButtonSize.small:
        return 16;
      case ButtonSize.medium:
        return 20;
      case ButtonSize.large:
        return 24;
    }
  }

  Color _getBackgroundColor(bool isEnabled) {
    if (backgroundColor != null) {
      return isEnabled ? backgroundColor! : backgroundColor!.withOpacity(0.5);
    }

    switch (style) {
      case ButtonStyle.primary:
        return isEnabled
            ? ThemeConfig.primaryColor
            : ThemeConfig.primaryColor.withOpacity(0.5);
      case ButtonStyle.secondary:
        return isEnabled
            ? ThemeConfig.surfaceColor
            : ThemeConfig.surfaceColor.withOpacity(0.5);
      case ButtonStyle.success:
        return isEnabled
            ? ThemeConfig.connectedColor
            : ThemeConfig.connectedColor.withOpacity(0.5);
      case ButtonStyle.danger:
        return isEnabled
            ? ThemeConfig.errorColor
            : ThemeConfig.errorColor.withOpacity(0.5);
      case ButtonStyle.warning:
        return isEnabled
            ? ThemeConfig.warningColor
            : ThemeConfig.warningColor.withOpacity(0.5);
      case ButtonStyle.outline:
        return CupertinoColors.transparent;
    }
  }

  Color _getForegroundColor(bool isEnabled) {
    if (foregroundColor != null) {
      return isEnabled ? foregroundColor! : foregroundColor!.withOpacity(0.5);
    }

    switch (style) {
      case ButtonStyle.primary:
      case ButtonStyle.success:
      case ButtonStyle.danger:
      case ButtonStyle.warning:
        return isEnabled
            ? CupertinoColors.white
            : CupertinoColors.white.withOpacity(0.7);
      case ButtonStyle.secondary:
        return isEnabled
            ? ThemeConfig.primaryTextColor
            : ThemeConfig.secondaryTextColor;
      case ButtonStyle.outline:
        return isEnabled
            ? ThemeConfig.primaryColor
            : ThemeConfig.primaryColor.withOpacity(0.5);
    }
  }

  TextStyle _getTextStyle(bool isEnabled) {
    TextStyle baseStyle;
    switch (size) {
      case ButtonSize.small:
        baseStyle = ThemeConfig.callout;
        break;
      case ButtonSize.medium:
        baseStyle = ThemeConfig.body;
        break;
      case ButtonSize.large:
        baseStyle = ThemeConfig.headline;
        break;
    }

    return baseStyle.copyWith(
      color: _getForegroundColor(isEnabled),
      fontWeight: FontWeight.w600,
    );
  }
}

// Specialized button variants
class PrimaryButton extends CustomButton {
  const PrimaryButton({
    super.key,
    required super.text,
    super.onPressed,
    super.icon,
    super.isLoading,
    super.isDisabled,
    super.size,
    super.width,
  }) : super(style: ButtonStyle.primary);
}

class SecondaryButton extends CustomButton {
  const SecondaryButton({
    super.key,
    required super.text,
    super.onPressed,
    super.icon,
    super.isLoading,
    super.isDisabled,
    super.size,
    super.width,
  }) : super(style: ButtonStyle.secondary);
}

class DangerButton extends CustomButton {
  const DangerButton({
    super.key,
    required super.text,
    super.onPressed,
    super.icon,
    super.isLoading,
    super.isDisabled,
    super.size,
    super.width,
  }) : super(style: ButtonStyle.danger);
}

class OutlineButton extends CustomButton {
  const OutlineButton({
    super.key,
    required super.text,
    super.onPressed,
    super.icon,
    super.isLoading,
    super.isDisabled,
    super.size,
    super.width,
  }) : super(style: ButtonStyle.outline);
}

// VPN specific buttons
class ConnectButton extends StatelessWidget {
  final bool isConnected;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ButtonSize size;

  const ConnectButton({
    super.key,
    required this.isConnected,
    this.onPressed,
    this.isLoading = false,
    this.size = ButtonSize.large,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: isConnected ? 'Disconnect' : 'Connect',
      onPressed: onPressed,
      isLoading: isLoading,
      size: size,
      style: isConnected ? ButtonStyle.danger : ButtonStyle.success,
      icon: isConnected ? CupertinoIcons.stop_fill : CupertinoIcons.play_fill,
      width: double.infinity,
    );
  }
}

class ServerSelectButton extends StatelessWidget {
  final String serverName;
  final String country;
  final String flagEmoji;
  final VoidCallback? onPressed;
  final bool isSelected;

  const ServerSelectButton({
    super.key,
    required this.serverName,
    required this.country,
    required this.flagEmoji,
    this.onPressed,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isSelected
            ? ThemeConfig.primaryColor.withOpacity(0.1)
            : ThemeConfig.cardColor,
        borderRadius: BorderRadius.circular(ThemeConfig.mediumRadius),
        border: Border.all(
          color: isSelected
              ? ThemeConfig.primaryColor
              : ThemeConfig.borderColor.withOpacity(0.2),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: CupertinoButton(
        onPressed: onPressed,
        padding: const EdgeInsets.all(ThemeConfig.mediumSpacing),
        child: Row(
          children: [
            Text(flagEmoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: ThemeConfig.mediumSpacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serverName,
                    style: ThemeConfig.body.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? ThemeConfig.primaryColor
                          : ThemeConfig.primaryTextColor,
                    ),
                  ),
                  Text(
                    country,
                    style: ThemeConfig.caption1.copyWith(
                      color: ThemeConfig.secondaryTextColor,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                CupertinoIcons.checkmark_circle_fill,
                color: ThemeConfig.primaryColor,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}

class SubscriptionButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final VoidCallback? onPressed;
  final bool isPopular;
  final bool isSelected;

  const SubscriptionButton({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    this.onPressed,
    this.isPopular = false,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: isSelected
            ? ThemeConfig.primaryColor.withOpacity(0.1)
            : ThemeConfig.cardColor,
        borderRadius: BorderRadius.circular(ThemeConfig.mediumRadius),
        border: Border.all(
          color: isSelected
              ? ThemeConfig.primaryColor
              : isPopular
              ? ThemeConfig.accentColor
              : ThemeConfig.borderColor.withOpacity(0.2),
          width: 2,
        ),
      ),
      child: Stack(
        children: [
          if (isPopular)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: const BoxDecoration(
                  color: ThemeConfig.accentColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(ThemeConfig.mediumRadius),
                    bottomLeft: Radius.circular(ThemeConfig.smallRadius),
                  ),
                ),
                child: Text(
                  'POPULAR',
                  style: ThemeConfig.caption2.copyWith(
                    color: CupertinoColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          CupertinoButton(
            onPressed: onPressed,
            padding: const EdgeInsets.all(ThemeConfig.mediumSpacing),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: ThemeConfig.headline.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? ThemeConfig.primaryColor
                              : ThemeConfig.primaryTextColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: ThemeConfig.caption1.copyWith(
                          color: ThemeConfig.secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      price,
                      style: ThemeConfig.title3.copyWith(
                        fontWeight: FontWeight.w700,
                        color: isSelected
                            ? ThemeConfig.primaryColor
                            : ThemeConfig.primaryTextColor,
                      ),
                    ),
                    if (isSelected)
                      const Icon(
                        CupertinoIcons.checkmark_circle_fill,
                        color: ThemeConfig.primaryColor,
                        size: 20,
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final ButtonSize size;
  final ButtonStyle style;
  final String? tooltip;

  const IconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.size = ButtonSize.medium,
    this.style = ButtonStyle.secondary,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final buttonSize = _getButtonSize();

    Widget button = Container(
      width: buttonSize,
      height: buttonSize,
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(_getBorderRadius()),
        border: style == ButtonStyle.outline
            ? Border.all(color: ThemeConfig.borderColor.withOpacity(0.3))
            : null,
      ),
      child: CupertinoButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        child: Icon(icon, size: _getIconSize(), color: _getForegroundColor()),
      ),
    );

    if (tooltip != null) {
      button = Tooltip(message: tooltip!, child: button);
    }

    return button;
  }

  double _getButtonSize() {
    switch (size) {
      case ButtonSize.small:
        return 32;
      case ButtonSize.medium:
        return 44;
      case ButtonSize.large:
        return 56;
    }
  }

  double _getIconSize() {
    switch (size) {
      case ButtonSize.small:
        return 16;
      case ButtonSize.medium:
        return 20;
      case ButtonSize.large:
        return 24;
    }
  }

  double _getBorderRadius() {
    return _getButtonSize() / 2; // Circular
  }

  Color _getBackgroundColor() {
    switch (style) {
      case ButtonStyle.primary:
        return ThemeConfig.primaryColor;
      case ButtonStyle.secondary:
        return ThemeConfig.surfaceColor;
      case ButtonStyle.success:
        return ThemeConfig.connectedColor;
      case ButtonStyle.danger:
        return ThemeConfig.errorColor;
      case ButtonStyle.warning:
        return ThemeConfig.warningColor;
      case ButtonStyle.outline:
        return CupertinoColors.transparent;
    }
  }

  Color _getForegroundColor() {
    switch (style) {
      case ButtonStyle.primary:
      case ButtonStyle.success:
      case ButtonStyle.danger:
      case ButtonStyle.warning:
        return CupertinoColors.white;
      case ButtonStyle.secondary:
        return ThemeConfig.primaryTextColor;
      case ButtonStyle.outline:
        return ThemeConfig.primaryColor;
    }
  }
}

enum ButtonStyle { primary, secondary, success, danger, warning, outline }

enum ButtonSize { small, medium, large }
