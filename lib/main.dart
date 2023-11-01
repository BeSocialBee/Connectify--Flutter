import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connectify',
      theme: ThemeData(
        primaryColor: Colors.lightGreenAccent,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ),
      ),
      home: LoginPage(),
    );
  }
}

class CardData {
  final String name;
  final String imageUrl;
  final String description;
  final String rarity;
  final int value;

  CardData({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.rarity,
    required this.value,
  });
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  bool isAuthenticated = false;

  void _login() {
    if (idController.text == '1' && pwController.text == '1') {
      setState(() {
        isAuthenticated = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isAuthenticated) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Welcome to Connectify',
                style: TextStyle(fontSize: 24),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  controller: idController,
                  decoration: InputDecoration(
                    labelText: 'ID',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                  controller: pwController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      );
    } else {
      return MainApp();
    }
  }
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('Connectify', style: TextStyle(fontSize: 24))),
    ProfilePage(),
    HelpPage(),
    TradeCenterPage(),
    MyCardsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Connectify'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Main Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            label: 'Help',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: 'Trade Center',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'My Cards',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text('Temporary User Name'),
          Text('Temporary User Number'),
        ],
      ),
      );
    }
}

class HelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('This is a card collecting sharing and trading app where users try to catch em all'),
    );
  }
}

class MyCardsPage extends StatelessWidget {
  final List<CardData> userCardCollection = [
    CardData(
      name: "David Beckham",
      imageUrl: "images/card1.png", // Put the actual image path
      description: "A football legend from UK",
      rarity: "Legendary",
      value: 1000,
    ),
    // Add more cards as needed
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: userCardCollection.length,
      itemBuilder: (context, index) {
        return CardWidget(userCardCollection[index]);
      },
    );
  }
}

class TradeCenterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Currently under development'),
    );
  }
}
class CardWidget extends StatelessWidget {
  final CardData cardData;

  CardWidget(this.cardData);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8), // Add margin to create spacing between cards
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Round the card corners
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0), // Round the card corners
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 450, // Adjust the image height as needed
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(cardData.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.5), // Add a semi-transparent background
              child: ListTile(
                title: Text(
                  cardData.name,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rarity: ${cardData.rarity}",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Value: ${cardData.value}",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      cardData.description,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}