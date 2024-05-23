import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_galaxy_shooter/main.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/components/ui/custom_floating_button/custom_floating_button.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/database/mongo_db.dart';
import 'package:space_galaxy_shooter/space_galaxy_shooter/screens/menu/menu_screen.dart';

class GameResultsScreen extends ConsumerStatefulWidget {
  const GameResultsScreen({super.key});

  @override
  ConsumerState<GameResultsScreen> createState() => _GameResultsState();
}

class _GameResultsState extends ConsumerState<GameResultsScreen> {
  List<dynamic> _users = [];

  void _fetchData() async {
    var dbService = DatabaseService();
    var fetchedUsers = await dbService.fetchUsers();
//@@ START  sorting function from chat GPT 3.5 START    @@
    fetchedUsers.sort((a, b) {
      var scoreA = (a['scores'] as List<dynamic>)
          .fold(0, (prev, element) => prev > element ? prev : element);
      var scoreB = (b['scores'] as List<dynamic>)
          .fold(0, (prev, element) => prev > element ? prev : element);
      return scoreB.compareTo(scoreA);
    });
//@@  END  sorting function from chat GPT 3.5  END     @@

    if (fetchedUsers.length > 10) {
      fetchedUsers = fetchedUsers.sublist(0, 10);
    }
    setState(() {
      _users = fetchedUsers;
    });

    debugPrint(" Users: ${fetchedUsers}");
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
    final screenSize = ref.watch(mobileScreenSizeProvider);
    return Scaffold(
      body: SafeArea(
          child: Expanded(
        child: Column(
          children: [
            Container(
              width: screenSize.width,
              height: screenSize.height,
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
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 16, 3, 131)),
                          ),
                          subtitle: Text(
                            'Scores: ${user['scores']?.join(", ") ?? "No scores"}',
                            // join(", ") used to display scores without  '[]', just number or value
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
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
        ),
      )),
    );
  }
}
