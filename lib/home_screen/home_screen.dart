import 'dart:async';
import 'package:flutter/material.dart';
import 'package:movie_app/app_routes.dart';
import 'package:movie_app/database/database.dart';
import 'package:movie_app/entity/movie.dart';
import 'package:movie_app/home_screen/error_widget.dart';
import 'package:movie_app/home_screen/home_screen_repo.dart';

class HomeScreen extends StatefulWidget {
  final MovieDatabase database;
  const HomeScreen({super.key, required this.database});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? errorMessage;

  HomeScreenRepo homeScreenRepo = HomeScreenRepo();

  List<Movie> moviesList = [];

  List<Movie> favoritesMovies = [];

  late Future<void> loadMovies;
  late StreamSubscription<List<Movie>> favoritesSubscription;

  Future<void> fetchMovieData() async {
    try {
      
      moviesList = await homeScreenRepo.getMovieData();

      errorMessage = null;

      setState(() {});
    } catch (e) {
      errorMessage = "Failed to load Movie data. Please check your connection.";
      setState(() {});
    }
  }

  bool isFavorite(String title) {
    return favoritesMovies.any((movie) => movie.title == title);
  }

  Future<void> toggleFavorite(String title, String poster) async {
    final bool isFav = isFavorite(title);

    if (isFav) {
      final Movie movie = favoritesMovies.firstWhere(
        (favoritesMovieTitle) => favoritesMovieTitle.title == title,
      );

      await widget.database.movieDao.deleteMovie(movie);
    } else {
      await widget.database.movieDao.insertMovie(
        Movie(title: title, poster: poster),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    loadMovies = fetchMovieData();

    favoritesSubscription = widget.database.movieDao.getAllMovie().listen((
      favList,
    ) {
      setState(() {
        favoritesMovies =  favList;
      });
    });
  }

  @override
  void dispose() {
    favoritesSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Movies", style: TextStyle(color: Colors.amber[900])),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.favorite);
              },
              icon: Icon(Icons.favorite, size: 13),
              label: Text(" My Favorites", style: TextStyle(fontSize: 14)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.red,
                elevation: 2,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: loadMovies,
        builder: (context, snapshot) {
          if (errorMessage != null) {
            return ConnectionError(
              message: errorMessage!,
              onRetry: () {
                setState(() {
                  errorMessage = null;
                  loadMovies = fetchMovieData();
                });
              },
            );
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: moviesList.length,
            itemBuilder: (context, index) {
              final Movie movie = moviesList[index];
              final String title = movie.title;
              final String poster = movie.poster;
              final bool isFav = isFavorite(title);

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  contentPadding: EdgeInsets.all(8),
                  leading: Image.network(
                    poster,
                    width: 60,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) =>
                            Icon(Icons.broken_image, size: 60),
                  ),
                  title: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    onPressed: () => toggleFavorite(title, poster),
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? Colors.red : null,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
