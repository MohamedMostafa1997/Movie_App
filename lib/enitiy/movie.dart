import 'package:floor/floor.dart';


@entity
class Moive {
  @PrimaryKey(autoGenerate: true)
  final int? id ; 

  final String title;
  final String poster;


  Moive({this.id ,required this.title,required this.poster, });
  
}