import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String name;
  final String photoPath;

  const InfoCard({required this.name, required this.photoPath});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(206, 58, 137, 255),
      child: Column(
        children: [
          Image.asset(
            photoPath,
            height: 150,
            width: 150,
            fit: BoxFit.cover,
          ),
          Text(name, textAlign: TextAlign.center,),
        ],
      ),
    );
  }
}