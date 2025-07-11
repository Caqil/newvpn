import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../config/theme_config.dart';

class CustomAppBar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  final String title;
  final Widget? leading;
  final List<Widget>? trailing;
  final bool automaticallyImplyLeading;
  final bool automaticallyImplyMiddle;
  final String? previousPageTitle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool border;
  final double? elevation;
  final bool centerTitle;
  final Widget? subtitle;
  final VoidCallback? onLeadingPressed;
  final bool showConnectionStatus;
  final bool isConnected;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leading,
    this.trailing,
    this.automaticallyImplyLeading = true,
    this.automaticallyImplyMiddle = true,
    this.previousPageTitle,
    this.backgroundColor,
    this.foregroundColor,
    this.border = true,
    this.elevation,
    this.centerTitle = true,
    this.subtitle,
    this.onLeadingPressed,
    this.showConnectionStatus = false,
    this.isConnected = false,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoNavigationBar(
      leading: _buildLeading(context),
      middle: _buildMiddle(),
      trailing: _buildTrailing(),
      automaticallyImplyLeading: automaticallyImplyLeading,
      automaticallyImplyMiddle: automaticallyImplyMiddle,
      previousPageTitle: previousPageTitle,
      backgroundColor: backgroundColor ?? ThemeConfig.surfaceColor,
      border: border
          ? const Border(
              bottom: BorderSide(color: ThemeConfig.borderColor, width: 0.5),
            )
          : null,
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (leading != null) return leading;

    if (onLeadingPressed != null) {
      return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onLeadingPressed,
        child: Icon(
          CupertinoIcons.back,
          color: foregroundColor ?? ThemeConfig.primaryTextColor,
        ),
      );
    }

    return null;
  }

  Widget _buildMiddle() {
    if (centerTitle) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showConnectionStatus) ...[
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isConnected
                        ? ThemeConfig.connectedColor
                        : ThemeConfig.disconnectedColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  title,
                  style: ThemeConfig.headline.copyWith(
                    color: foregroundColor ?? ThemeConfig.primaryTextColor,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 2),
            DefaultTextStyle(
              style: ThemeConfig.caption1.copyWith(
                color: (foregroundColor ?? ThemeConfig.primaryTextColor)
                    .withOpacity(0.7),
              ),
              child: subtitle!,
            ),
          ],
        ],
      );
    }

    return Row(
      children: [
        if (showConnectionStatus) ...[
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: isConnected
                  ? ThemeConfig.connectedColor
                  : ThemeConfig.disconnectedColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: ThemeConfig.headline.copyWith(
                  color: foregroundColor ?? ThemeConfig.primaryTextColor,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                DefaultTextStyle(
                  style: ThemeConfig.caption1.copyWith(
                    color: (foregroundColor ?? ThemeConfig.primaryTextColor)
                        .withOpacity(0.7),
                  ),
                  child: subtitle!,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget? _buildTrailing() {
    if (trailing == null || trailing!.isEmpty) return null;

    if (trailing!.length == 1) {
      return trailing!.first;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: trailing!
          .map(
            (widget) =>
                Padding(padding: const EdgeInsets.only(left: 8), child: widget),
          )
          .toList(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(44);

  @override
  bool shouldFullyObstruct(BuildContext context) => true;
}

// Specialized app bars for common VPN app scenarios

class VpnAppBar extends CustomAppBar {
   VpnAppBar({
    super.key,
    required super.title,
    super.leading,
    super.trailing,
    required bool isConnected,
    String? serverName,
  }) : super(
         showConnectionStatus: true,
         isConnected: isConnected,
         subtitle: serverName != null ? Text(serverName) : null,
       );
}

class ServerSelectionAppBar extends CustomAppBar {
  const ServerSelectionAppBar({super.key, super.leading, List<Widget>? actions})
    : super(title: 'Select Server', trailing: actions, centerTitle: false);
}

class SettingsAppBar extends CustomAppBar {
  const SettingsAppBar({super.key, super.leading, List<Widget>? actions})
    : super(title: 'Settings', trailing: actions, centerTitle: false);
}

class SubscriptionAppBar extends CustomAppBar {
  const SubscriptionAppBar({super.key, super.leading, super.onLeadingPressed})
    : super(
        title: 'Premium',
        backgroundColor: ThemeConfig.primaryColor,
        foregroundColor: CupertinoColors.white,
        border: false,
      );
}

class ProfileAppBar extends CustomAppBar {
  const ProfileAppBar({
    super.key,
    super.leading,
    List<Widget>? actions,
    required bool isPremium,
  }) : super(
         title: 'Profile',
         trailing: actions,
         subtitle: isPremium
             ? const Text('Premium User')
             : const Text('Free User'),
         centerTitle: false,
       );
}

// Action buttons for app bar trailing
class AppBarIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color? color;
  final String? tooltip;
  final bool showBadge;
  final String? badgeText;

  const AppBarIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.color,
    this.tooltip,
    this.showBadge = false,
    this.badgeText,
  });

  @override
  Widget build(BuildContext context) {
    Widget button = CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Icon(
        icon,
        color: color ?? ThemeConfig.primaryTextColor,
        size: ThemeConfig.mediumIconSize,
      ),
    );

    if (showBadge) {
      button = Stack(
        clipBehavior: Clip.none,
        children: [
          button,
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              height: 16,
              decoration: const BoxDecoration(
                color: ThemeConfig.errorColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  badgeText ?? '',
                  style: const TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    if (tooltip != null) {
      button = Tooltip(message: tooltip!, child: button);
    }

    return button;
  }
}

class AppBarTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final FontWeight? fontWeight;

  const AppBarTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      onPressed: onPressed,
      child: Text(
        text,
        style: ThemeConfig.callout.copyWith(
          color: color ?? ThemeConfig.primaryColor,
          fontWeight: fontWeight ?? FontWeight.w600,
        ),
      ),
    );
  }
}

// Connection status widget for app bar
class ConnectionStatusWidget extends StatelessWidget {
  final bool isConnected;
  final String? serverName;
  final VoidCallback? onTap;

  const ConnectionStatusWidget({
    super.key,
    required this.isConnected,
    this.serverName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color:
              (isConnected
                      ? ThemeConfig.connectedColor
                      : ThemeConfig.disconnectedColor)
                  .withOpacity(0.1),
          borderRadius: BorderRadius.circular(ThemeConfig.smallRadius),
          border: Border.all(
            color: isConnected
                ? ThemeConfig.connectedColor
                : ThemeConfig.disconnectedColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: isConnected
                    ? ThemeConfig.connectedColor
                    : ThemeConfig.disconnectedColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              isConnected ? (serverName ?? 'Connected') : 'Disconnected',
              style: ThemeConfig.caption1.copyWith(
                color: isConnected
                    ? ThemeConfig.connectedColor
                    : ThemeConfig.disconnectedColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
