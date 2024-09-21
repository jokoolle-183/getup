import 'package:drift/drift.dart';

class EnumListConverter<T> extends TypeConverter<List<T>, String> {
  final List<T> allValues;

  const EnumListConverter(this.allValues);

  @override
  List<T> fromSql(String fromDb) {
    final indices = fromDb.split(',');
    return indices.map((index) => allValues[int.parse(index)]).toList();
  }

  @override
  String toSql(List<T> value) {
    return value.map((e) => allValues.indexOf(e).toString()).join(',');
  }
}
