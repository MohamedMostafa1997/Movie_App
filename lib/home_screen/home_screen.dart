import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_app/database/database.dart';
import 'package:movie_app/enitiy/movie.dart';
import 'package:movie_app/home_screen/error_widget.dart';
import 'package:movie_app/home_screen/home_screen_repo.dart';

class HomeScreen extends StatefulWidget {
  final MoiveDatabase database;
  const HomeScreen({super.key, required this.database});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? errorMessage;

  MovieData movieData = MovieData();

  List<Map<String, String>> moivesList = [];

  List<Moive> favoritesMovies = [];

  late Future<void> loadMovies;
  late StreamSubscription<List<Moive>> favoritesSubscription;

  Future<void> fetchMoiveDate() async {
    try {
      await movieData.setMoiveDate();
      moivesList = movieData.moiveData;
      errorMessage = null;

      setState(() {});
    } catch (e) {
      errorMessage = "Failed to load Moive data. Please check your connection.";
      setState(() {});
    }
  }

  bool isFavorite(String title) {
    return favoritesMovies.any((movie) => movie.title == title);
  }

  Future<void> toggleFavorite(String title, String poster) async {
    final bool isFav = isFavorite(title);

    if (isFav) {
      final moive = favoritesMovies.firstWhere(
        (favoritesMovieTitle) => favoritesMovieTitle.title == title,
      );

      await widget.database.movieDao.deleteMoive(moive);
    } else {
      await widget.database.movieDao.insertMoive(
        Moive(title: title, poster: poster),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    loadMovies = fetchMoiveDate();

    favoritesSubscription = widget.database.movieDao.getAllMoive().listen((
      favList,
    ) {
      setState(() {
        favoritesMovies = favList;
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
                Navigator.pushNamed(context, '/favoritesscreen');
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
                  loadMovies = fetchMoiveDate();
                });
              },
            );
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: moivesList.length,
            itemBuilder: (context, index) {
              final Map<String, String> movie = moivesList[index];
              final String title = movie['title']!;
              final String poster = movie['poster']!;
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
