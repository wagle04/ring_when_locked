import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ringwhenlocked/selectedProvider/lockedUnlockedSelector.dart';
import 'package:ringwhenlocked/selectedProvider/volumeData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:websafe_svg/websafe_svg.dart';

class Unlocked extends StatefulWidget {
  @override
  _UnlockedState createState() => _UnlockedState();
}

class _UnlockedState extends State<Unlocked> {
  SharedPreferences prefs;
  getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    int currentVolume = prefs.getInt("volumeWhenUnlocked") ?? 20;
    Provider.of<VolumeData>(context, listen: false)
        .setVolumeWhenUnlocked(currentVolume);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<StateSelector>(context);
    bool lockSelected = state.getSelectedState;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        BotToast.showText(
          text: "Set volumes when device is unlocked",
          contentColor: Theme.of(context).iconTheme.color,
          animationReverseDuration: Duration(milliseconds: 10),
        );
        if (lockSelected) {
          state.changeSelectedState(PhoneState.UNLOCKED);
        }
      },
      child: Column(
        children: [
          Container(
            width: width * 0.175,
            height: height * 0.125,
            decoration: BoxDecoration(
              border: lockSelected
                  ? Border.all(color: Colors.transparent)
                  : Border.all(color: Theme.of(context).iconTheme.color),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: WebsafeSvg.asset(
                "assets/svgassets/unlock.svg",
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              lockSelected
                  ? " "
                  : Provider.of<VolumeData>(context)
                      .volumeWhenUnlocked
                      .toString(),
              style: GoogleFonts.poppins(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
