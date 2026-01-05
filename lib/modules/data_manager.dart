import '../imports.dart';

class DataManager {
  static final storage = GetStorage();
  static const key = 'data';

  // Основной список данных
  static final List<ChartData> _data = [];

  // ValueNotifier для реактивных обновлений
  static final dataNotifier = ValueNotifier<List<ChartData>>([]);

  // Инициализация данных
  static Future<void> init() async {
    await GetStorage.init();
    loadData();
  }

  // Синхронная загрузка данных
  static void loadData() {
    try {
      final stored = storage.read<List<dynamic>>(key);
      
      if (stored == null || stored.isEmpty) {
        // Данные по умолчанию
        _data.addAll([
          ChartData('Карта', 1700),
          ChartData('USDT', 900),
          ChartData('Акции', 400),
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
      
      // Обновляем ValueNotifier
      dataNotifier.value = List.from(_data);
      
    } catch (e) {
      debugPrint('Ошибка загрузки данных: $e');
      // Если ошибка, используем данные по умолчанию
      _data.clear();
      _data.addAll([
        ChartData('Карта', 1700),
        ChartData('USDT', 900),
        ChartData('Акции', 400),
      ]);
      dataNotifier.value = List.from(_data);
    }
  }

  // Сохранение данных
  static Future<void> _saveData() async {
    try {
      final jsonList = _data.map((e) => e.toJson()).toList();
      await storage.write(key, jsonList);
    } catch (e) {
      debugPrint('Ошибка сохранения данных: $e');
    }
  }

  // ========== Публичные методы ==========

  // Получить все данные
  static List<ChartData> get allData => List.from(_data);

  // Добавить элемент
  static Future<void> addItem(ChartData item) async {
    _data.add(item);
    dataNotifier.value = List.from(_data);
    await _saveData();
  }

  // Обновить элемент
  static Future<void> updateItem(int index, ChartData newItem) async {
    if (index >= 0 && index < _data.length) {
      _data[index] = newItem;
      dataNotifier.value = List.from(_data);
      await _saveData();
    }
  }

  // Удалить элемент
  static Future<void> deleteItem(int index) async {
    if (index >= 0 && index < _data.length) {
      _data.removeAt(index);
      dataNotifier.value = List.from(_data);
      await _saveData();
    }
  }

  // Получить элемент по индексу
  static ChartData? getItem(int index) {
    if (index >= 0 && index < _data.length) {
      return _data[index];
    }
    return null;
  }
}