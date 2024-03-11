import 'package:floor/floor.dart';

@Entity(tableName: 'poke')
class Poke {
  @primaryKey
  final int id;
  final String name;
  final int height;
  final int weight;
  final String ability;
  final int order;
  final String urlDefaultImage;
  final String urlSecondImage;

  Poke(
    this.id, 
    this.name,  
    this.height, 
    this.weight, 
    this.ability, 
    this.order, 
    this.urlDefaultImage, 
    this.urlSecondImage
  );
}