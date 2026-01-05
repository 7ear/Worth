import '../imports.dart';

class DoughnutChart extends StatelessWidget {
  const DoughnutChart({super.key});
  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      series: <CircularSeries>[
        DoughnutSeries<ChartData, String>(
          dataSource: DataManager.allData,
          xValueMapper: (ChartData data, _) => data.category,
          yValueMapper: (ChartData data, _) => data.value,
          radius: '95%',
          innerRadius: '60%',
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelPosition: ChartDataLabelPosition.inside,
            // textStyle: TextStyle(
            //   fontSize: 14,
            //   fontWeight: FontWeight.w400,      // Вес шрифта 400
            //   textBaseline: TextBaseline.alphabetic, // Базовая линия
            //   decoration: TextDecoration.none,  // Без оформления
            // ),
            // builder: (dynamic data, _, __, ___, ____) {
            //   final total = DataManager.loadData().fold(0.0, (sum, item) => sum + item.value);
            //   final percent = (data.value / total * 100).toStringAsFixed(1);
            //   return Text('${percent}%');
            // },
          ),
          selectionBehavior: SelectionBehavior(enable: true, selectedColor: Colors.amber),
        ),
      ],
      palette: ColorsForList.palette,
      margin: EdgeInsets.only(top: 7)
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

