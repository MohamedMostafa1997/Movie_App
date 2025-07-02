import 'package:floor/floor.dart';
import 'package:movie_app/entity/movie.dart';

@dao 
abstract class MovieDao {

@Query('SELECT * FROM Moive')
Stream<List<Movie>> getAllMovie();


@Query('SELECT * FROM Moive WHERE id = :id')
Future<Movie?>getMovieById(int id);


@Query('DELETE FROM Moive')
Future<void> delteAllMovies();

@insert 
Future<void> insertMovie(Movie moive);

@update
Future<void> updateMovie(Movie moive);

@delete
Future<void> deleteMovie(Movie moive);

}