import 'package:floor/floor.dart';
import 'package:movie_app/entity/movie.dart';

@dao 
abstract class MovieDao {

@Query('SELECT * FROM Movie')
Stream<List<Movie>> getAllMovie();


@Query('SELECT * FROM Movie WHERE id = :id')
Future<Movie?>getMovieById(int id);


@Query('DELETE FROM Movie')
Future<void> delteAllMovies();

@insert 
Future<void> insertMovie(Movie movie);

@update
Future<void> updateMovie(Movie movie);

@delete
Future<void> deleteMovie(Movie movie);

}