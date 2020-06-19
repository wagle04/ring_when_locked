import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ringwhenlocked/themes/themes.dart';
import 'package:ringwhenlocked/widgets/offBox.dart';
import 'package:ringwhenlocked/widgets/onBox.dart';
import 'package:ringwhenlocked/widgets/themeIcon.dart';
import 'package:ringwhenlocked/widgets/volumeChangeBox.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeSwitcher(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeSwitcher>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      title: "Ring When Locked",
      theme: theme.getTheme(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeSwitcher>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ThemeIcon(theme),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                OnBox(),
                OffBox(),
              ],
            ),
            VolumeChangeBox(),
          ],
        ),
      ),
    );
  }
}
