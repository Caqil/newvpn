import 'package:flutter/cupertino.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../config/theme_config.dart';
import '../../utils/formatters.dart';

class SpeedChart extends StatefulWidget {
  final List<SpeedDataPoint> downloadData;
  final List<SpeedDataPoint> uploadData;
  final Duration timeWindow;
  final bool showLegend;
  final bool showGrid;
  final String title;
  final double height;

  const SpeedChart({
    super.key,
    required this.downloadData,
    required this.uploadData,
    this.timeWindow = const Duration(minutes: 5),
    this.showLegend = true,
    this.showGrid = true,
    this.title = 'Connection Speed',
    this.height = 200,
  });

  @override
  State<SpeedChart> createState() => _SpeedChartState();
}

class _SpeedChartState extends State<SpeedChart> {
  bool _showDownload = true;
  bool _showUpload = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
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
          const SizedBox(height: ThemeConfig.smallSpacing),
          Expanded(child: _buildChart()),
          if (widget.showLegend) ...[
            const SizedBox(height: ThemeConfig.smallSpacing),
            _buildLegend(),
          ],
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: ThemeConfig.headline.copyWith(fontWeight: FontWeight.w600),
        ),
        _buildCurrentSpeeds(),
      ],
    );
  }

  Widget _buildCurrentSpeeds() {
    final currentDownload = widget.downloadData.isNotEmpty
        ? widget.downloadData.last.speed
        : 0.0;
    final currentUpload = widget.uploadData.isNotEmpty
        ? widget.uploadData.last.speed
        : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: ThemeConfig.connectedColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '↓ ${Formatters.formatSpeed(currentDownload)}',
              style: ThemeConfig.caption1.copyWith(
                color: ThemeConfig.connectedColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: ThemeConfig.secondaryColor,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              '↑ ${Formatters.formatSpeed(currentUpload)}',
              style: ThemeConfig.caption1.copyWith(
                color: ThemeConfig.secondaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildChart() {
    if (widget.downloadData.isEmpty && widget.uploadData.isEmpty) {
      return _buildEmptyState();
    }

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: widget.showGrid,
          drawVerticalLine: true,
          drawHorizontalLine: true,
          horizontalInterval: _getHorizontalInterval(),
          verticalInterval: _getVerticalInterval(),
          getDrawingHorizontalLine: (value) => FlLine(
            color: ThemeConfig.borderColor.withOpacity(0.2),
            strokeWidth: 1,
          ),
          getDrawingVerticalLine: (value) => FlLine(
            color: ThemeConfig.borderColor.withOpacity(0.2),
            strokeWidth: 1,
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 30,
              interval: _getVerticalInterval(),
              getTitlesWidget: _getBottomTitles,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: _getHorizontalInterval(),
              reservedSize: 60,
              getTitlesWidget: _getLeftTitles,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: _getMinX(),
        maxX: _getMaxX(),
        minY: 0,
        maxY: _getMaxY(),
        lineBarsData: _buildLineBars(),
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            getTooltipItems: _getTooltipItems,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.line_horizontal_3,
            size: 48,
            color: ThemeConfig.secondaryTextColor,
          ),
          const SizedBox(height: ThemeConfig.smallSpacing),
          Text(
            'No speed data available',
            style: ThemeConfig.subhead.copyWith(
              color: ThemeConfig.secondaryTextColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Connect to VPN to see speed metrics',
            style: ThemeConfig.caption1.copyWith(
              color: ThemeConfig.tertiaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  List<LineChartBarData> _buildLineBars() {
    final bars = <LineChartBarData>[];

    if (_showDownload && widget.downloadData.isNotEmpty) {
      bars.add(
        LineChartBarData(
          spots: widget.downloadData
              .map(
                (data) => FlSpot(
                  data.timestamp.millisecondsSinceEpoch.toDouble(),
                  data.speed,
                ),
              )
              .toList(),
          isCurved: true,
          curveSmoothness: 0.3,
          color: ThemeConfig.connectedColor,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            color: ThemeConfig.connectedColor.withOpacity(0.1),
          ),
        ),
      );
    }

    if (_showUpload && widget.uploadData.isNotEmpty) {
      bars.add(
        LineChartBarData(
          spots: widget.uploadData
              .map(
                (data) => FlSpot(
                  data.timestamp.millisecondsSinceEpoch.toDouble(),
                  data.speed,
                ),
              )
              .toList(),
          isCurved: true,
          curveSmoothness: 0.3,
          color: ThemeConfig.secondaryColor,
          barWidth: 3,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          belowBarData: BarAreaData(
            show: true,
            color: ThemeConfig.secondaryColor.withOpacity(0.1),
          ),
        ),
      );
    }

    return bars;
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLegendItem(
          'Download',
          ThemeConfig.connectedColor,
          _showDownload,
          () => setState(() => _showDownload = !_showDownload),
        ),
        const SizedBox(width: ThemeConfig.largeSpacing),
        _buildLegendItem(
          'Upload',
          ThemeConfig.secondaryColor,
          _showUpload,
          () => setState(() => _showUpload = !_showUpload),
        ),
      ],
    );
  }

  Widget _buildLegendItem(
    String label,
    Color color,
    bool isVisible,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: isVisible ? color : color.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: ThemeConfig.caption1.copyWith(
              color: isVisible
                  ? ThemeConfig.primaryTextColor
                  : ThemeConfig.tertiaryTextColor,
              fontWeight: isVisible ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _getBottomTitles(double value, TitleMeta meta) {
    final date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
    final now = DateTime.now();
    final diff = now.difference(date);

    String text;
    if (diff.inMinutes < 1) {
      text = 'now';
    } else if (diff.inMinutes < 60) {
      text = '${diff.inMinutes}m';
    } else {
      text = '${diff.inHours}h';
    }

    return SideTitleWidget(
      meta: meta,
      child: Text(
        text,
        style: ThemeConfig.caption2.copyWith(
          color: ThemeConfig.tertiaryTextColor,
        ),
      ),
    );
  }

  Widget _getLeftTitles(double value, TitleMeta meta) {
    return SideTitleWidget(
      meta: meta,
      child: Text(
        _formatSpeedValue(value),
        style: ThemeConfig.caption2.copyWith(
          color: ThemeConfig.tertiaryTextColor,
        ),
      ),
    );
  }

  String _formatSpeedValue(double value) {
    if (value < 1024) return '${value.toInt()}B/s';
    if (value < 1024 * 1024) return '${(value / 1024).toStringAsFixed(0)}K';
    return '${(value / (1024 * 1024)).toStringAsFixed(1)}M';
  }

  List<LineTooltipItem?> _getTooltipItems(List<LineBarSpot> touchedSpots) {
    return touchedSpots.map((barSpot) {
      final color = barSpot.barIndex == 0
          ? ThemeConfig.connectedColor
          : ThemeConfig.secondaryColor;
      final label = barSpot.barIndex == 0 ? 'Download' : 'Upload';

      return LineTooltipItem(
        '$label\n${Formatters.formatSpeed(barSpot.y)}',
        ThemeConfig.caption1.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      );
    }).toList();
  }

  double _getMinX() {
    final now = DateTime.now();
    return now.subtract(widget.timeWindow).millisecondsSinceEpoch.toDouble();
  }

  double _getMaxX() {
    return DateTime.now().millisecondsSinceEpoch.toDouble();
  }

  double _getMaxY() {
    double maxSpeed = 0;

    if (widget.downloadData.isNotEmpty) {
      final maxDownload = widget.downloadData
          .map((data) => data.speed)
          .reduce((a, b) => a > b ? a : b);
      if (maxDownload > maxSpeed) maxSpeed = maxDownload;
    }

    if (widget.uploadData.isNotEmpty) {
      final maxUpload = widget.uploadData
          .map((data) => data.speed)
          .reduce((a, b) => a > b ? a : b);
      if (maxUpload > maxSpeed) maxSpeed = maxUpload;
    }

    return maxSpeed > 0 ? maxSpeed * 1.2 : 1024; // Add 20% padding
  }

  double _getHorizontalInterval() {
    final maxY = _getMaxY();
    return maxY / 5; // Show 5 horizontal lines
  }

  double _getVerticalInterval() {
    return widget.timeWindow.inMilliseconds / 5; // Show 5 vertical lines
  }
}

class SpeedDataPoint {
  final DateTime timestamp;
  final double speed; // bytes per second

  const SpeedDataPoint({required this.timestamp, required this.speed});

  SpeedDataPoint copyWith({DateTime? timestamp, double? speed}) {
    return SpeedDataPoint(
      timestamp: timestamp ?? this.timestamp,
      speed: speed ?? this.speed,
    );
  }

  @override
  String toString() => 'SpeedDataPoint(timestamp: $timestamp, speed: $speed)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpeedDataPoint &&
          runtimeType == other.runtimeType &&
          timestamp == other.timestamp &&
          speed == other.speed;

  @override
  int get hashCode => timestamp.hashCode ^ speed.hashCode;
}
