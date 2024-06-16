import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(StraySaverApp());
}


//GetStarted Page
class StraySaverApp extends StatefulWidget {
  @override
  _StraySaverAppState createState() => _StraySaverAppState();
}

class _StraySaverAppState extends State<StraySaverApp> {
  ValueNotifier<ThemeMode> _themeNotifier = ValueNotifier(ThemeMode.light);
  ValueNotifier<Orientation> _orientationNotifier = ValueNotifier(Orientation.portrait);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return ValueListenableBuilder<Orientation>(
          valueListenable: _orientationNotifier,
          builder: (_, Orientation currentOrientation, __) {
            return MaterialApp(
              title: 'StraySaver',
              theme: ThemeData(
                primarySwatch: Colors.purple,
                brightness: Brightness.light,
              ),
              darkTheme: ThemeData(
                brightness: Brightness.dark,
                primarySwatch: Colors.purple,
              ),
              themeMode: currentMode,
              home: GetStartedPage(
                themeNotifier: _themeNotifier,
                orientationNotifier: _orientationNotifier,
              ),
              initialRoute: '/',
              routes: {
                '/signup': (context) => SignUpPage(),
                '/report': (context) => ReportAStrayScreen(),
                '/dog_profile': (context) => DogListScreen(),
                '/adoption': (context) => AdoptionScreen(),
                '/volunteer': (context) => VolunteerScreen(),
                // Add more routes as needed
              },
            );
          },
        );
      },
    );
  }
}

class GetStartedPage extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeNotifier;
  final ValueNotifier<Orientation> orientationNotifier;

  GetStartedPage({required this.themeNotifier, required this.orientationNotifier});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 60), // Add some height to push images down
                  // Illustrations
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'images/image1.jpg',
                        height: 150,
                      ),
                      Image.asset(
                        'images/image2.jpg',
                        height: 150,
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  // Welcome Text
                  Text(
                    'Welcome to\nStray-Saver',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Subtitle Text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'SAVING ONE DOG WILL NOT CHANGE THE WORLD,\nBUT SURELY FOR THAT ONE DOG,\nTHE WORLD WILL CHANGE FOREVER.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.purple.shade700,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  // Get Started Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/signup');
                      },
                      child: Text('Get started'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.purple[300],
                        padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 100.0),
                        textStyle: TextStyle(fontSize: 18.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        shadowColor: Colors.purple,
                        elevation: 10,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        themeNotifier.value = themeNotifier.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
                      },
                      backgroundColor: Colors.purple,
                      child: Icon(themeNotifier.value == ThemeMode.light ? Icons.dark_mode : Icons.light_mode),
                    ),
                    SizedBox(width: 10),
                    FloatingActionButton(
                      onPressed: () {
                        orientationNotifier.value = orientationNotifier.value == Orientation.portrait
                            ? Orientation.landscape
                            : Orientation.portrait;
                        SystemChrome.setPreferredOrientations(
                          orientationNotifier.value == Orientation.portrait
                              ? [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
                              : [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
                        );
                      },
                      backgroundColor: Colors.purple,
                      child: Icon(orientationNotifier.value == Orientation.portrait ? Icons.screen_rotation : Icons.screen_lock_rotation),
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





class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sign Up Page',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
      ),
      themeMode: ThemeMode.system,
      home: SignUpPage(),
      routes: {
        '/home': (context) => HomePage(),
      },
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  String? _name;
  String? _email;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _signUp() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signing Up...')),
      );
      // Navigate to home page after signing up
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text(''),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Create Your Account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24.0),
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[800] : Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: isDarkMode ? Colors.black54 : Colors.black26,
                        blurRadius: 10.0,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          filled: true,
                          fillColor: isDarkMode ? Colors.grey[700] : Colors.black12,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _name = value;
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          filled: true,
                          fillColor: isDarkMode ? Colors.grey[700] : Colors.black12,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _email = value;
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          filled: true,
                          fillColor: isDarkMode ? Colors.grey[700] : Colors.black12,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        obscureText: !_isPasswordVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          filled: true,
                          fillColor: isDarkMode ? Colors.grey[700] : Colors.black12,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        obscureText: !_isPasswordVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 24.0),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _signUp,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.purple,
                            padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  'Or Continue With',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        // Action for signing up with Google
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      icon: Icon(Icons.g_mobiledata_rounded),
                      label: Text('Google'),
                    ),
                    SizedBox(width: 16.0),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Action for signing up with Facebook
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      icon: Icon(Icons.facebook),
                      label: Text('Facebook'),
                    ),
                    SizedBox(width: 16.0),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Action for signing up with Apple
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      icon: Icon(Icons.person),
                      label: Text('Apple'),
                    ),
                  ],
                ),
                SizedBox(height: 24.0),
                const Text(
                  'Already have an account?',
                  style: TextStyle(fontSize: 16.0),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.purpleAccent[100], // Set the background color to purple
    );
  }
}







class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.grey[900] : Colors.purpleAccent[100];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login Here',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      'Welcome Back to StraySaver',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white70 : Colors.black54,
                      ),
                    ),
                    SizedBox(height: 24.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email or Phone number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        filled: true,
                        fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        filled: true,
                        fillColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: isDarkMode ? Colors.white70 : Colors.grey[600],
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      obscureText: !_isPasswordVisible,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value;
                      },
                    ),
                    SizedBox(height: 8.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Implement forgot password functionality
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(fontSize: 14.0, color: Colors.purple),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _formKey.currentState?.save();
                            // Perform the login action with the saved values
                            //  _email, _password
                            // For demo purposes, navigate to HomePage:
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.purple,
                          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Or login with',
                      style: TextStyle(fontSize: 16.0, color: Colors.black54),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton.icon(
                          onPressed: () {
                            // Handle Google login
                          },
                          icon: Icon(Icons.g_mobiledata_rounded, color: Colors.red),
                          label: Text('Google', style: TextStyle(color: Colors.red)),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.red),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        OutlinedButton.icon(
                          onPressed: () {
                            // Handle Facebook login
                          },
                          icon: Icon(Icons.facebook, color: Colors.blue),
                          label: Text('Facebook', style: TextStyle(color: Colors.blue)),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.blue),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        OutlinedButton.icon(
                          onPressed: () {
                            // Handle Apple login
                          },
                          icon: Icon(Icons.apple, color: Colors.black),
                          label: Text('Apple', style: TextStyle(color: Colors.black)),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.black),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/report':
            return MaterialPageRoute(builder: (context) => ReportAStrayScreen());
          case '/dog_profile':
            return MaterialPageRoute(builder: (context) => DogListScreen());
          case '/adoption':
            return MaterialPageRoute(builder: (context) => AdoptionScreen());
          case '/volunteer':
            return MaterialPageRoute(builder: (context) => VolunteerScreen());
          default:
            return null;
        }
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (context) => NotFoundScreen());
      },
      home: HomePage(),
    );
  }
}




class HomePage extends StatelessWidget {
  Widget buildFeatureButton(BuildContext context, IconData iconData, String label, String routeName, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData, size: 32, color: color),
          Text(label, style: TextStyle(color: color)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return DefaultTabController(
          length: 5, // Number of tabs
          child: Scaffold(
            appBar: AppBar(
              title: Text('Stray Saver'),
              backgroundColor: Colors.purpleAccent[100],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                   child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0), // Increase the border radius as needed
                        ),
                       child: TabBar(
                    isScrollable: true, // Enable scrolling if needed
                    labelPadding: EdgeInsets.symmetric(horizontal: 16.0),
                         labelColor: Theme.of(context).textTheme.bodyText1!.color, // Font color for selected tab
                         unselectedLabelColor: Theme.of(context).textTheme.bodyText2!.color, // Font color for unselected tabs
                         tabs: [
                      Tab(text: 'Home'),
                      Tab(text: 'Report'),
                      Tab(text: 'Profile'),
                      Tab(text: 'Adoption'),
                      Tab(text: 'Volunteer'),
                    ],
                  ),
                ),
              ),
              ),
            ),
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('Home'),
                    onTap: () {
                      Navigator.pop(context);  // Navigate to Home page
                    },
                  ),
                  ListTile(
                    title: Text('Settings'),
                    onTap: () {
                      Navigator.pop(context); // Navigate to Settings page
                    },
                  ),
                  ListTile(
                    title: Text('About Us'),
                    onTap: () {
                      // Navigate to About Us page
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Text('About StraySaver'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'StraySaver is dedicated to rescuing and protecting stray animals. Our mission is to provide a safe environment for stray animals and facilitate their adoption into loving homes.',
                              ),
                              SizedBox(height: 16.0),
                              Text(
                                'How It Works:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                '1. Report a Stray: Use the app to report sightings of stray animals in your area.',
                              ),
                              Text(
                                '2. Dog Profile: View profiles of stray dogs available for adoption.',
                              ),
                              Text(
                                '3. Adoption: Learn about the adoption process and find your new furry friend.',
                              ),
                              Text(
                                '4. Volunteer: Get involved by volunteering your time or resources to help stray animals.',
                              ),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Close the dialog
                              },
                              child: Text('Close'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            'Welcome to Stray Saver!',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey, // Use primary color for title
                              shadows: [
                                Shadow(
                                  blurRadius: 2,
                                  color: Colors.grey.withOpacity(0.5), // Shadow color and opacity
                                  offset: Offset(1, 1), // Shadow position
                                ),
                              ],
                              decorationColor: Theme.of(context).primaryColor, // Use primary color for underline
                              decorationThickness: 2, // Underline thickness
                              fontFamily: 'Roboto', // Custom font family
                            ),
                          ),
                        ),
                      ),
                      // Insert the "Report a Stray" section here
                      Text(
                        'Report a Stray',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        'Help us save stray animals by reporting sightings in your area. Our team will respond to your request and rescue the animal as soon as possible.',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.blueGrey,
                        ),
                      ),
                      SizedBox(height: 24.0),
                      // Original "Adopt Pets And Save Their Lives" section follows
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: orientation == Orientation.portrait
                            ? Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.asset(
                                'images/image3.jpeg',
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Adopt Pets And Save Their Lives',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                  'Why bother shopping for pets when there are thousands of homeless puppies looking for a family? '
                                      'Adopt rescued animals from our shelters and make a change in the lives of animals in your area.',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.blueGrey,
                                  ),
                                ),
                                SizedBox(height: 24.0),
                                ElevatedButton(
                                  onPressed: () {
                                    // Handle contact us button press
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context).primaryColor, // Use primary color for button
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Contact Us',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                          backgroundColor: Theme.of(context).primaryColor, // Use primary color for text background
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 8.0),
                                      Icon(Icons.arrow_forward),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                            : Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.asset(
                                  'images/image3.jpeg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Adopt Pets And Save Their Lives',
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 16.0),
                                  Text(
                                    'Why bother shopping for pets when there are thousands of homeless puppies looking for a family? '
                                        'Adopt rescued animals from our shelters and make a change in the lives of animals in your area.',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.blueGrey,
                                    ),
                                  ),
                                  SizedBox(height: 24.0),
                                  ElevatedButton(
                                    onPressed: () {
                                      // Handle contact us button press
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Theme.of(context).primaryColor, // Use primary color for button
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30.0),
                                      ),
                                      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Contact Us',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                            backgroundColor: Theme.of(context).primaryColor, // Use primary color for text background
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(width: 8.0),
                                        Icon(Icons.arrow_forward),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // New "Volunteer Your Time" section follows
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Volunteer Your Time',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'Join our team of volunteers and help us rescue stray animals. You can make a difference by donating your time, resources, or skills to our cause.',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.blueGrey,
                              ),
                            ),
                            SizedBox(height: 24.0),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor, // Use primary color for button
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Volunteer Now',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      backgroundColor: Theme.of(context).primaryColor, // Use primary color for text background
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Icon(Icons.arrow_forward),
                                ],
                              ),
                            ),
                            SizedBox(height: 24.0),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    constraints: BoxConstraints(
                                      maxHeight: 200.0, // Set a maximum height for the image
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Image.asset(
                                        'images/image17.webp',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Achievements(),
                      ImageGrid(),
                    ],
                  ),
                ),
                ReportAStrayScreen(),
                DogListScreen(),
                AdoptionScreen(),
                VolunteerScreen(),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.group),
                  label: 'Community',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              currentIndex: 0,
              onTap: (index) {
                // Handle navigation to different tabs
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // Handle floating action button press
              },
              child: Icon(Icons.add),
            ),
          ),
        );
      },
    );
  }
}

class Achievements extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Our Achievements',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700], // Use default color for achievements
            ),
          ),
          SizedBox(height: 16),
          Text(
            'In less than one year, our team at StraySaver has rescued and found homes for more than 300 stray cats and dogs. We believe in making our world a better place for helpless animals.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.blueGrey,
            ),
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AchievementCard(
                icon: Icons.emoji_events,
                value: '1,245',
                label: 'Memberships',
                color: Colors.orange,
              ),
              AchievementCard(
                icon: Icons.pets,
                value: '357',
                label: 'Happy Pets',
                color: Colors.blue,
              ),
              AchievementCard(
                icon: Icons.favorite,
                value: '930',
                label: 'Customers',
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AchievementCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  AchievementCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> imageUrls = [
      'images/image18.jpg',
      'images/image19.jpg',
      'images/image20.jpeg',
      'images/image21.jpg',
      'images/image22.webp',
      'images/image23.jpeg',
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gallery',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
            children: List.generate(imageUrls.length, (index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  imageUrls[index],
                  fit: BoxFit.cover,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}










class ReportAStrayScreen extends StatefulWidget {
  @override
  _ReportAStrayScreenState createState() => _ReportAStrayScreenState();
}

class _ReportAStrayScreenState extends State<ReportAStrayScreen> {
  String behaviorSelected = '';
  final _formKey = GlobalKey<FormState>();

  void selectBehavior(String behavior) {
    setState(() {
      behaviorSelected = behavior;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Report a Stray Dog'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isPortrait = constraints.maxWidth < constraints.maxHeight;
          double padding = isPortrait ? 16.0 : 32.0;
          double imageHeight = isPortrait ? 200 : constraints.maxHeight * 0.4;

          return SingleChildScrollView(
            padding: EdgeInsets.all(padding),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Hero(
                      tag: 'hero-report',
                      child: Column(
                        children: [
                          Text(
                            'Report a Stray Dog',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Fill out the form below to report a stray dog in need of help.',
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Image.asset(
                    'images/image4.jpg',
                    height: imageHeight,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 24.0),
                  Card(
                    elevation: 4.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tips for Reporting:',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            '1. Provide as much detail as possible about the stray dog\'s appearance and behavior.',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            '2. Include the exact location where the stray dog was sighted.',
                            style: TextStyle(fontSize: 16.0),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            '3. If safe, take a photo of the stray dog to include with your report.',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Report Form',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Please provide detailed information about the stray dog.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Dog\'s Description',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the dog\'s description.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Location',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the location.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Implement photo upload functionality
                    },
                    child: Text('Upload picture of the stray dog'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Behavior',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          selectBehavior('Aggressive');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: behaviorSelected == 'Aggressive' ? Colors.red : null,
                        ),
                        child: Text('Aggressive'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          selectBehavior('Friendly');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: behaviorSelected == 'Friendly' ? Colors.green : null,
                        ),
                        child: Text('Friendly'),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (behaviorSelected.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please select the dog\'s behavior.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Form submitted successfully.'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                    },
                    child: Text('Submit Report'),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Nearest Shelters and Foster Homes',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  isPortrait
                      ? Column(
                    children: [
                      _buildShelterItem(
                        icon: Icons.pets,
                        name: 'Animal Shelter 1',
                        status: 'Rescue in progress',
                      ),
                      SizedBox(height: 16.0),
                      _buildShelterItem(
                        icon: Icons.home,
                        name: 'Foster Home 1',
                        status: 'Rescue in progress',
                      ),
                    ],
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildShelterItem(
                        icon: Icons.pets,
                        name: 'Animal Shelter 1',
                        status: 'Rescue in progress',
                      ),
                      _buildShelterItem(
                        icon: Icons.home,
                        name: 'Foster Home 1',
                        status: 'Rescue in progress',
                      ),
                    ],
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Success Stories',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  isPortrait
                      ? Column(
                    children: [
                      _buildSuccessStory(
                        image: 'images/success1.jpg',
                        description: 'This is Bella. She was rescued from the streets and now has a loving home.',
                      ),
                      SizedBox(height: 16.0),
                      _buildSuccessStory(
                        image: 'images/success2.jpeg',
                        description: 'Meet Max. After being found wandering, he was adopted by a wonderful family.',
                      ),
                    ],
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSuccessStory(
                        image: 'images/success1.jpg',
                        description: 'This is Bella. She was rescued from the streets and now has a loving home.',
                      ),
                      _buildSuccessStory(
                        image: 'images/success2.jpeg',
                        description: 'Meet Max. After being found wandering, he was adopted by a wonderful family.',
                      ),
                    ],
                  ),
                  SizedBox(height: 24.0),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildShelterItem({required IconData icon, required String name, required String status}) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.transparent,
            child: Icon(
              icon,
              size: 50,
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(name),
        Text(status),
      ],
    );
  }

  Widget _buildSuccessStory({required String image, required String description}) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: 150,
          child: Text(
            description,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}








class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      home: DogListScreen(),
    );
  }
}



class Dog {
  final String name;
  final String age;
  final String breed;
  final String imageUrl;
  final String gender;

  Dog({
    required this.name,
    required this.age,
    required this.breed,
    required this.imageUrl,
    required this.gender,
  });
}

class DogListScreen extends StatelessWidget {
  final List<Dog> dogs = [
    Dog(name: 'Coco', age: 'Young', breed: 'Border Collie', imageUrl: 'images/image9.jpeg', gender: 'female'),
    Dog(name: 'Milo', age: 'Adult', breed: 'Samoyed', imageUrl: 'images/image10.jpeg', gender: 'male'),
    Dog(name: 'Chloe', age: 'Adult', breed: 'Mix Breed', imageUrl: 'images/image11.webp', gender: 'female'),
    Dog(name: 'Charlotte', age: 'Puppy', breed: 'Pomeranian', imageUrl: 'images/image13.webp', gender: 'male'),
    Dog(name: 'Sunnie', age: 'puppy', breed: 'Jack Russell Terrier Mix', imageUrl: 'images/image12.jpg', gender: 'male'),
    Dog(name: 'Poncho', age: 'Puppy', breed: 'Pomeranian', imageUrl: 'images/image14.jpg', gender: 'male'),
    Dog(name: 'Nori', age: 'Puppy', breed: 'Pomeranian', imageUrl: 'images/image15.jpeg', gender: 'female'),
    Dog(name: 'Leo', age: 'Puppy', breed: 'Pomeranian', imageUrl: 'images/image16.jpg', gender: 'male'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Dog Profiles'),// Remove the back button
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text(
                    'Categories',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      FilterChip(label: Text('Filter'), onSelected: (value) {}),
                      SizedBox(width: 8),
                      ChoiceChip(label: Text('Dogs'), selected: true, onSelected: (value) {}),
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.7,
                ),
                itemCount: dogs.length,
                itemBuilder: (context, index) {
                  final dog = dogs[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DogProfileScreen(dog: dog),
                        ),
                      );
                    },
                    child: DogCard(dog: dog),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DogCard extends StatelessWidget {
  final Dog dog;

  DogCard({required this.dog});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(
                dog.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dog.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Icon(dog.gender == 'female' ? Icons.female : Icons.male, size: 16),
                    SizedBox(width: 4),
                    Text(dog.age),
                  ],
                ),
                Text(dog.breed),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DogProfileScreen extends StatelessWidget {
  final Dog dog;

  DogProfileScreen({required this.dog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${dog.name} Profile'),
      ),
      body: Center(
        child: Hero(
          tag: 'hero-dog_profile-${dog.name}',
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(dog.imageUrl, width: 200, height: 200),
              SizedBox(height: 16),
              Text(
                dog.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(dog.age),
              Text(dog.breed),
              Text(dog.gender),
            ],
          ),
        ),
      ),
    );
  }
}




class AdoptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Adoption '),// Remove the back button
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 8),
                  Text(
                    'Find your perfect companion and give them a forever home',
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                  Image.asset('images/image8.jpg')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Available Dogs',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Card(
                    elevation: 4.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DogProfile(
                            name: 'Buddy',
                            age: '2 years old',
                            description: 'Friendly and playful',
                            imageUrl: 'images/image5.jpeg', // Placeholder image URL
                          ),
                          DogProfile(
                            name: 'Luna',
                            age: '3 years old',
                            description: 'Loyal and affectionate',
                            imageUrl: 'images/image6.jpeg', // Placeholder image URL
                          ),
                          DogProfile(
                            name: 'Max',
                            age: '1 year old',
                            description: 'Active and energetic',
                            imageUrl: 'images/image7.jpeg', // Placeholder image URL
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  Text(
                    'Adoption Application Form',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Card(
                    elevation: 4.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: AdoptionForm(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DogProfile extends StatelessWidget {
  final String name;
  final String age;
  final String description;
  final String imageUrl;

  DogProfile({
    required this.name,
    required this.age,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: AssetImage(imageUrl), // Use NetworkImage for URL
        ),
        SizedBox(height: 8),
        Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(age),
        Text(description),
      ],
    );
  }
}

class AdoptionForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed with submission
      String name = _nameController.text;
      String contactNumber = _contactNumberController.text;
      String address = _addressController.text;
      String reason = _reasonController.text;

      // Do something with the form data (e.g., save it, send it to an API, etc.)
      print('Name: $name');
      print('Contact Number: $contactNumber');
      print('Address: $address');
      print('Reason: $reason');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: _nameController,
            label: 'Your Name',
            icon: Icons.person,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          CustomTextField(
            controller: _contactNumberController,
            label: 'Contact Number',
            icon: Icons.phone,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
          CustomTextField(
            controller: _addressController,
            label: 'Address',
            icon: Icons.home,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your address';
              }
              return null;
            },
          ),
          CustomTextField(
            controller: _reasonController,
            label: 'Why do you want to adopt?',
            icon: Icons.edit,
            maxLines: 3,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please provide your reason for adoption';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(30.0),
                onTap: () {
                  HapticFeedback.lightImpact(); // Add haptic feedback on tap
                  _submitForm(); // Call your submit function here
                },
                child: Container(
                  padding: EdgeInsets.all(10), // Adjust padding as needed
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;

  CustomTextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.maxLines = 1,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          filled: true,
          fillColor: Colors.black26,
        ),
        validator: validator,
      ),
    );
  }
}








class VolunteerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Volunteer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      home: VolunteerScreen(),
    );
  }
}

class VolunteerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Volunteer'),
        automaticallyImplyLeading: false, // This line removes the back arrow button
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Become a Volunteer',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Help save stray dogs by becoming a volunteer!',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Image.asset('images/image26.jpg'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4.0,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Volunteer Registration',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      RegistrationForm(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4.0,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Get Involved! Join Our Volunteer Team Today!',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Image.asset('images/image24.jpg'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegistrationForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, proceed with submission
      String name = _nameController.text;
      String age = _ageController.text;
      String location = _locationController.text;
      String experience = _experienceController.text;

      // Do something with the form data (e.g., save it, send it to an API, etc.)
      print('Name: $name');
      print('Age: $age');
      print('Location: $location');
      print('Experience: $experience');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            controller: _nameController,
            label: 'Name',
            icon: Icons.person,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          CustomTextField(
            controller: _ageController,
            label: 'Age',
            icon: Icons.cake,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your age';
              }
              return null;
            },
          ),
          CustomTextField(
            controller: _locationController,
            label: 'Location',
            icon: Icons.location_on,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your location';
              }
              return null;
            },
          ),
          CustomTextField(
            controller: _experienceController,
            label: 'Experience',
            icon: Icons.work,
            maxLines: 3,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please describe your experience';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(30.0),
                onTap: () {
                  _submitForm(); // Call your submit function here
                },
                child: Container(
                  padding: EdgeInsets.all(10), // Adjust padding as needed
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}










class NotFoundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
        title: Text('Not Found'),
      ),
      body: Center(
        child: Text('404 - Page Not Found'),
      ),
    );
  }
}
