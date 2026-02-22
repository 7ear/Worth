import '../imports.dart';
class DoughnutChart extends StatelessWidget {
  const DoughnutChart({super.key});
  
  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      backgroundColor: Colors.transparent,
      margin: EdgeInsets.zero,
      series: <CircularSeries>[
        DoughnutSeries<ChartData, String>(
          dataSource: DataManager.allData,
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
            // unselectedColor: Colors.white.withOpacity(0.1),
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
              SizedBox(height: 4),
              Text(
                '\$${DataManager.allData.fold(0.0, (sum, item) => sum + item.value).toStringAsFixed(0)}',
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
    );
  }

  ChartData? safeFromJson(Map<String, dynamic> json) {
    return ChartData.fromJson(json);
  }
}

class ChartData {
  final String category;
  final double value;

  ChartData(this.category, this.value);

  Map<String, dynamic> toJson() => {'category': category, 'value': value};

  factory ChartData.fromJson(Map<String, dynamic> json) => ChartData(json['category'] as String, json['value'] as double);
}
