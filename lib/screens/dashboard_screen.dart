import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../utils/theme.dart';
import '../widgets/stat_card.dart';
import '../widgets/activity_item.dart';
import '../widgets/quick_action_button.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Text(
              'Welcome back!',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Here\'s an overview of your reptile collection.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),

            // Stats Grid
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.2,
              children: const [
                StatCard(
                  icon: Icons.drag_indicator,
                  title: 'Total Reptiles',
                  value: '47',
                  change: '+3 this month',
                  isPositive: true,
                ),
                StatCard(
                  icon: Icons.science,
                  title: 'Active Breeding',
                  value: '8',
                  change: '2 clutches expected',
                  isPositive: null,
                ),
                StatCard(
                  icon: Icons.check_circle,
                  title: 'Today\'s Tasks',
                  value: '12',
                  change: '3 overdue',
                  isPositive: null,
                ),
                StatCard(
                  icon: Icons.attach_money,
                  title: 'Monthly Costs',
                  value: '284',
                  change: '+\$45 vs last month',
                  isPositive: false,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Recent Activity
            Text(
              'Recent Activity',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: const [
                    ActivityItem(
                      icon: Icons.restaurant,
                      iconColor: AppTheme.successColor,
                      title: 'Feeding - Ball Python #BP001',
                      description: 'Fed 1 medium rat (150g)',
                      time: '2 hours ago',
                    ),
                    Divider(),
                    ActivityItem(
                      icon: Icons.science,
                      iconColor: AppTheme.infoColor,
                      title: 'Breeding - Corn Snake Pair',
                      description: 'Eggs laid: 18 eggs',
                      time: '1 day ago',
                    ),
                    Divider(),
                    ActivityItem(
                      icon: Icons.medical_services,
                      iconColor: AppTheme.warningColor,
                      title: 'Health Check - Bearded Dragon',
                      description: 'Scheduled vet visit',
                      time: '3 days ago',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Growth Chart
            Text(
              'Growth Tracking',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Weight Progress (Last 6 Months)',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: false),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    '${value.toInt()}g',
                                    style: TextStyle(
                                      color: AppTheme.textSecondary,
                                      fontSize: 10,
                                    ),
                                  );
                                },
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                                  if (value.toInt() >= 0 && value.toInt() < months.length) {
                                    return Text(
                                      months[value.toInt()],
                                      style: TextStyle(
                                        color: AppTheme.textSecondary,
                                        fontSize: 10,
                                      ),
                                    );
                                  }
                                  return const Text('');
                                },
                              ),
                            ),
                            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          ),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: const [
                                FlSpot(0, 120),
                                FlSpot(1, 135),
                                FlSpot(2, 142),
                                FlSpot(3, 158),
                                FlSpot(4, 165),
                                FlSpot(5, 180),
                              ],
                              isCurved: true,
                              color: AppTheme.primaryColor,
                              barWidth: 3,
                              dotData: FlDotData(
                                show: true,
                                getDotPainter: (spot, percent, barData, index) {
                                  return FlDotCirclePainter(
                                    radius: 4,
                                    color: AppTheme.primaryColor,
                                    strokeWidth: 2,
                                    strokeColor: AppTheme.bgPrimary,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Quick Actions
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quick Actions',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: MediaQuery.of(context).size.width > 600 ? 4 : 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 1.3,
                      children: [
                        _buildActionButton(
                          icon: Icons.add,
                          label: 'Add Reptile',
                          onTap: () {
                            _showModal('addReptileModal');
                          },
                        ),
                        _buildActionButton(
                          icon: Icons.restaurant,
                          label: 'Log Feeding',
                          onTap: () {
                            _showModal('addFeedingModal');
                          },
                        ),
                        _buildActionButton(
                          icon: Icons.science,
                          label: 'New Breeding',
                          onTap: () {
                            _showModal('addBreedingModal');
                          },
                        ),
                        _buildActionButton(
                          icon: Icons.add_alarm,
                          label: 'Schedule Task',
                          onTap: () {
                            _showModal('addTaskModal');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return QuickActionButton(
      icon: icon,
      label: label,
      onTap: onTap,
    );
  }

  void _showModal(String modalType) {
    // TODO: Implement modal functionality
    // This matches the HTML onclick="showModal('addReptileModal')" etc.
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening $modalType modal...'),
        backgroundColor: AppTheme.primaryColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }
} 