import 'package:flutter/material.dart';
import 'package:movie_app/database/database.dart';
import 'package:movie_app/entity/movie.dart';

class FavoritesScreen extends StatelessWidget {
  final MovieDatabase database;
  const FavoritesScreen({super.key, required this.database});

  Future<void> removeFavorite(Movie movie) async {
    await database.movieDao.deleteMovie(movie);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Favorites",
          style: TextStyle(color: Colors.amber[900]),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: StreamBuilder<List<Movie>>(
        stream: database.movieDao.getAllMovie(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final List<Movie> favoriteMovies = snapshot.data!;

          if (favoriteMovies.isEmpty) {
            return Center(child: Text(" No favorites yet"));
          }

          return ListView.builder(
            itemCount: favoriteMovies.length,
            itemBuilder: (context, index) {
              final movie = favoriteMovies[index];
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  contentPadding: EdgeInsets.all(8),
                  leading: Image.network(
                    movie.poster,
                    width: 60,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) =>
                            Icon(Icons.broken_image),
                  ),
                  title: Text(
                    movie.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    onPressed: () => removeFavorite(movie),
                    icon: Icon(Icons.favorite, color: Colors.red),
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
