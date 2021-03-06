import 'package:flutter/material.dart';
import 'package:flutter_firestore/Models/brew.dart';
import 'package:flutter_firestore/Screens/Home/brew_list.dart';
import 'package:flutter_firestore/Screens/Home/settings.dart';
import 'package:flutter_firestore/Screens/Services/authentication.dart';
import 'package:flutter_firestore/Screens/Services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final AuthServices _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                child: SettingsForm());
          });
    }

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService().brews,
      initialData: null,
      catchError: (ctx, QuerySnapshot) => null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => _showSettingsPanel(),
            )
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
