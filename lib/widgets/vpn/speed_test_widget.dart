import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import '../../config/theme_config.dart';
import '../../utils/formatters.dart';

class SpeedTestWidget extends StatefulWidget {
  final VoidCallback? onStartTest;
  final bool isConnected;
  final String? serverLocation;

  const SpeedTestWidget({
    super.key,
    this.onStartTest,
    required this.isConnected,
    this.serverLocation,
  });

  @override
  State<SpeedTestWidget> createState() => _SpeedTestWidgetState();
}

class _SpeedTestWidgetState extends State<SpeedTestWidget>
    with TickerProviderStateMixin {
  SpeedTestState _testState = SpeedTestState.idle;
  double _downloadSpeed = 0.0;
  double _uploadSpeed = 0.0;
  double _ping = 0.0;
  double _jitter = 0.0;
  double _progress = 0.0;
  String _currentTest = '';

  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  Timer? _testTimer;
  Timer? _progressTimer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _testTimer?.cancel();
    _progressTimer?.cancel();
    super.dispose();
  }

  void _startSpeedTest() async {
    if (!widget.isConnected) return;

    setState(() {
      _testState = SpeedTestState.testing;
      _downloadSpeed = 0.0;
      _uploadSpeed = 0.0;
      _ping = 0.0;
      _jitter = 0.0;
      _progress = 0.0;
      _currentTest = 'Initializing...';
    });

    _animationController.repeat();
    widget.onStartTest?.call();

    // Simulate speed test
    await _runPingTest();
    await _runDownloadTest();
    await _runUploadTest();

    _animationController.stop();
    setState(() {
      _testState = SpeedTestState.completed;
      _currentTest = 'Test completed';
      _progress = 1.0;
    });
  }

  Future<void> _runPingTest() async {
    setState(() {
      _currentTest = 'Testing ping...';
    });

    await _simulateProgressTest(Duration(seconds: 2), 0.0, 0.2, (progress) {
      final pingValue = 10 + Random().nextDouble() * 40; // 10-50ms
      setState(() {
        _ping = pingValue;
        _jitter = Random().nextDouble() * 5; // 0-5ms
        _progress = progress;
      });
    });
  }

  Future<void> _runDownloadTest() async {
    setState(() {
      _currentTest = 'Testing download speed...';
    });

    await _simulateProgressTest(Duration(seconds: 4), 0.2, 0.6, (progress) {
      final maxSpeed = 50 + Random().nextDouble() * 100; // 50-150 Mbps
      final currentSpeed = maxSpeed * (progress - 0.2) / 0.4;
      setState(() {
        _downloadSpeed = currentSpeed * 1024 * 1024 / 8; // Convert to bytes/sec
        _progress = progress;
      });
    });
  }

  Future<void> _runUploadTest() async {
    setState(() {
      _currentTest = 'Testing upload speed...';
    });

    await _simulateProgressTest(Duration(seconds: 4), 0.6, 1.0, (progress) {
      final maxSpeed = 25 + Random().nextDouble() * 50; // 25-75 Mbps
      final currentSpeed = maxSpeed * (progress - 0.6) / 0.4;
      setState(() {
        _uploadSpeed = currentSpeed * 1024 * 1024 / 8; // Convert to bytes/sec
        _progress = progress;
      });
    });
  }

  Future<void> _simulateProgressTest(
    Duration duration,
    double startProgress,
    double endProgress,
    Function(double) onProgress,
  ) async {
    final completer = Completer<void>();
    final totalSteps = 20;
    var currentStep = 0;

    _progressTimer = Timer.periodic(
      Duration(milliseconds: duration.inMilliseconds ~/ totalSteps),
      (timer) {
        currentStep++;
        final progress =
            startProgress +
            (endProgress - startProgress) * (currentStep / totalSteps);
        onProgress(progress);

        if (currentStep >= totalSteps) {
          timer.cancel();
          completer.complete();
        }
      },
    );

    return completer.future;
  }

  void _resetTest() {
    setState(() {
      _testState = SpeedTestState.idle;
      _downloadSpeed = 0.0;
      _uploadSpeed = 0.0;
      _ping = 0.0;
      _jitter = 0.0;
      _progress = 0.0;
      _currentTest = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ThemeConfig.mediumSpacing),
      decoration: BoxDecoration(
        color: ThemeConfig.cardColor,
        borderRadius: BorderRadius.circular(ThemeConfig.mediumRadius),
        border: Border.all(color: ThemeConfig.borderColor.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: ThemeConfig.mediumSpacing),
          _buildMainContent(),
          if (_testState == SpeedTestState.completed) ...[
            const SizedBox(height: ThemeConfig.mediumSpacing),
            _buildResults(),
          ],
          const SizedBox(height: ThemeConfig.mediumSpacing),
          _buildActionButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Speed Test',
              style: ThemeConfig.headline.copyWith(fontWeight: FontWeight.w600),
            ),
            if (widget.serverLocation != null)
              Text(
                widget.serverLocation!,
                style: ThemeConfig.caption1.copyWith(
                  color: ThemeConfig.secondaryTextColor,
                ),
              ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: widget.isConnected
                ? ThemeConfig.connectedColor.withOpacity(0.1)
                : ThemeConfig.disconnectedColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(ThemeConfig.smallRadius),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: widget.isConnected
                      ? ThemeConfig.connectedColor
                      : ThemeConfig.disconnectedColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                widget.isConnected ? 'Connected' : 'Disconnected',
                style: ThemeConfig.caption2.copyWith(
                  color: widget.isConnected
                      ? ThemeConfig.connectedColor
                      : ThemeConfig.disconnectedColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMainContent() {
    switch (_testState) {
      case SpeedTestState.idle:
        return _buildIdleState();
      case SpeedTestState.testing:
        return _buildTestingState();
      case SpeedTestState.completed:
        return _buildCompletedState();
    }
  }

  Widget _buildIdleState() {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: ThemeConfig.primaryColor.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(
              color: ThemeConfig.primaryColor.withOpacity(0.3),
              width: 2,
            ),
          ),
          child: const Icon(
            CupertinoIcons.speedometer,
            size: 60,
            color: ThemeConfig.primaryColor,
          ),
        ),
        const SizedBox(height: ThemeConfig.mediumSpacing),
        Text(
          'Test Your Connection Speed',
          style: ThemeConfig.callout.copyWith(
            color: ThemeConfig.secondaryTextColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTestingState() {
    return Column(
      children: [
        SizedBox(
          width: 120,
          height: 120,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CupertinoActivityIndicator(),
              AnimatedBuilder(
                animation: _rotationAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationAnimation.value,
                    child: const Icon(
                      CupertinoIcons.speedometer,
                      size: 40,
                      color: ThemeConfig.primaryColor,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: ThemeConfig.mediumSpacing),
        Text(
          _currentTest,
          style: ThemeConfig.callout.copyWith(
            color: ThemeConfig.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: ThemeConfig.smallSpacing),
        Text(
          '${(_progress * 100).toInt()}%',
          style: ThemeConfig.caption1.copyWith(
            color: ThemeConfig.secondaryTextColor,
          ),
        ),
        if (_downloadSpeed > 0 || _uploadSpeed > 0) ...[
          const SizedBox(height: ThemeConfig.mediumSpacing),
          _buildCurrentSpeeds(),
        ],
      ],
    );
  }

  Widget _buildCompletedState() {
    return Column(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: ThemeConfig.connectedColor.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: ThemeConfig.connectedColor, width: 2),
          ),
          child: const Icon(
            CupertinoIcons.checkmark,
            size: 60,
            color: ThemeConfig.connectedColor,
          ),
        ),
        const SizedBox(height: ThemeConfig.mediumSpacing),
        Text(
          'Test Completed',
          style: ThemeConfig.callout.copyWith(
            color: ThemeConfig.connectedColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentSpeeds() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (_downloadSpeed > 0)
          Column(
            children: [
              Text(
                '↓ Download',
                style: ThemeConfig.caption2.copyWith(
                  color: ThemeConfig.secondaryTextColor,
                ),
              ),
              Text(
                Formatters.formatSpeed(_downloadSpeed),
                style: ThemeConfig.callout.copyWith(
                  color: ThemeConfig.connectedColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        if (_uploadSpeed > 0)
          Column(
            children: [
              Text(
                '↑ Upload',
                style: ThemeConfig.caption2.copyWith(
                  color: ThemeConfig.secondaryTextColor,
                ),
              ),
              Text(
                Formatters.formatSpeed(_uploadSpeed),
                style: ThemeConfig.callout.copyWith(
                  color: ThemeConfig.secondaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildResults() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(ThemeConfig.mediumSpacing),
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceColor,
        borderRadius: BorderRadius.circular(ThemeConfig.smallRadius),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildResultItem(
                'Download',
                Formatters.formatSpeed(_downloadSpeed),
                ThemeConfig.connectedColor,
                CupertinoIcons.arrow_down_circle,
              ),
              _buildResultItem(
                'Upload',
                Formatters.formatSpeed(_uploadSpeed),
                ThemeConfig.secondaryColor,
                CupertinoIcons.arrow_up_circle,
              ),
            ],
          ),
          const SizedBox(height: ThemeConfig.mediumSpacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildResultItem(
                'Ping',
                '${_ping.toStringAsFixed(0)}ms',
                ThemeConfig.primaryColor,
                CupertinoIcons.clock,
              ),
              _buildResultItem(
                'Jitter',
                '${_jitter.toStringAsFixed(1)}ms',
                ThemeConfig.warningColor,
                CupertinoIcons.waveform,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultItem(
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: ThemeConfig.callout.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          label,
          style: ThemeConfig.caption2.copyWith(
            color: ThemeConfig.secondaryTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton() {
    switch (_testState) {
      case SpeedTestState.idle:
        return SizedBox(
          width: double.infinity,
          child: CupertinoButton(
            onPressed: widget.isConnected ? _startSpeedTest : null,
            color: widget.isConnected
                ? ThemeConfig.primaryColor
                : ThemeConfig.borderColor,
            borderRadius: BorderRadius.circular(ThemeConfig.mediumRadius),
            child: Text(
              widget.isConnected ? 'Start Speed Test' : 'Connect VPN First',
              style: ThemeConfig.callout.copyWith(
                color: CupertinoColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );

      case SpeedTestState.testing:
        return SizedBox(
          width: double.infinity,
          child: CupertinoButton(
            onPressed: null,
            color: ThemeConfig.borderColor,
            borderRadius: BorderRadius.circular(ThemeConfig.mediumRadius),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CupertinoActivityIndicator(
                  radius: 8,
                  color: CupertinoColors.white,
                ),
                const SizedBox(width: 8),
                Text(
                  'Testing...',
                  style: ThemeConfig.callout.copyWith(
                    color: CupertinoColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );

      case SpeedTestState.completed:
        return SizedBox(
          width: double.infinity,
          child: CupertinoButton(
            onPressed: _resetTest,
            color: ThemeConfig.primaryColor,
            borderRadius: BorderRadius.circular(ThemeConfig.mediumRadius),
            child: Text(
              'Test Again',
              style: ThemeConfig.callout.copyWith(
                color: CupertinoColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
    }
  }
}

// Compact speed test widget for smaller spaces
class CompactSpeedTestWidget extends StatelessWidget {
  final double? downloadSpeed;
  final double? uploadSpeed;
  final int? ping;
  final VoidCallback? onTap;

  const CompactSpeedTestWidget({
    super.key,
    this.downloadSpeed,
    this.uploadSpeed,
    this.ping,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(ThemeConfig.mediumSpacing),
        decoration: BoxDecoration(
          color: ThemeConfig.cardColor,
          borderRadius: BorderRadius.circular(ThemeConfig.mediumRadius),
          border: Border.all(color: ThemeConfig.borderColor.withOpacity(0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Connection Speed',
                  style: ThemeConfig.subhead.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Icon(
                  CupertinoIcons.chevron_right,
                  color: ThemeConfig.secondaryTextColor,
                  size: 16,
                ),
              ],
            ),
            const SizedBox(height: ThemeConfig.smallSpacing),
            if (downloadSpeed != null && uploadSpeed != null) ...[
              Row(
                children: [
                  Expanded(
                    child: _buildSpeedItem(
                      '↓',
                      Formatters.formatSpeed(downloadSpeed!),
                      ThemeConfig.connectedColor,
                    ),
                  ),
                  const SizedBox(width: ThemeConfig.mediumSpacing),
                  Expanded(
                    child: _buildSpeedItem(
                      '↑',
                      Formatters.formatSpeed(uploadSpeed!),
                      ThemeConfig.secondaryColor,
                    ),
                  ),
                  if (ping != null) ...[
                    const SizedBox(width: ThemeConfig.mediumSpacing),
                    _buildPingItem(),
                  ],
                ],
              ),
            ] else ...[
              Text(
                'Tap to test speed',
                style: ThemeConfig.caption1.copyWith(
                  color: ThemeConfig.secondaryTextColor,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSpeedItem(String label, String speed, Color color) {
    return Row(
      children: [
        Text(
          label,
          style: ThemeConfig.caption1.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            speed,
            style: ThemeConfig.caption1.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildPingItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${ping}ms',
          style: ThemeConfig.caption1.copyWith(
            color: ThemeConfig.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          'ping',
          style: ThemeConfig.caption2.copyWith(
            color: ThemeConfig.tertiaryTextColor,
          ),
        ),
      ],
    );
  }
}

enum SpeedTestState { idle, testing, completed }
