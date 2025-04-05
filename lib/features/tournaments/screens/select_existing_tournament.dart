import 'package:flutter/material.dart';
import '../repositories/tournament_repository.dart';
import '../models/tournament.dart';
import 'rounds.dart';

class TournamentSelector extends StatefulWidget {
  const TournamentSelector({super.key});

  @override
  _TournamentSelectorState createState() => _TournamentSelectorState();
}

class _TournamentSelectorState extends State<TournamentSelector> {
  final TournamentRepository _tournamentRepository = TournamentRepository();
  final List<Tournament> _tournaments = [];
  List<Tournament> _filteredTournaments = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTournaments();
  }

  Future<void> _loadTournaments() async {
    final tournaments = await _tournamentRepository.getAllTournaments();
    setState(() {
      _filteredTournaments = tournaments;
    });
  }

  // filter tournaments to search
  void _filterTournaments(String query) {
    setState(() {
      _filteredTournaments = _tournaments
          .where((tournament) =>
              tournament.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Tournament'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white70,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 2), // Border when focused
                ),
                floatingLabelStyle: TextStyle(
                  color: Colors.black, // Change the label color on focus
                  fontSize: 16,
                ),
                border: OutlineInputBorder(),
              ),
              onChanged: _filterTournaments,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredTournaments.length,
              itemBuilder: (context, index) {
                final tournament = _filteredTournaments[index];
                return Padding(padding: const EdgeInsets.all(16), child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black,
                        width: 3
                      ), // Add a border
                      borderRadius: BorderRadius.circular(
                          8.0), // Optional: Add rounded corners
                    ),
                    child: ListTile(
                      title: Text(tournament.name),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            _tournamentRepository.deleteTournamentById(
                                _filteredTournaments[index].id);
                          });
                          _loadTournaments();
                        },
                      ),
                      onTap: () {
                        // Handle tournament selection
                        print(
                            'Selected Tournament: ${tournament.name}, ID: ${tournament.id}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Rounds(tournamentId: tournament.id)),
                        );
                      },
                    )));
              },
            ),
          ),
        ],
      ),
    );
  }
}
