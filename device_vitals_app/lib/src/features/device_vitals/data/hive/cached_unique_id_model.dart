import 'package:hive_ce/hive.dart';

part 'cached_unique_id_model.g.dart';

@HiveType(typeId: 1)
class CachedUniqueIdModel extends HiveObject {
  @HiveField(0)
  final String uniqueId;

  CachedUniqueIdModel({required this.uniqueId});
}
