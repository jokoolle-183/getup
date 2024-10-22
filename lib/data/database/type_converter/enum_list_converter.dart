import 'package:drift/drift.dart';
import 'package:walk_it_up/data/database/type_converter/equal_list.dart';

class EnumListConverter<T> extends TypeConverter<EqualList<T>, String> {
  final EqualList<T> allValues;

  const EnumListConverter(this.allValues);

  @override
  EqualList<T> fromSql(String fromDb) {
    if (fromDb.isEmpty) {
      return EqualList(List.empty());
    }
    final indices = fromDb.split(',');
    return EqualList(
        indices.map((index) => allValues[int.parse(index)]).toList());
  }

  @override
  String toSql(EqualList<T> value) {
    return value.map((e) => allValues.indexOf(e).toString()).join(',');
  }
}
