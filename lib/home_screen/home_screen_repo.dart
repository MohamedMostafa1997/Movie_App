import 'package:http/http.dart';
import 'dart:convert';

class MovieData {
  String? movieTittle;
  String? moviePoster;
  List<Map<String, String>> moiveData = [];

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

      return data['results'];
    } on Exception catch (e) {
      throw Exception(" Network Error : $e");
    }
  }

  Future setMoiveDate() async {
    try {
            List <dynamic>  dataList = await getMovieData() ;

            for (var moive in dataList){

              moive['poster_path'] = "https://image.tmdb.org/t/p/w500/${moive['poster_path']}";
            
              moiveData.add({
                'title': moive['original_title'],
                'poster':moive['poster_path']
              }
             
              );
  
            }

    } on Exception catch (e) {
      throw Exception(" Parsing Error : $e ");
    }
  }
}
