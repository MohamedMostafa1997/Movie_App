import 'dart:async';
import 'package:floor/floor.dart';
import 'package:movie_app/dao/movie_dao.dart';
import 'package:movie_app/enitiy/movie.dart';
import 'package:sqflite/sqflite.dart' as sqflite;


part 'database.g.dart';


@Database(version:1,entities:[Moive])
abstract class MoiveDatabase extends FloorDatabase{
   
   MovieDao get movieDao;
  
}
