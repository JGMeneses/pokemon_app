// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:poke_app/dao/poke_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:poke_app/entity/Poke.dart';

part 'database.g.dart';// the generated code will be there

@Database(version: 1, entities: [Poke])
abstract class AppDatabase extends FloorDatabase {
  PokeDao get pokeDao;
}
