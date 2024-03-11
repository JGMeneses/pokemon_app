import 'package:floor/floor.dart';
import 'package:poke_app/entity/Poke.dart';

@dao
abstract class PokeDao {
  @Query('SELECT * FROM Poke')
  Future<List<Poke>> findAllPoke();

  @Query('SELECT name FROM Poke')
  Stream<List<String>> findAllPokeName();

  @Query('SELECT * FROM Poke WHERE id = :id')
  Stream<Poke?> findPokeById(int id);

  @insert
  Future<void> insertPoke(Poke poke);

  @Query('DELETE FROM Poke WHERE id = :id')
  Future<void> deletePokeById(int id);
}