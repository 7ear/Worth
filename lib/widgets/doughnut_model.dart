import '../imports.dart';

class DoughnutChart extends StatelessWidget {
  const DoughnutChart({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<ChartData>>(
      valueListenable: DataManager.dataNotifier,
      builder: (context, data, child) {
        
        final totalValue = data.fold<double>(0, (sum, item) => sum + item.value);
        
        return SizedBox(
          width: 220,
          height: 220,
          child: SfCircularChart(
            key: ValueKey(data.length),
            backgroundColor: Colors.transparent,
            margin: EdgeInsets.zero,
            series: <CircularSeries>[
              DoughnutSeries<ChartData, String>(
                dataSource: data,
                xValueMapper: (ChartData data, _) => data.category,
                yValueMapper: (ChartData data, _) => data.value,
                radius: '85%',
                innerRadius: '70%',
                dataLabelSettings: const DataLabelSettings(
                  isVisible: false,
                ),
                selectionBehavior: SelectionBehavior(
                  enable: true,
                  selectedColor: mainOrangeColor,
                ),
              ),
            ],
            palette: ColorsForList.palette,
            annotations: [
              CircularChartAnnotation(
                widget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Total',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromARGB(193, 255, 255, 255),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '\$${totalValue.toStringAsFixed(0)}',
                      style: GoogleFonts.inter(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ChartData {
  final String category;
  final double value;

  ChartData(this.category, this.value);

  Map<String, dynamic> toJson() => {'category': category, 'value': value};

  factory ChartData.fromJson(Map<String, dynamic> json) => ChartData(json['category'] as String, json['value'] as double);
}