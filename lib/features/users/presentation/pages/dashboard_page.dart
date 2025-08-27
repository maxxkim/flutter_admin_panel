import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:fl_chart/fl_chart.dart';

@RoutePage()
class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    
    return SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // заголовок
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Добро пожаловать 👋',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Вот что происходит сегодня',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.textTheme.bodyLarge?.color?.withOpacity(0.6),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(LucideIcons.download, size: 18),
                      label: const Text('Экспорт'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: Colors.white,
                    ),
                ),
                  ],
                ),

              ],
            ),
            
            const SizedBox(height: 16),
            
            // статистика карточки
            LayoutBuilder(
              builder: (context, constraints) {
                final cardWidth = (constraints.maxWidth - 48) / 4;
                final isMobile = constraints.maxWidth < 800;
                
                if (isMobile) {
                  return Column(
                    children: [
                      _buildStatCard(
                        context,
                        title: 'Всего пользователей',
                        value: '12,453',
                        change: '+12.5%',
                        isPositive: true,
                        icon: LucideIcons.users,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 16),
                      _buildStatCard(
                        context,
                        title: 'Активные чеки',
                        value: '324',
                        change: '+8.2%',
                        isPositive: true,
                        icon: LucideIcons.receipt,
                        color: Colors.green,
                      ),
                      const SizedBox(height: 16),
                      _buildStatCard(
                        context,
                        title: 'Начислено бонусов',
                        value: '854,230',
                        change: '-3.1%',
                        isPositive: false,
                        icon: LucideIcons.gift,
                        color: Colors.purple,
                      ),
                      const SizedBox(height: 16),
                      _buildStatCard(
                        context,
                        title: 'Операций сегодня',
                        value: '1,892',
                        change: '+24.7%',
                        isPositive: true,
                        icon: LucideIcons.arrowLeftRight,
                        color: Colors.orange,
                      ),
                    ],
                  );
                }
                
                return Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        context,
                        title: 'Всего пользователей',
                        value: '12,453',
                        change: '+12.5%',
                        isPositive: true,
                        icon: LucideIcons.users,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        context,
                        title: 'Активные чеки',
                        value: '324',
                        change: '+8.2%',
                        isPositive: true,
                        icon: LucideIcons.receipt,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        context,
                        title: 'Начислено бонусов',
                        value: '854,230',
                        change: '-3.1%',
                        isPositive: false,
                        icon: LucideIcons.gift,
                        color: Colors.purple,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildStatCard(
                        context,
                        title: 'Операций сегодня',
                        value: '1,892',
                        change: '+24.7%',
                        isPositive: true,
                        icon: LucideIcons.arrowLeftRight,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                );
              },
            ),
            
            const SizedBox(height: 32),
            
            // графики
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // график активности
                Expanded(
                  flex: 2,
                  child: _buildChartCard(
                    context,
                    title: 'Активность пользователей',
                    child: SizedBox(
                      height: 300,
                      child: _buildLineChart(theme),
                    ),
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // топ магазинов
                Expanded(
                  child: _buildChartCard(
                    context,
                    title: 'Топ магазинов',
                    child: _buildTopShops(theme),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            // последние операции
            _buildRecentOperations(context, theme),
          ],
        ),
    );
  }
  
  Widget _buildStatCard(
    BuildContext context, {
    required String title,
    required String value,
    required String change,
    required bool isPositive,
    required IconData icon,
    required Color color,
  }) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.dividerColor.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isPositive 
                    ? Colors.green.withOpacity(0.1)
                    : Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      isPositive 
                        ? LucideIcons.trendingUp
                        : LucideIcons.trendingDown,
                      size: 14,
                      color: isPositive ? Colors.green : Colors.red,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      change,
                      style: TextStyle(
                        color: isPositive ? Colors.green : Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildChartCard(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    final theme = Theme.of(context);
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.dividerColor.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              PopupMenuButton<String>(
                icon: Icon(
                  LucideIcons.moreVertical,
                  size: 18,
                  color: theme.iconTheme.color?.withOpacity(0.6),
                ),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'week',
                    child: Text('За неделю'),
                  ),
                  const PopupMenuItem(
                    value: 'month',
                    child: Text('За месяц'),
                  ),
                  const PopupMenuItem(
                    value: 'year',
                    child: Text('За год'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
  
  Widget _buildLineChart(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: theme.dividerColor.withOpacity(0.1),
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          show: true,
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const days = ['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'];
                return Text(
                  days[value.toInt() % 7],
                  style: TextStyle(
                    color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, meta) {
                return Text(
                  '${value.toInt()}k',
                  style: TextStyle(
                    color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: 6,
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 3),
              FlSpot(1, 1.5),
              FlSpot(2, 3.5),
              FlSpot(3, 4.5),
              FlSpot(4, 3.2),
              FlSpot(5, 4.8),
              FlSpot(6, 3.8),
            ],
            isCurved: true,
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary,
                theme.colorScheme.primary.withOpacity(0.5),
              ],
            ),
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary.withOpacity(0.2),
                  theme.colorScheme.primary.withOpacity(0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildTopShops(ThemeData theme) {
    final shops = [
      ('Магазин #1', '234 чека', 0.35),
      ('Магазин #2', '198 чеков', 0.28),
      ('Магазин #3', '156 чеков', 0.22),
      ('Магазин #4', '89 чеков', 0.15),
    ];
    
    return Column(
      children: shops.map((shop) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    shop.$1,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    shop.$2,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: shop.$3,
                backgroundColor: theme.dividerColor.withOpacity(0.1),
                valueColor: AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
                minHeight: 8,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
  
  Widget _buildRecentOperations(BuildContext context, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.dividerColor.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Последние операции',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text('Смотреть все'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // таблица операций
          Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(2),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1),
              4: FlexColumnWidth(1),
            },
            children: [
              // заголовок
              TableRow(
                decoration: BoxDecoration(
                  color: theme.dividerColor.withOpacity(0.05),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                ),
                children: [
                  _buildTableHeader('Пользователь'),
                  _buildTableHeader('Операция'),
                  _buildTableHeader('Сумма'),
                  _buildTableHeader('Статус'),
                  _buildTableHeader('Время'),
                ],
              ),
              
              // данные
              ...[
                ('Иванов И.И.', 'Начисление бонусов', '+1250', 'success', '2 мин'),
                ('Петров П.П.', 'Покупка', '-500', 'pending', '5 мин'),
                ('Сидоров С.С.', 'Возврат', '+300', 'success', '12 мин'),
                ('Козлов К.К.', 'Списание', '-800', 'failed', '25 мин'),
              ].map((op) => TableRow(
                children: [
                  _buildTableCell(op.$1),
                  _buildTableCell(op.$2),
                  _buildTableCell(op.$3, isAmount: true),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(op.$4).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        _getStatusText(op.$4),
                        style: TextStyle(
                          color: _getStatusColor(op.$4),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  _buildTableCell(op.$5),
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildTableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
  
  Widget _buildTableCell(String text, {bool isAmount = false}) {
    Color? color;
    if (isAmount) {
      color = text.startsWith('+') ? Colors.green : Colors.red;
    }
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          color: color,
          fontWeight: isAmount ? FontWeight.w600 : null,
        ),
      ),
    );
  }
  
  Color _getStatusColor(String status) {
    switch (status) {
      case 'success':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
  
  String _getStatusText(String status) {
    switch (status) {
      case 'success':
        return 'Успешно';
      case 'pending':
        return 'Ожидает';
      case 'failed':
        return 'Ошибка';
      default:
        return status;
    }
  }
}