import 'package:flutter/cupertino.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../config/theme_config.dart';
import '../../utils/formatters.dart';
import '../../utils/date_utils.dart' as app_date_utils;

class UsageChart extends StatefulWidget {
  final List<UsageDataPoint> usageData;
  final Duration timeLimit;
  final ChartType chartType;
  final String title;
  final double height;
  final bool showTimeLimit;

  const UsageChart({
    super.key,
    required this.usageData,
    required this.timeLimit,
    this.chartType = ChartType.bar,
    this.title = 'Usage Statistics',
    this.height = 200,
    this.showTimeLimit = true,
  });

  @override
  State<UsageChart> createState() => _UsageChartState();
}

class _UsageChartState extends State<UsageChart> {
  ChartPeriod _selectedPeriod = ChartPeriod.week;

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
          const SizedBox(height: ThemeConfig.mediumSpacing),
          Expanded(child: _buildChart()),
          const SizedBox(height: ThemeConfig.smallSpacing),
          _buildSummary(),
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
        _buildPeriodSelector(),
      ],
    );
  }

  Widget _buildPeriodSelector() {
    return Container(
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceColor,
        borderRadius: BorderRadius.circular(ThemeConfig.smallRadius),
      ),
      child: CupertinoSlidingSegmentedControl<ChartPeriod>(
        groupValue: _selectedPeriod,
        onValueChanged: (value) {
          if (value != null) {
            setState(() => _selectedPeriod = value);
          }
        },
        children: const {
          ChartPeriod.week: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text('Week', style: TextStyle(fontSize: 12)),
          ),
          ChartPeriod.month: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text('Month', style: TextStyle(fontSize: 12)),
          ),
        },
      ),
    );
  }

  Widget _buildChart() {
    final filteredData = _getFilteredData();

    if (filteredData.isEmpty) {
      return _buildEmptyState();
    }

    return widget.chartType == ChartType.bar
        ? _buildBarChart(filteredData)
        : _buildPieChart(filteredData);
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            CupertinoIcons.chart_bar,
            size: 48,
            color: ThemeConfig.secondaryTextColor,
          ),
          const SizedBox(height: ThemeConfig.smallSpacing),
          Text(
            'No usage data available',
            style: ThemeConfig.subhead.copyWith(
              color: ThemeConfig.secondaryTextColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Start using the VPN to see statistics',
            style: ThemeConfig.caption1.copyWith(
              color: ThemeConfig.tertiaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart(List<UsageDataPoint> data) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: widget.showTimeLimit
            ? widget.timeLimit.inMinutes.toDouble() * 1.2
            : _getMaxUsage(data) * 1.2,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final dataPoint = data[group.x.toInt()];
              return BarTooltipItem(
                '${_formatDate(dataPoint.date)}\n${Formatters.formatDurationHuman(dataPoint.duration)}',
                ThemeConfig.caption1.copyWith(
                  color: ThemeConfig.primaryTextColor,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
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
              getTitlesWidget: (value, meta) =>
                  _getBottomTitles(value, meta, data),
              reservedSize: 30,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 50,
              getTitlesWidget: _getLeftTitles,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: data.asMap().entries.map((entry) {
          final index = entry.key;
          final dataPoint = entry.value;
          final isToday = app_date_utils.DateUtils.isToday(dataPoint.date);

          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: dataPoint.duration.inMinutes.toDouble(),
                color: _getBarColor(dataPoint),
                width: 20,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  topRight: Radius.circular(4),
                ),
                backDrawRodData: widget.showTimeLimit
                    ? BackgroundBarChartRodData(
                        show: true,
                        toY: widget.timeLimit.inMinutes.toDouble(),
                        color: ThemeConfig.borderColor.withOpacity(0.2),
                      )
                    : null,
              ),
            ],
            showingTooltipIndicators: isToday ? [0] : [],
          );
        }).toList(),
        extraLinesData: widget.showTimeLimit
            ? ExtraLinesData(
                horizontalLines: [
                  HorizontalLine(
                    y: widget.timeLimit.inMinutes.toDouble(),
                    color: ThemeConfig.warningColor.withOpacity(0.5),
                    strokeWidth: 2,
                    dashArray: [5, 5],
                    label: HorizontalLineLabel(
                      show: true,
                      alignment: Alignment.topRight,
                      labelResolver: (line) =>
                          'Limit: ${Formatters.formatDurationHuman(widget.timeLimit)}',
                      style: ThemeConfig.caption2.copyWith(
                        color: ThemeConfig.warningColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              )
            : null,
      ),
    );
  }

  Widget _buildPieChart(List<UsageDataPoint> data) {
    final totalUsage = data.fold<Duration>(
      Duration.zero,
      (sum, point) => sum + point.duration,
    );

    if (totalUsage.inSeconds == 0) {
      return _buildEmptyState();
    }

    return PieChart(
      PieChartData(
        sectionsSpace: 2,
        centerSpaceRadius: 60,
        sections: data.asMap().entries.map((entry) {
          final index = entry.key;
          final dataPoint = entry.value;
          final percentage =
              dataPoint.duration.inMinutes / totalUsage.inMinutes;

          return PieChartSectionData(
            color: _getPieColor(index),
            value: percentage * 100,
            title: '${(percentage * 100).toStringAsFixed(1)}%',
            radius: 50,
            titleStyle: ThemeConfig.caption1.copyWith(
              color: CupertinoColors.white,
              fontWeight: FontWeight.w600,
            ),
            badgeWidget: _buildPieBadge(dataPoint),
            badgePositionPercentageOffset: 1.2,
          );
        }).toList(),
        pieTouchData: PieTouchData(
          touchCallback:
              (FlTouchEvent event, PieTouchResponse? pieTouchResponse) {
                // Handle touch events if needed
              },
        ),
      ),
    );
  }

  Widget _buildPieBadge(UsageDataPoint dataPoint) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: ThemeConfig.surfaceColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: ThemeConfig.borderColor.withOpacity(0.2)),
      ),
      child: Text(
        _formatDate(dataPoint.date),
        style: ThemeConfig.caption2.copyWith(fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildSummary() {
    final filteredData = _getFilteredData();
    final totalUsage = filteredData.fold<Duration>(
      Duration.zero,
      (sum, point) => sum + point.duration,
    );

    final averageUsage = filteredData.isNotEmpty
        ? Duration(seconds: totalUsage.inSeconds ~/ filteredData.length)
        : Duration.zero;

    return Row(
      children: [
        Expanded(child: _buildSummaryItem('Total', totalUsage)),
        Container(
          width: 1,
          height: 30,
          color: ThemeConfig.borderColor.withOpacity(0.3),
        ),
        Expanded(child: _buildSummaryItem('Average', averageUsage)),
        Container(
          width: 1,
          height: 30,
          color: ThemeConfig.borderColor.withOpacity(0.3),
        ),
        Expanded(
          child: _buildSummaryItem(
            'Sessions',
            Duration(seconds: filteredData.length),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryItem(String label, Duration value) {
    String displayValue;
    if (label == 'Sessions') {
      displayValue = value.inSeconds.toString();
    } else {
      displayValue = Formatters.formatDurationHuman(value);
    }

    return Column(
      children: [
        Text(
          displayValue,
          style: ThemeConfig.subhead.copyWith(
            fontWeight: FontWeight.w600,
            color: ThemeConfig.primaryColor,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: ThemeConfig.caption2.copyWith(
            color: ThemeConfig.secondaryTextColor,
          ),
        ),
      ],
    );
  }

  Widget _getBottomTitles(
    double value,
    TitleMeta meta,
    List<UsageDataPoint> data,
  ) {
    if (value.toInt() >= data.length) return const SizedBox.shrink();

    final dataPoint = data[value.toInt()];
    return SideTitleWidget(
      meta: meta,
      child: Text(
        _formatShortDate(dataPoint.date),
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
        '${value.toInt()}m',
        style: ThemeConfig.caption2.copyWith(
          color: ThemeConfig.tertiaryTextColor,
        ),
      ),
    );
  }

  List<UsageDataPoint> _getFilteredData() {
    final now = DateTime.now();
    final startDate = _selectedPeriod == ChartPeriod.week
        ? now.subtract(const Duration(days: 7))
        : now.subtract(const Duration(days: 30));

    return widget.usageData
        .where((data) => data.date.isAfter(startDate))
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  Color _getBarColor(UsageDataPoint dataPoint) {
    if (widget.showTimeLimit && dataPoint.duration >= widget.timeLimit) {
      return ThemeConfig.errorColor;
    } else if (dataPoint.duration >= widget.timeLimit * 0.8) {
      return ThemeConfig.warningColor;
    } else {
      return ThemeConfig.primaryColor;
    }
  }

  Color _getPieColor(int index) {
    final colors = [
      ThemeConfig.primaryColor,
      ThemeConfig.accentColor,
      ThemeConfig.secondaryColor,
      ThemeConfig.warningColor,
      ThemeConfig.connectedColor,
      ThemeConfig.primaryDarkColor,
      ThemeConfig.primaryLightColor,
    ];
    return colors[index % colors.length];
  }

  double _getMaxUsage(List<UsageDataPoint> data) {
    if (data.isEmpty) return 60; // Default 1 hour
    return data
        .map((point) => point.duration.inMinutes.toDouble())
        .reduce((a, b) => a > b ? a : b);
  }

  String _formatDate(DateTime date) {
    if (app_date_utils.DateUtils.isToday(date)) {
      return 'Today';
    } else if (app_date_utils.DateUtils.isYesterday(date)) {
      return 'Yesterday';
    } else {
      return '${date.day}/${date.month}';
    }
  }

  String _formatShortDate(DateTime date) {
    if (_selectedPeriod == ChartPeriod.week) {
      return ['S', 'M', 'T', 'W', 'T', 'F', 'S'][date.weekday - 1];
    } else {
      return '${date.day}';
    }
  }
}

enum ChartType { bar, pie }

enum ChartPeriod { week, month }

class UsageDataPoint {
  final DateTime date;
  final Duration duration;
  final int sessions;

  const UsageDataPoint({
    required this.date,
    required this.duration,
    this.sessions = 1,
  });

  UsageDataPoint copyWith({DateTime? date, Duration? duration, int? sessions}) {
    return UsageDataPoint(
      date: date ?? this.date,
      duration: duration ?? this.duration,
      sessions: sessions ?? this.sessions,
    );
  }

  @override
  String toString() =>
      'UsageDataPoint(date: $date, duration: $duration, sessions: $sessions)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsageDataPoint &&
          runtimeType == other.runtimeType &&
          date == other.date &&
          duration == other.duration &&
          sessions == other.sessions;

  @override
  int get hashCode => date.hashCode ^ duration.hashCode ^ sessions.hashCode;
}
