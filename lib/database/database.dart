import 'dart:async';
import 'package:floor/floor.dart';
import 'package:movie_app/dao/movie_dao.dart';
import 'package:movie_app/entity/movie.dart';
import 'package:sqflite/sqflite.dart' as sqflite;


part 'database.g.dart';


@Database(version:1,entities:[Movie])
abstract class MovieDatabase extends FloorDatabase{
   
   MovieDao get movieDao;
  
}
