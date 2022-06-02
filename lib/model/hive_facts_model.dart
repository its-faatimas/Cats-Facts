import 'package:hive/hive.dart';
part 'hive_facts_model.g.dart';

@HiveType(typeId: 0)
class Facts extends HiveObject {
  @HiveField(0)
  String? facts;
  @HiveField(1)
  late DateTime createdAt;

}
