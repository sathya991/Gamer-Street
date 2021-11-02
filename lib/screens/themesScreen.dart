import 'package:flutter/material.dart';
import 'package:gamer_street/providers/theme_provider.dart';
import 'package:gamer_street/services/storage.dart';
import 'package:provider/provider.dart';

class ThemeScreen extends StatefulWidget {
  const ThemeScreen({Key? key}) : super(key: key);
  static const themeScreenRoute = '/theme-screen';
  @override
  State<ThemeScreen> createState() => _ThemeScreenState();
}

class _ThemeScreenState extends State<ThemeScreen> {
  List<String> themeNow = ['light', 'dark'];
  String _curTheme = 'light';
  SecureStorage secureStorage = SecureStorage();
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return FutureBuilder<dynamic>(
        future: secureStorage.readSecureData('theme'),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            _curTheme = snapshot.data;
          }
          return Scaffold(
            appBar: AppBar(
              title: Text("Themes"),
            ),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListTile(
                    title: Text("Light"),
                    leading: Radio(
                        value: themeNow[0],
                        groupValue: _curTheme,
                        onChanged: (val) {
                          _curTheme = themeNow[0];
                          themeProvider.toggleTheme("light");
                        }),
                  ),
                  ListTile(
                    title: Text("Dark"),
                    leading: Radio(
                        value: themeNow[1],
                        groupValue: _curTheme,
                        onChanged: (val) {
                          _curTheme = themeNow[1];
                          themeProvider.toggleTheme("dark");
                        }),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
