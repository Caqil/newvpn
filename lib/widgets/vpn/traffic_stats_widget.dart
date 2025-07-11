import 'package:flutter/cupertino.dart';
import '../../config/theme_config.dart';
import '../../utils/formatters.dart';

class TrafficStatsWidget extends StatelessWidget {
  final int totalDownloaded;
  final int totalUploaded;
  final double currentDownloadSpeed;
  final double currentUploadSpeed;
  final Duration sessionDuration;
  final TrafficStatsStyle style;
  final bool showSpeeds;
  final bool showDuration;

  const TrafficStatsWidget({
    super.key,
    required this.totalDownloaded,
    required this.totalUploaded,
    this.currentDownloadSpeed = 0.0,
    this.currentUploadSpeed = 0.0,
    this.sessionDuration = Duration.zero,
    this.style = TrafficStatsStyle.normal,
    this.showSpeeds = true,
    this.showDuration = true,
  });

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case TrafficStatsStyle.compact:
        return _buildCompactStats();
      case TrafficStatsStyle.card:
        return _buildCardStats();
      case TrafficStatsStyle.detailed:
        return _buildDetailedStats();
      case TrafficStatsStyle.normal:
      default:
        return _buildNormalStats();
    }
  }

  Widget _buildNormalStats() {
    return Container(
      padding: const EdgeInsets.all(ThemeConfig.mediumSpacing),
      decoration: BoxDecoration(
        color: ThemeConfig.cardColor,
        borderRadius: BorderRadius.circular(ThemeConfig.mediumRadius),
        border: Border.all(color: ThemeConfig.borderColor.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: ThemeConfig.mediumSpacing),
          _buildDataUsage(),
          if (showSpeeds) ...[
            const SizedBox(height: ThemeConfig.mediumSpacing),
            _buildCurrentSpeeds(),
          ],
          if (showDuration) ...[
            const SizedBox(height: ThemeConfig.mediumSpacing),
            _buildSessionInfo(),
          ],
        ],
      ),
    );
  }

  Widget _buildCompactStats() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: ThemeConfig.mediumSpacing,
        vertical: ThemeConfig.smallSpacing,
      ),
      decoration: BoxDecoration(
        color: ThemeConfig.cardColor,
        borderRadius: BorderRadius.circular(ThemeConfig.smallRadius),
        border: Border.all(color: ThemeConfig.borderColor.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          _buildCompactDataItem(
            '↓',
            Formatters.formatBytes(totalDownloaded),
            ThemeConfig.connectedColor,
          ),
          _buildDivider(),
          _buildCompactDataItem(
            '↑',
            Formatters.formatBytes(totalUploaded),
            ThemeConfig.secondaryColor,
          ),
          if (showSpeeds) ...[_buildDivider(), _buildCompactSpeedItem()],
        ],
      ),
    );
  }

  Widget _buildCardStats() {
    return Container(
      padding: const EdgeInsets.all(ThemeConfig.largeSpacing),
      decoration: BoxDecoration(
        color: ThemeConfig.cardColor,
        borderRadius: BorderRadius.circular(ThemeConfig.mediumRadius),
        border: Border.all(color: ThemeConfig.borderColor.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: ThemeConfig.largeSpacing),
          Row(
            children: [
              Expanded(
                child: _buildDataCard(
                  'Downloaded',
                  totalDownloaded,
                  ThemeConfig.connectedColor,
                  CupertinoIcons.arrow_down_circle,
                ),
              ),
              const SizedBox(width: ThemeConfig.mediumSpacing),
              Expanded(
                child: _buildDataCard(
                  'Uploaded',
                  totalUploaded,
                  ThemeConfig.secondaryColor,
                  CupertinoIcons.arrow_up_circle,
                ),
              ),
            ],
          ),
          if (showSpeeds) ...[
            const SizedBox(height: ThemeConfig.mediumSpacing),
            _buildSpeedCards(),
          ],
          if (showDuration) ...[
            const SizedBox(height: ThemeConfig.mediumSpacing),
            _buildSessionCard(),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailedStats() {
    return Container(
      padding: const EdgeInsets.all(ThemeConfig.largeSpacing),
      decoration: BoxDecoration(
        color: ThemeConfig.cardColor,
        borderRadius: BorderRadius.circular(ThemeConfig.mediumRadius),
        border: Border.all(color: ThemeConfig.borderColor.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailedHeader(),
          const SizedBox(height: ThemeConfig.largeSpacing),
          _buildDetailedDataUsage(),
          const SizedBox(height: ThemeConfig.mediumSpacing),
          _buildDetailedSpeeds(),
          const SizedBox(height: ThemeConfig.mediumSpacing),
          _buildDetailedMetrics(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Traffic Statistics',
          style: ThemeConfig.subhead.copyWith(fontWeight: FontWeight.w600),
        ),
        Icon(
          CupertinoIcons.chart_bar_circle,
          color: ThemeConfig.secondaryTextColor,
          size: 20,
        ),
      ],
    );
  }

  Widget _buildDetailedHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Session Statistics',
          style: ThemeConfig.headline.copyWith(fontWeight: FontWeight.w600),
        ),
        if (showDuration)
          Text(
            'Duration: ${Formatters.formatDuration(sessionDuration)}',
            style: ThemeConfig.caption1.copyWith(
              color: ThemeConfig.secondaryTextColor,
            ),
          ),
      ],
    );
  }

  Widget _buildDataUsage() {
    final totalData = totalDownloaded + totalUploaded;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total Data',
              style: ThemeConfig.caption1.copyWith(
                color: ThemeConfig.secondaryTextColor,
              ),
            ),
            Text(
              Formatters.formatBytes(totalData),
              style: ThemeConfig.callout.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: ThemeConfig.smallSpacing),
        Row(
          children: [
            Expanded(
              child: _buildDataBar(
                totalDownloaded,
                totalData,
                ThemeConfig.connectedColor,
                '↓ ${Formatters.formatBytes(totalDownloaded)}',
              ),
            ),
            const SizedBox(width: ThemeConfig.smallSpacing),
            Expanded(
              child: _buildDataBar(
                totalUploaded,
                totalData,
                ThemeConfig.secondaryColor,
                '↑ ${Formatters.formatBytes(totalUploaded)}',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailedDataUsage() {
    final totalData = totalDownloaded + totalUploaded;
    final downloadPercentage = totalData > 0
        ? (totalDownloaded / totalData) * 100
        : 0.0;
    final uploadPercentage = totalData > 0
        ? (totalUploaded / totalData) * 100
        : 0.0;

    return Container(
      padding: const EdgeInsets.all(ThemeConfig.mediumSpacing),
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceColor,
        borderRadius: BorderRadius.circular(ThemeConfig.smallRadius),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Data Usage',
                style: ThemeConfig.callout.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                Formatters.formatBytes(totalData),
                style: ThemeConfig.callout.copyWith(
                  fontWeight: FontWeight.w700,
                  color: ThemeConfig.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: ThemeConfig.mediumSpacing),
          _buildDetailedDataItem(
            'Downloaded',
            totalDownloaded,
            downloadPercentage,
            ThemeConfig.connectedColor,
            CupertinoIcons.arrow_down_circle,
          ),
          const SizedBox(height: ThemeConfig.smallSpacing),
          _buildDetailedDataItem(
            'Uploaded',
            totalUploaded,
            uploadPercentage,
            ThemeConfig.secondaryColor,
            CupertinoIcons.arrow_up_circle,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedDataItem(
    String label,
    int bytes,
    double percentage,
    Color color,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 8),
        Text(
          label,
          style: ThemeConfig.caption1.copyWith(
            color: ThemeConfig.secondaryTextColor,
          ),
        ),
        const Spacer(),
        Text(
          '${percentage.toStringAsFixed(1)}%',
          style: ThemeConfig.caption1.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          Formatters.formatBytes(bytes),
          style: ThemeConfig.caption1.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildCurrentSpeeds() {
    return Row(
      children: [
        Expanded(
          child: _buildSpeedItem(
            'Download',
            currentDownloadSpeed,
            ThemeConfig.connectedColor,
            CupertinoIcons.arrow_down,
          ),
        ),
        const SizedBox(width: ThemeConfig.mediumSpacing),
        Expanded(
          child: _buildSpeedItem(
            'Upload',
            currentUploadSpeed,
            ThemeConfig.secondaryColor,
            CupertinoIcons.arrow_up,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailedSpeeds() {
    return Container(
      padding: const EdgeInsets.all(ThemeConfig.mediumSpacing),
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceColor,
        borderRadius: BorderRadius.circular(ThemeConfig.smallRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current Speed',
            style: ThemeConfig.callout.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: ThemeConfig.mediumSpacing),
          Row(
            children: [
              Expanded(
                child: _buildDetailedSpeedItem(
                  'Download',
                  currentDownloadSpeed,
                  ThemeConfig.connectedColor,
                  CupertinoIcons.arrow_down_circle,
                ),
              ),
              const SizedBox(width: ThemeConfig.mediumSpacing),
              Expanded(
                child: _buildDetailedSpeedItem(
                  'Upload',
                  currentUploadSpeed,
                  ThemeConfig.secondaryColor,
                  CupertinoIcons.arrow_up_circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedSpeedItem(
    String label,
    double speed,
    Color color,
    IconData icon,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          Formatters.formatSpeed(speed),
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

  Widget _buildDetailedMetrics() {
    final avgSpeed = sessionDuration.inSeconds > 0
        ? (totalDownloaded + totalUploaded) / sessionDuration.inSeconds
        : 0.0;

    return Container(
      padding: const EdgeInsets.all(ThemeConfig.mediumSpacing),
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceColor,
        borderRadius: BorderRadius.circular(ThemeConfig.smallRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Session Metrics',
            style: ThemeConfig.callout.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: ThemeConfig.mediumSpacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMetricItem(
                'Duration',
                Formatters.formatDuration(sessionDuration),
              ),
              _buildMetricItem('Avg Speed', Formatters.formatSpeed(avgSpeed)),
              _buildMetricItem(
                'Total Data',
                Formatters.formatBytes(totalDownloaded + totalUploaded),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: ThemeConfig.caption1.copyWith(
            color: ThemeConfig.primaryColor,
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

  Widget _buildSessionInfo() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: ThemeConfig.smallSpacing,
        vertical: ThemeConfig.extraSmallSpacing,
      ),
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceColor,
        borderRadius: BorderRadius.circular(ThemeConfig.extraSmallSpacing),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            CupertinoIcons.clock,
            color: ThemeConfig.secondaryTextColor,
            size: 14,
          ),
          const SizedBox(width: 4),
          Text(
            'Session: ${Formatters.formatDuration(sessionDuration)}',
            style: ThemeConfig.caption2.copyWith(
              color: ThemeConfig.secondaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataBar(int value, int total, Color color, String label) {
    final percentage = total > 0 ? value / total : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: ThemeConfig.borderColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(3),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: ThemeConfig.caption2.copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildSpeedItem(
    String label,
    double speed,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(ThemeConfig.smallSpacing),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(ThemeConfig.smallRadius),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: ThemeConfig.caption2.copyWith(color: color)),
                Text(
                  Formatters.formatSpeed(speed),
                  style: ThemeConfig.caption1.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDataCard(String label, int bytes, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(ThemeConfig.mediumSpacing),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(ThemeConfig.mediumRadius),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: ThemeConfig.smallSpacing),
          Text(
            Formatters.formatBytes(bytes),
            style: ThemeConfig.callout.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(label, style: ThemeConfig.caption1.copyWith(color: color)),
        ],
      ),
    );
  }

  Widget _buildSpeedCards() {
    return Row(
      children: [
        Expanded(
          child: _buildSpeedCard(
            'Download Speed',
            currentDownloadSpeed,
            ThemeConfig.connectedColor,
            CupertinoIcons.arrow_down_circle,
          ),
        ),
        const SizedBox(width: ThemeConfig.mediumSpacing),
        Expanded(
          child: _buildSpeedCard(
            'Upload Speed',
            currentUploadSpeed,
            ThemeConfig.secondaryColor,
            CupertinoIcons.arrow_up_circle,
          ),
        ),
      ],
    );
  }

  Widget _buildSpeedCard(
    String label,
    double speed,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.all(ThemeConfig.mediumSpacing),
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceColor,
        borderRadius: BorderRadius.circular(ThemeConfig.smallRadius),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(
            Formatters.formatSpeed(speed),
            style: ThemeConfig.caption1.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            label,
            style: ThemeConfig.caption2.copyWith(
              color: ThemeConfig.secondaryTextColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSessionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(ThemeConfig.mediumSpacing),
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceColor,
        borderRadius: BorderRadius.circular(ThemeConfig.smallRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                CupertinoIcons.clock,
                color: ThemeConfig.primaryColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Session Duration',
                style: ThemeConfig.caption1.copyWith(
                  color: ThemeConfig.secondaryTextColor,
                ),
              ),
            ],
          ),
          Text(
            Formatters.formatDuration(sessionDuration),
            style: ThemeConfig.callout.copyWith(
              color: ThemeConfig.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactDataItem(String prefix, String value, Color color) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            prefix,
            style: ThemeConfig.caption1.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              value,
              style: ThemeConfig.caption1.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactSpeedItem() {
    return Expanded(
      child: Column(
        children: [
          Text(
            '${Formatters.formatSpeed(currentDownloadSpeed).split('/')[0]}/s',
            style: ThemeConfig.caption2.copyWith(
              color: ThemeConfig.connectedColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            '${Formatters.formatSpeed(currentUploadSpeed).split('/')[0]}/s',
            style: ThemeConfig.caption2.copyWith(
              color: ThemeConfig.secondaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 20,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: ThemeConfig.borderColor.withOpacity(0.3),
    );
  }
}

// Real-time traffic stats widget that updates automatically
class LiveTrafficStatsWidget extends StatefulWidget {
  final Stream<TrafficData>? trafficStream;
  final TrafficStatsStyle style;
  final bool showSpeeds;
  final bool showDuration;

  const LiveTrafficStatsWidget({
    super.key,
    this.trafficStream,
    this.style = TrafficStatsStyle.normal,
    this.showSpeeds = true,
    this.showDuration = true,
  });

  @override
  State<LiveTrafficStatsWidget> createState() => _LiveTrafficStatsWidgetState();
}

class _LiveTrafficStatsWidgetState extends State<LiveTrafficStatsWidget> {
  TrafficData _currentData = TrafficData.empty();

  @override
  void initState() {
    super.initState();
    widget.trafficStream?.listen((data) {
      if (mounted) {
        setState(() {
          _currentData = data;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TrafficStatsWidget(
      totalDownloaded: _currentData.totalDownloaded,
      totalUploaded: _currentData.totalUploaded,
      currentDownloadSpeed: _currentData.currentDownloadSpeed,
      currentUploadSpeed: _currentData.currentUploadSpeed,
      sessionDuration: _currentData.sessionDuration,
      style: widget.style,
      showSpeeds: widget.showSpeeds,
      showDuration: widget.showDuration,
    );
  }
}

// Data model for traffic statistics
class TrafficData {
  final int totalDownloaded;
  final int totalUploaded;
  final double currentDownloadSpeed;
  final double currentUploadSpeed;
  final Duration sessionDuration;
  final DateTime timestamp;

  const TrafficData({
    required this.totalDownloaded,
    required this.totalUploaded,
    required this.currentDownloadSpeed,
    required this.currentUploadSpeed,
    required this.sessionDuration,
    required this.timestamp,
  });

  factory TrafficData.empty() {
    return TrafficData(
      totalDownloaded: 0,
      totalUploaded: 0,
      currentDownloadSpeed: 0.0,
      currentUploadSpeed: 0.0,
      sessionDuration: Duration.zero,
      timestamp: DateTime.now(),
    );
  }

  TrafficData copyWith({
    int? totalDownloaded,
    int? totalUploaded,
    double? currentDownloadSpeed,
    double? currentUploadSpeed,
    Duration? sessionDuration,
    DateTime? timestamp,
  }) {
    return TrafficData(
      totalDownloaded: totalDownloaded ?? this.totalDownloaded,
      totalUploaded: totalUploaded ?? this.totalUploaded,
      currentDownloadSpeed: currentDownloadSpeed ?? this.currentDownloadSpeed,
      currentUploadSpeed: currentUploadSpeed ?? this.currentUploadSpeed,
      sessionDuration: sessionDuration ?? this.sessionDuration,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  int get totalData => totalDownloaded + totalUploaded;
  double get totalSpeed => currentDownloadSpeed + currentUploadSpeed;

  @override
  String toString() {
    return 'TrafficData(downloaded: $totalDownloaded, uploaded: $totalUploaded, '
        'downSpeed: $currentDownloadSpeed, upSpeed: $currentUploadSpeed, '
        'duration: $sessionDuration)';
  }
}

enum TrafficStatsStyle { normal, compact, card, detailed }
