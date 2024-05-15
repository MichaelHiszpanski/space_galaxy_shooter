import 'package:flutter/material.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/ui/custom_floating_button/custom_floating_button.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/database/mongo_db.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/game_utils/game_config/game_configuration.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/screens/menu/menu_screen.dart';

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

  void _navigateToMenuScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MenuScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        Container(
          width: Config.gameScreenSize,
          height: Config.gameScreenSize,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/results_screen.png"),
                  fit: BoxFit.cover)),
          child: Column(
            children: [
              const SizedBox(
                height: 500.0,
              ),
              CustomFloatingButton(
                  onPressed: () => _navigateToMenuScreen(context),
                  buttonName: "Back to Menu"),
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
}
