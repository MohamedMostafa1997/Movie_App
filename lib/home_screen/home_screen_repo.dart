import 'package:http/http.dart';
import 'dart:convert';
import 'package:movie_app/entity/movie.dart';

class HomeScreenRepo {
  List<Movie> movies = [];

  Future getMovieData() async {
    try {
      Response response = await get(
        Uri.parse(
          "https://api.themoviedb.org/3/movie/popular?api_key=53265ddd3b650dc47ec03e250ad91b90",
        ),
      );

      if (response.statusCode != 200) {
        throw Exception("Failed to load Movie data: ${response.statusCode}");
      }

      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> results = data['results'];
      
      

      movies= setMovieData(results);
      return movies;
    } catch (e) {
      return Exception(" Network Error : $e");
    }
  }

  List<Movie> setMovieData(List<dynamic> results) {
    return results.map<Movie>((movieJson) {
 
      return Movie(
        title: movieJson['original_title'],
        poster: "https://image.tmdb.org/t/p/w500/${movieJson['poster_path']}",
      );
    }).toList();
  }
}
