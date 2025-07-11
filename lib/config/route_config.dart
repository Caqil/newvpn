import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:newvpn/config/theme_config.dart';

class RouteConfig {
  // Route Names
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String permission = '/permission';
  static const String home = '/home';
  static const String servers = '/servers';
  static const String subscription = '/subscription';
  static const String paywall = '/paywall';
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String about = '/about';
  static const String privacy = '/privacy';
  static const String terms = '/terms';
  static const String support = '/support';

  // Route Paths
  static const String splashPath = '/';
  static const String onboardingPath = '/onboarding';
  static const String permissionPath = '/permission';
  static const String homePath = '/home';
  static const String serversPath = '/servers';
  static const String subscriptionPath = '/subscription';
  static const String paywallPath = '/paywall';
  static const String settingsPath = '/settings';
  static const String profilePath = '/profile';
  static const String aboutPath = '/about';
  static const String privacyPath = '/privacy';
  static const String termsPath = '/terms';
  static const String supportPath = '/support';

  // Tab Navigation
  static const String homeTab = '/home';
  static const String serversTab = '/servers';
  static const String profileTab = '/profile';
  static const String settingsTab = '/settings';

  // Router Configuration
  static final GoRouter router = GoRouter(
    initialLocation: splashPath,
    debugLogDiagnostics: true,
    routes: [
      // Splash Screen
      GoRoute(
        path: splashPath,
        name: splash,
        builder: (context, state) => const SplashScreen(),
      ),

      // Onboarding Flow
      GoRoute(
        path: onboardingPath,
        name: onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),

      GoRoute(
        path: permissionPath,
        name: permission,
        builder: (context, state) => const PermissionScreen(),
      ),

      // Main App Shell with Bottom Navigation
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          // Home Tab
          GoRoute(
            path: homePath,
            name: home,
            builder: (context, state) => const HomeScreen(),
          ),

          // Servers Tab
          GoRoute(
            path: serversPath,
            name: servers,
            builder: (context, state) => const ServersScreen(),
          ),

          // Profile Tab
          GoRoute(
            path: profilePath,
            name: profile,
            builder: (context, state) => const ProfileScreen(),
          ),

          // Settings Tab
          GoRoute(
            path: settingsPath,
            name: settings,
            builder: (context, state) => const SettingsScreen(),
            routes: [
              // Settings Sub-routes
              GoRoute(
                path: 'about',
                name: about,
                builder: (context, state) => const AboutScreen(),
              ),
              GoRoute(
                path: 'privacy',
                name: privacy,
                builder: (context, state) => const PrivacyScreen(),
              ),
              GoRoute(
                path: 'terms',
                name: terms,
                builder: (context, state) => const TermsScreen(),
              ),
              GoRoute(
                path: 'support',
                name: support,
                builder: (context, state) => const SupportScreen(),
              ),
            ],
          ),
        ],
      ),

      // Subscription & Paywall (Full Screen)
      GoRoute(
        path: subscriptionPath,
        name: subscription,
        builder: (context, state) => const SubscriptionScreen(),
      ),

      GoRoute(
        path: paywallPath,
        name: paywall,
        builder: (context, state) => const PaywallScreen(),
      ),
    ],

    // Error handling
    errorBuilder: (context, state) => ErrorScreen(error: state.error),

    // Redirect logic
    redirect: (context, state) {
      // Add your redirect logic here
      // For example, check if user is onboarded, authenticated, etc.
      return null; // No redirect
    },
  );

  // Navigation helpers
  static void goToHome(BuildContext context) {
    context.goNamed(home);
  }

  static void goToServers(BuildContext context) {
    context.goNamed(servers);
  }

  static void goToSubscription(BuildContext context) {
    context.goNamed(subscription);
  }

  static void goToPaywall(BuildContext context) {
    context.goNamed(paywall);
  }

  static void goToSettings(BuildContext context) {
    context.goNamed(settings);
  }

  static void goToProfile(BuildContext context) {
    context.goNamed(profile);
  }

  static void goToAbout(BuildContext context) {
    context.goNamed(about);
  }

  static void goToPrivacy(BuildContext context) {
    context.goNamed(privacy);
  }

  static void goToTerms(BuildContext context) {
    context.goNamed(terms);
  }

  static void goToSupport(BuildContext context) {
    context.goNamed(support);
  }

  // Back navigation
  static void goBack(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.goNamed(home);
    }
  }

  // Check current route
  static bool isCurrentRoute(BuildContext context, String routeName) {
    final currentRoute = GoRouterState.of(context).name;
    return currentRoute == routeName;
  }

  // Get current route name
  static String? getCurrentRouteName(BuildContext context) {
    return GoRouterState.of(context).name;
  }

  // Get current route path
  static String getCurrentPath(BuildContext context) {
    return GoRouterState.of(context).uri.toString();
  }
}

// Main Shell Widget for Bottom Navigation
class MainShell extends StatefulWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<String> _routes = [
    RouteConfig.homePath,
    RouteConfig.serversPath,
    RouteConfig.profilePath,
    RouteConfig.settingsPath,
  ];

  void _onTabTapped(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
      context.go(_routes[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Update current index based on route
    final currentPath = GoRouterState.of(context).uri.toString();
    final newIndex = _routes.indexOf(currentPath);
    if (newIndex != -1 && newIndex != _currentIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _currentIndex = newIndex;
        });
      });
    }

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        activeColor: ThemeConfig.primaryColor,
        inactiveColor: ThemeConfig.secondaryTextColor,
        backgroundColor: ThemeConfig.surfaceColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house),
            activeIcon: Icon(CupertinoIcons.house_fill),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.globe),
            activeIcon: Icon(CupertinoIcons.globe),
            label: 'Servers',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            activeIcon: Icon(CupertinoIcons.person_fill),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings),
            activeIcon: Icon(CupertinoIcons.settings_solid),
            label: 'Settings',
          ),
        ],
      ),
      tabBuilder: (context, index) => widget.child,
    );
  }
}

// Placeholder screens - replace with actual implementations
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const CupertinoPageScaffold(child: Center(child: Text('Splash Screen')));
}

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  @override
  Widget build(BuildContext context) => const CupertinoPageScaffold(
    child: Center(child: Text('Onboarding Screen')),
  );
}

class PermissionScreen extends StatelessWidget {
  const PermissionScreen({super.key});
  @override
  Widget build(BuildContext context) => const CupertinoPageScaffold(
    child: Center(child: Text('Permission Screen')),
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const CupertinoPageScaffold(child: Center(child: Text('Home Screen')));
}

class ServersScreen extends StatelessWidget {
  const ServersScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const CupertinoPageScaffold(child: Center(child: Text('Servers Screen')));
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const CupertinoPageScaffold(child: Center(child: Text('Profile Screen')));
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) => const CupertinoPageScaffold(
    child: Center(child: Text('Settings Screen')),
  );
}

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});
  @override
  Widget build(BuildContext context) => const CupertinoPageScaffold(
    child: Center(child: Text('Subscription Screen')),
  );
}

class PaywallScreen extends StatelessWidget {
  const PaywallScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const CupertinoPageScaffold(child: Center(child: Text('Paywall Screen')));
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const CupertinoPageScaffold(child: Center(child: Text('About Screen')));
}

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const CupertinoPageScaffold(child: Center(child: Text('Privacy Screen')));
}

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const CupertinoPageScaffold(child: Center(child: Text('Terms Screen')));
}

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});
  @override
  Widget build(BuildContext context) =>
      const CupertinoPageScaffold(child: Center(child: Text('Support Screen')));
}

class ErrorScreen extends StatelessWidget {
  final Exception? error;
  const ErrorScreen({super.key, this.error});
  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
    child: Center(child: Text('Error: ${error.toString()}')),
  );
}
