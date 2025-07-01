import 'package:floor/floor.dart';
import 'package:movie_app/enitiy/movie.dart';

@dao 
abstract class MovieDao {

@Query('SELECT * FROM Moive')
Stream<List<Moive>> getAllMoive();


@Query('SELECT * FROM Moive WHERE id = :id')
Future<Moive?>getMovieById(int id);


@Query('DELETE FROM Moive')
Future<void> delteAllMoives();

@insert 
Future<void> insertMoive(Moive moive);

@update
Future<void> updateMoive(Moive moive);

@delete
Future<void> deleteMoive(Moive moive);

}