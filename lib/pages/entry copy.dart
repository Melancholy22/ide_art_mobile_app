import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';

import '../amplifyconfiguration.dart';

void main() {
  runApp(const entryScreen());
}

class entryScreen extends StatefulWidget {
  const entryScreen({Key? key}) : super(key: key);

  @override
  State<entryScreen> createState() => _entryScreenState();
}

class _entryScreenState extends State<entryScreen> {
  bool _amplifyConfigured = false;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugin(auth);

      // call Amplify.configure to use the initialized categories in your app
      await Amplify.configure(amplifyconfig);
      setState(() {
        _amplifyConfigured = true;
      });
    } on Exception catch (e) {
      //safePrint('An error occurred configuring Amplify: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text(_amplifyConfigured ? 'Configured' : 'Not Configured'),
      ),
    );
  }
}