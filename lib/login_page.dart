import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:social_media_buttons/social_media_button.dart';
import 'package:url_launcher/url_launcher.dart';

final Logger logger = Logger();

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

  void loginUser(BuildContext context) {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      logger.i(userNameController.text);
      logger.i(passwordController.text);
      Navigator.pushReplacementNamed(context, '/chat',
          arguments: userNameController.text);
      logger.i('Login successful');
    } else {
      logger.i("Login not successful!");
    }
  }

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Let\'s sign you in!',
              style: TextStyle(
                fontSize: 30,
                color: Colors.brown,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            const Text(
              'Welcome back, you have been missed',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.blueGrey,
              ),
            ),
            Image.asset(
              'assets/5740.png_860.png',
              height: 200,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please type your username";
                      } else if (value.length < 5) {
                        return "Your username should be more than 5 characters";
                      }
                      return null;
                    },
                    controller: userNameController,
                    decoration: const InputDecoration(
                      hintText: 'Add your Username',
                      hintStyle: TextStyle(color: Colors.blueGrey),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please type your password";
                      } else if (value.length < 8) {
                        return "Your password should be at least 8 characters long";
                      }
                      return null;
                    },
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: 'Type your Password',
                      hintStyle: TextStyle(color: Colors.blueGrey),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
              onPressed: () {
                loginUser(context);
              },
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
              ),
            ),
            GestureDetector(
              onTap: () async {
                logger.i('link clicked!');
                final Uri url = Uri.parse('https://www.youtube.com/');
                if (!await launchUrl(url)) {
                  throw 'Could not launch $url';
                }
              },
              child: const Column(
                children: [
                  Text('Find us on'),
                  Text('https://www.youtube.com'),
                ],
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SocialMediaButton.twitter(
                  color: Colors.blue,
                    url:
                        "https://x.com/kunalgu10779115?t=p_DpamTqxMY8Afh7IhDqag&s=09"),
                SocialMediaButton.linkedin(
                    url:
                        "https://www.linkedin.com/in/kunal-gupta-942113206?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
