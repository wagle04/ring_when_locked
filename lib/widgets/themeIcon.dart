import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:ringwhenlocked/themes/themes.dart';

class ThemeIcon extends StatelessWidget {
  ThemeSwitcher theme;
  ThemeIcon(ThemeSwitcher t) {
    theme = t;
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(top: 10, right: 10),
      child: Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () {
            theme.changeTheme();
          },
          child: Container(
            height: height * 0.05,
            width: width * 0.22,
            child: FlareActor(
              "assets/flareassets/switch_daytime.flr",
              fit: BoxFit.contain,
              animation: theme.getThemeBool() ? 'day_idle' : 'night_idle',
            ),
          ),
        ),
      ),
    );
  }
}
