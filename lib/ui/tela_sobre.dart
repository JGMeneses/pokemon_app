import 'package:flutter/material.dart';
import 'package:poke_app/database/database.dart';
import 'package:poke_app/widgets/infoCard-widget.dart';

class TelaSobre extends StatelessWidget {
  const TelaSobre({super.key, required this.db});
  final AppDatabase db;

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 0, 0),
        title: const Text("Sobre o App", selectionColor: Color.fromARGB(255, 0, 0, 0),),
      ),
      body: const HomeBody(),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

 @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Equipe',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InfoCard(
                name: 'João Victor Gomes\n(Jotta)',
                photoPath: 'assets/icon/jotta-icon.png',
              ),
              SizedBox(width: 16), // Espaço entre os cards
              InfoCard(
                name: 'Giovanna Oliveira\n(Gigi)',
                photoPath: 'assets/icon/gigi-icon.png',
              ),
            ],
          ),
          SizedBox(height: 64),
          Text(
            'Treinador',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InfoCard(
                name: 'Taniro Chacon\n(Mano Taniro)',
                photoPath: 'assets/icon/taniro-icon.png',
              ),
            ],
          ),
          SizedBox(height: 64),
          Text(
            "Projeto 3a unidade de PDM.\nAté o próximo semestre, Taniro! \n<3",
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

