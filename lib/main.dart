import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ringwhenlocked/selectedProvider/lockedUnlockedSelector.dart';
import 'package:ringwhenlocked/themes/themes.dart';
import 'package:ringwhenlocked/widgets/LockedBox.dart';
import 'package:ringwhenlocked/widgets/UnlockedBox.dart';
import 'package:ringwhenlocked/widgets/themeIcon.dart';
import 'package:ringwhenlocked/widgets/volumeChangeBox.dart';
import 'package:websafe_svg/websafe_svg.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeSwitcher(),
      child: ChangeNotifierProvider(
        create: (context) => StateSelector(),
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeSwitcher>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
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
                Locked(),
                Unlocked(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(width: 20),
                Column(
                  children: <Widget>[
                    VolumeChangeBox(),
                    SizedBox(height: 20),
                    WebsafeSvg.asset(
                      "assets/svgassets/ringtone.svg",
                      height: 20,
                      width: 20,
                      color: Theme.of(context).iconTheme.color,
                    ),
                  ],
                ),
//                Column(
//                  children: <Widget>[
//                    RingVolumeChangeBox(),
//                    SizedBox(height: 20),
//                    WebsafeSvg.asset(
//                      "assets/svgassets/ringtone.svg",
//                      height: 20,
//                      width: 20,
//                      color: Theme.of(context).iconTheme.color,
//                    ),
//                  ],
//                ),
                SizedBox(width: 20),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
