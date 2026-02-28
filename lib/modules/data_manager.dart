import '../imports.dart';

class DataManager {
  static final storage = GetStorage();
  static const key = 'data';

  static final List<ChartData> _data = [];

  static final dataNotifier = ValueNotifier<List<ChartData>>([]);

  static Future<void> init() async {
    await GetStorage.init();
    loadData();
  }

  static void loadData() {
    try {
      final stored = storage.read<List<dynamic>>(key);
      
      if (stored == null || stored.isEmpty) {
        _data.addAll([
          ChartData('Карта', 1700),
          ChartData('USDT', 900),
          ChartData('Акции', 600),
        ]);
      } else {
        _data.clear();
        for (var item in stored) {
          if (item is Map<String, dynamic>) {
            _data.add(ChartData(
              item['category']?.toString() ?? '',
              (item['value'] as num).toDouble(),
            ));
          }
        }
      }
      
      dataNotifier.value = List.from(_data);
      
    } catch (e) {
      debugPrint('Ошибка загрузки данных: $e');
      _data.clear();
      _data.addAll([
        ChartData('Карта', 1700),
        ChartData('USDT', 900),
        ChartData('Акции', 600),
      ]);
      dataNotifier.value = List.from(_data);
    }
  }

  static Future<void> _saveData() async {
    try {
      final jsonList = _data.map((e) => e.toJson()).toList();
      await storage.write(key, jsonList);
    } catch (e) {
      debugPrint('Ошибка сохранения данных: $e');
    }
  }


  static List<ChartData> get allData => List.from(_data);

  static Future<void> addItem(ChartData item) async {
    _data.add(item);
    dataNotifier.value = List.from(_data);
    await _saveData();
  }

  static Future<void> updateItem(int index, ChartData newItem) async {
    if (index >= 0 && index < _data.length) {
      _data[index] = newItem;
      dataNotifier.value = List.from(_data);
      await _saveData();
    }
  }

  static Future<void> deleteItem(int index) async {
    if (index >= 0 && index < _data.length) {
      _data.removeAt(index);
      dataNotifier.value = List.from(_data);
      await _saveData();
    }
  }

  static ChartData? getItem(int index) {
    if (index >= 0 && index < _data.length) {
      return _data[index];
    }
    return null;
  }
}