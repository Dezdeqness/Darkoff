import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Items extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().nullable()();
  TextColumn get shortName => text().nullable()();
  TextColumn get normalizedName => text().nullable()();
  TextColumn get description => text().nullable()();
  IntColumn get basePrice => integer().withDefault(const Constant(0))();
  TextColumn get backgroundColor =>
      text().withDefault(const Constant('default'))();
  IntColumn get width => integer().nullable()();
  IntColumn get height => integer().nullable()();
  RealColumn get weight => real().nullable()();
  IntColumn get avg24hPrice => integer().nullable()();
  IntColumn get low24hPrice => integer().nullable()();
  IntColumn get high24hPrice => integer().nullable()();
  RealColumn get changeLast48h => real().nullable()();
  RealColumn get changeLast48hPercent => real().nullable()();
  IntColumn get lastLowPrice => integer().nullable()();
  IntColumn get lastOfferCount => integer().nullable()();
  TextColumn get iconLink => text().nullable()();
  TextColumn get baseImageLink => text().nullable()();
  TextColumn get image512pxLink => text().nullable()();
  TextColumn get image8xLink => text().nullable()();
  TextColumn get wikiLink => text().nullable()();
  TextColumn get bsgCategoryId => text().nullable()();
  TextColumn get updated => text().nullable()();
  TextColumn get types => text().withDefault(const Constant(''))();
  TextColumn get propertiesType => text().nullable()();
  TextColumn get propertiesJson => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('CategoryEntry')
class Categories extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get normalizedName => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class ItemCategories extends Table {
  TextColumn get itemId => text().references(Items, #id)();
  TextColumn get categoryId => text().references(Categories, #id)();

  @override
  Set<Column> get primaryKey => {itemId, categoryId};
}

class ItemHandbookCategories extends Table {
  TextColumn get itemId => text().references(Items, #id)();
  TextColumn get categoryId => text()();

  @override
  Set<Column> get primaryKey => {itemId, categoryId};
}

class ItemPrices extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get itemId => text().references(Items, #id)();
  TextColumn get priceDirection => text()();
  IntColumn get price => integer()();
  TextColumn get currency => text()();
  IntColumn get priceRUB => integer().nullable()();
  TextColumn get vendorName => text()();
  TextColumn get vendorNormalizedName => text().nullable()();
  TextColumn get vendorTypename => text().nullable()();
  TextColumn get traderId => text().nullable()();
  IntColumn get minTraderLevel => integer().nullable()();
  TextColumn get taskUnlockId => text().nullable()();
  TextColumn get taskUnlockName => text().nullable()();
  TextColumn get taskUnlockNormalizedName => text().nullable()();
  TextColumn get requirementsJson => text().nullable()();
}

class ItemContainedItems extends Table {
  TextColumn get itemId => text().references(Items, #id)();
  TextColumn get containedItemId => text()();
  IntColumn get count => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {itemId, containedItemId};
}

class Tasks extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get traderName => text()();
  TextColumn get traderNormalizedName => text()();
  TextColumn get traderImageLink => text().nullable()();
  TextColumn get mapName => text().nullable()();
  BoolColumn get kappaRequired =>
      boolean().withDefault(const Constant(false))();
  IntColumn get experience => integer().withDefault(const Constant(0))();
  IntColumn get minPlayerLevel => integer().nullable()();
  TextColumn get taskImageLink => text().nullable()();
  TextColumn get wikiLink => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class TaskObjectives extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get taskId => text().references(Tasks, #id)();
  TextColumn get description => text()();
  TextColumn get type => text()();
  BoolColumn get optional => boolean().withDefault(const Constant(false))();
}

class TaskPrerequisites extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get taskId => text().references(Tasks, #id)();
  TextColumn get prerequisiteTaskId => text()();
  TextColumn get prerequisiteTaskName => text()();
}

class TaskRewardItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get taskId => text().references(Tasks, #id)();
  TextColumn get itemId => text()();
  TextColumn get name => text()();
  TextColumn get shortName => text()();
  TextColumn get iconLink => text().nullable()();
  IntColumn get price => integer().nullable()();
  IntColumn get count => integer().withDefault(const Constant(1))();
}

class TaskRewardStandings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get taskId => text().references(Tasks, #id)();
  TextColumn get traderName => text()();
  RealColumn get standing => real()();
}

class MarketSnapshotItems extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get shortName => text()();
  IntColumn get avg24hPrice => integer().nullable()();
  IntColumn get lastLowPrice => integer().nullable()();
  RealColumn get changeLast48hPercent => real().nullable()();
  IntColumn get position => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class FleaCacheItems extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get shortName => text()();
  TextColumn get iconLink => text().nullable()();
  IntColumn get avgPrice => integer().nullable()();
  IntColumn get low24hPrice => integer().nullable()();
  IntColumn get high24hPrice => integer().nullable()();
  RealColumn get changeLast48h => real().nullable()();
  RealColumn get changeLast48hPercent => real().nullable()();
  TextColumn get categoryName => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [
  Items,
  Categories,
  ItemCategories,
  ItemHandbookCategories,
  ItemPrices,
  ItemContainedItems,
  Tasks,
  TaskObjectives,
  TaskPrerequisites,
  TaskRewardItems,
  TaskRewardStandings,
  MarketSnapshotItems,
  FleaCacheItems,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (migrator) => migrator.createAll(),
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            await migrator.createTable(marketSnapshotItems);
            await migrator.createTable(fleaCacheItems);
          }
        },
      );

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'darkoff.db'));
      return NativeDatabase.createInBackground(file);
    });
  }
}
