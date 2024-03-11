import 'package:flutter/material.dart';
import 'package:poke_app/database/database.dart';
import 'package:poke_app/entity/Poke.dart';
import 'package:poke_app/ui/tela_pokemonCapturado.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:pokeapi/pokeapi.dart';

class PokeCard extends StatelessWidget {
  PokeCard({super.key, required this.poke});
  Poke poke;
  //Pokemon pokemon = PokeAPI.getObject(poke.id) as Pokemon;
  
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.black, width: 0.3)
      ),
      color: Color.fromARGB(255, 230, 233, 238),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10),
        title: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Color.fromARGB(206, 58, 137, 255),
              ),
              width: double.infinity,
              height: 100,
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: _buildPokemonImage(poke),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    poke.name.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Habilidade: ${poke.ability}'
                    '\nOrdem: ${poke.order}'
                    ,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPokemonImage(Poke poke) {
    final imageUrl = poke.urlDefaultImage;

    return Image.network(
      imageUrl,
      width: 160,
      height: 160,
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        return _buildFallbackImage(poke);
      },
    );
  }

  Widget _buildFallbackImage(Poke poke) {
    final imageUrlSecundaria = poke.urlSecondImage;
    return Image.network(
      imageUrlSecundaria,
      width: 70,
      height: 70,
    );
  }
}