import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ringwhenlocked/selectedProvider/lockedUnlockedSelector.dart';
import 'package:ringwhenlocked/selectedProvider/volumeData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:websafe_svg/websafe_svg.dart';

class Locked extends StatefulWidget {
  @override
  _LockedState createState() => _LockedState();
}

class _LockedState extends State<Locked> {
  SharedPreferences prefs;

  getPrefs() async {
    prefs = await SharedPreferences.getInstance();
    int currentVolume = prefs.getInt("volumeWhenLocked") ?? 100;
    Provider.of<VolumeData>(context, listen: false)
        .setVolumeWhenLocked(currentVolume);
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
          text: "Set volumes when device is locked",
          contentColor: Theme.of(context).iconTheme.color,
          animationReverseDuration: Duration(milliseconds: 10),
        );
        if (!lockSelected) {
          state.changeSelectedState(PhoneState.LOCKED);
        }
      },
      child: Column(
        children: [
          Container(
            width: width * 0.175,
            height: height * 0.125,
            decoration: BoxDecoration(
              border: lockSelected
                  ? Border.all(color: Theme.of(context).iconTheme.color)
                  : Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: WebsafeSvg.asset(
                "assets/svgassets/lock.svg",
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              lockSelected
                  ? Provider.of<VolumeData>(context).volumeWhenLocked.toString()
                  : " ",
              style: GoogleFonts.poppins(
                  fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
