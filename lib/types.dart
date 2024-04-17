import 'package:hive_flutter/adapters.dart';

part 'types.g.dart';

@HiveType(typeId: 0)
enum CardType {
  @HiveField(0)
  idea,

  @HiveField(1)
  qa
}

@HiveType(typeId: 1)
enum Difficulty {
  @HiveField(0)
  easy,

  @HiveField(1)
  medium,

  @HiveField(2)
  hard
}
