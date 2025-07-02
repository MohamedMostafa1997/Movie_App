import 'package:flutter/material.dart';
import 'package:movie_app/app_routes.dart';
import 'package:movie_app/database/database.dart';
import 'package:movie_app/favorites_screen/favorites_screen.dart';
import 'package:movie_app/home_screen/home_screen.dart';
import 'package:movie_app/login_screen/launch_screen.dart';
import 'package:movie_app/login_screen/login_screen.dart';


Future  main() async {
  WidgetsFlutterBinding.ensureInitialized();
   
  final MovieDatabase movieDatabase = await $FloorMoiveDatabase.databaseBuilder('movies.db').build();
  runApp(App(database:movieDatabase));

}

class App extends StatelessWidget {
  final MovieDatabase database; 
  const App({super.key,required this.database});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    initialRoute: AppRoutes.launch,
    routes: {
      AppRoutes.launch:(context)=>Launch(database: database),
      AppRoutes.login:(context)=>LoginScreen(),
      AppRoutes.home:(context)=>HomeScreen(database:database),
      AppRoutes.favorite:(context)=>FavoritesScreen(database: database,)
    });
  }
}

