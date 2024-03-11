import 'package:flutter/material.dart';
import 'package:poke_app/database/database.dart';
import 'package:poke_app/entity/Poke.dart';
import 'package:poke_app/ui/tela_pokemonCapturado.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';

class PokemonCard extends StatefulWidget {
  final AppDatabase db;
  final Pokemon pokemon;

  PokemonCard({required this.db, required this.pokemon});

  @override
  _PokemonCardState createState() => _PokemonCardState();
}

class _PokemonCardState extends State<PokemonCard> {
  String imagePath = 'assets/icon/pokebola (1).png';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.black, width: 0.3)
      ),
      color: Color.fromARGB(255, 102, 163, 255),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.pokemon.name}'.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Experiência: ${widget.pokemon.baseExperience}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Color.fromARGB(255, 230, 233, 238),
                  ),
                  width: double.infinity,
                  height: 120,
                ),
                _buildPokemonImage(widget.pokemon.id),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Principal Habilidade:',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              '${widget.pokemon.abilities!.elementAt(0).ability!.name}'.toUpperCase(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Image.asset(
                  imagePath,
                  width: 60,
                  height: 60,
                ),
                onPressed: () async {
                  widget.db.pokeDao.insertPoke(_pokemonToPoke(widget.pokemon));
                  if (!(await widget.db.pokeDao
                      .findPokeById(_pokemonToPoke(widget.pokemon).id)
                      .isEmpty)) {
                    print("cadastrou");
                    setState(() {
                      imagePath = 'assets/icon/pokebolaCinza.png';
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }




  Widget _buildPokemonImage(int? pokemonId) {
    final imageUrl =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$pokemonId.png';

    return Image.network(
      imageUrl,
      width: 100,
      height: 100,
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        return _buildFallbackImage(pokemonId);
      },
    );
  }

  Widget _buildFallbackImage(int? pokemonId) {
    final imageUrlSecundaria =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/$pokemonId.png';
    return Image.network(
      imageUrlSecundaria,
      width: 70,
      height: 70,
    );
  }

  Poke _pokemonToPoke(Pokemon pokemon) {
    final abilities = pokemon.abilities;
    final id = pokemon.id ?? 0;
    final name = pokemon.name ?? '';
    final height = pokemon.height ?? 0;
    final weight = pokemon.weight ?? 0;
    final ability = abilities != null && abilities.isNotEmpty
        ? abilities.elementAt(0).ability?.name ?? ''
        : '';
    final order = pokemon.order ?? 0;
    final sprites = pokemon.sprites;
    final urlDefaultImage = sprites?.frontDefault ?? '';
    final urlSecondImage = sprites?.backDefault ?? '';

    final pokeObj = Poke(
      id,
      name,
      height,
      weight,
      ability,
      order,
      urlDefaultImage,
      urlSecondImage,
    );

    return pokeObj;
  }
}
