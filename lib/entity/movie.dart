import 'package:floor/floor.dart';


@entity
class Movie {
  @PrimaryKey(autoGenerate: true)
  final int? id ; 

  final String title;
  final String poster;


  Movie({this.id ,required this.title,required this.poster, });
  
}