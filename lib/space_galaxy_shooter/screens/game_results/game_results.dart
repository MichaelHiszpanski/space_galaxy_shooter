import 'package:flutter/material.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/database/mongo_db.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_utils/game_config/game_configuration.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/screens/login/login_screen.dart';

class GameResultsScreen extends StatefulWidget {
  const GameResultsScreen({super.key});

  @override
  State<GameResultsScreen> createState() => _GameResultsState();
}

class _GameResultsState extends State<GameResultsScreen> {
  List<dynamic> _users = [];
  @override
  void _fetchData() async {
    var dbService = DatabaseService();
    var fetchedUsers = await dbService.fetchUsers();
    setState(() {
      _users = fetchedUsers;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        // extended used to create custom Floating Action Button
        Container(
          width: Config.gameScreenSize,
          height: Config.gameScreenSize,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/splash.png"),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              const SizedBox(
                height: 500.0,
              ),
              Expanded(
                  child: ListView.builder(
                itemCount: _users.length,
                itemBuilder: (context, index) {
                  var user = _users[index];
                  return ListTile(
                    title: Text(user['name']),
                    subtitle: Text(
                        'Age: ${user['age']} - Profession: ${user['profession']}'),
                  );
                },
              ))
            ],
          ),
        )
      ],
    ));
  }

  void _navigateToLoginScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
