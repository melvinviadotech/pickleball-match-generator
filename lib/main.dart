import 'package:flutter/material.dart';
import 'features/tournaments/screens/select_tournament_type.dart';
import 'features/players/screens/players_page.dart';
import 'widgets/main_drawer.dart';
import 'style/button_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
        listTileTheme: ListTileThemeData(
        tileColor: Color(int.parse('FF7d818d', radix: 16))),
          primarySwatch: Colors.indigo,
          primaryColor: Colors.indigo,
          scaffoldBackgroundColor: Color(int.parse('FF7d818d', radix: 16)),
          // Text theme
          textTheme: const TextTheme(
            bodySmall: TextStyle(fontFamily: 'CustomFont'),
            bodyMedium: TextStyle(fontFamily: 'CustomFont'),
            bodyLarge:
                TextStyle(fontFamily: 'CustomFont'), // Default text style
            // Optionally, customize other text styles
            headlineSmall: TextStyle(fontFamily: 'CustomFont', fontSize: 24),
            titleLarge: TextStyle(fontFamily: 'CustomFont', fontSize: 20),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Color(int.parse('FF4a506a', radix: 16)),
            titleTextStyle: const TextStyle(
                fontFamily: 'CustomFont', color: Colors.white70, fontSize: 20),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                  fontFamily: 'CustomFont', fontSize: 18), // Custom font
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              backgroundColor: Color(int.parse('FF4a506a',
                  radix: 16)), // Optional background color
              foregroundColor: Colors.white, // Optional text color
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(10.0), // Your desired radius
              ),
            ),
          ),
        ),
        title: 'Robin Tool',
        debugShowCheckedModeBanner: false,
        // home: const MyHomePage(title: 'Create a Tournament'),
        home: FutureBuilder<bool>(
          future: _hasSeenIntro(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return snapshot.data == true
                  ? const MyHomePage(title: 'MatchGen')
                  : IntroScreen();
            } else {
              return const CircularProgressIndicator(); // Or a simple loading indicator
            }
          },
        ));
  }

  Future<bool> _hasSeenIntro() async {
    // final prefs = await SharedPreferences.getInstance();
    // return prefs.getBool('hasSeenIntro') ?? false;
    return false;
  }
}

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Welcome!',
      'description': 'Thank you for using MatchGen',
    },
    {
      'title': 'Get to Playing',
      'description': 'Manage your sports matches with ease!',
    },
    {
      'title': 'Get Started',
      'description': 'Ready to dive in? Let\'s go!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final page = _pages[index];
              return IntroPage(
                  title: page['title']!, description: page['description']!);
            },
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                  const SizedBox(height: 20),
                  _currentPage == _pages.length - 1
                      ? ElevatedButton(
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('hasSeenIntro', true);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const MyHomePage(title: 'MatchGen')),
                            );
                          },
                          child: const Text('Get Started'),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setBool('hasSeenIntro', true);
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => const MyHomePage(
                                            title: 'MatchGen',
                                          )),
                                );
                              },
                              child: const Text('Skip'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.ease,
                                );
                              },
                              child: const Text('Next'),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _pages.length; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.indigo : Colors.grey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class IntroPage extends StatelessWidget {
  final String title;
  final String description;

  IntroPage({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 30),
          Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16, color: Color(int.parse('FF163158', radix: 16))),
          ),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(int.parse('FF153158', radix: 16)),
          title: Text(widget.title),
        ),
        drawer: MainDrawer(),
        body: const SelectTournamentType());
  }
}
