import 'package:flutter/material.dart';
import 'package:movie_app/database/database.dart';
import 'package:movie_app/favorites_screen/favorites_screen.dart';
import 'package:movie_app/home_screen/home_screen.dart';
import 'package:movie_app/login_screen/login_screen.dart';


Future  main() async {
  WidgetsFlutterBinding.ensureInitialized();
   
  final moviedatabase = await $FloorMoiveDatabase.databaseBuilder('movies.db').build();
  runApp(App(database:moviedatabase));

}

class App extends StatelessWidget {
  final MoiveDatabase database; 
  const App({super.key,required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    initialRoute: '/loginscreen',
    routes: {
      '/loginscreen':(context)=>LoginScreen(),
      '/homescreen':(context)=>HomeScreen(database:database),
      '/favoritesscreen':(context)=>FavoritesScreen(database: database,)
    });
  }
}

