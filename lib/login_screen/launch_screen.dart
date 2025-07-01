import 'package:flutter/material.dart';
import 'package:movie_app/database/database.dart' show MoiveDatabase;
import 'package:movie_app/home_screen/home_screen.dart';
import 'package:movie_app/login_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Launch extends StatelessWidget {

  final MoiveDatabase database;
  const Launch({super.key,required this.database});
  
  Future<bool> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLoggedIn") ?? false ;
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder <bool> (
      future: checkLoginStatus() , 
      builder: (context,snapshot){
        if(!snapshot.hasData){
             return Scaffold( body: Center( child: CircularProgressIndicator(),),); 
        }
        return snapshot.data! ? HomeScreen(database: database,) : LoginScreen(); 

      });
  }
}