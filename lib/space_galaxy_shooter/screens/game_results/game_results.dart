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

  void _fetchData() async {
    var dbService = DatabaseService();
    var fetchedUsers = await dbService.fetchUsers();
    setState(() {
      _users = fetchedUsers;
    });
    print(" Users: ${fetchedUsers}");
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
    return Scaffold(
      body: SafeArea(
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
                  height: 150.0,
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: _users.length,
                  itemBuilder: (context, index) {
                    var user = _users[index];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          "User Name: ${user['login']}",
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Scores: ${user['scores']?.join(", ") ?? "No scores"}',
                        ),
                      ),
                    );
                  },
                )),
                CustomFloatingButton(
                  onPressed: () => _navigateToMenuScreen(context),
                  buttonName: "Back to Menu",
                  heroTag: "tag_game_results",
                ),
                const SizedBox(
                  height: 100.0,
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
