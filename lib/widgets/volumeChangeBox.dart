import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:volume/volume.dart';

class VolumeChangeBox extends StatefulWidget {
  final bool music;

  const VolumeChangeBox({this.music});
  @override
  _VolumeChangeBoxState createState() => _VolumeChangeBoxState();
}

class _VolumeChangeBoxState extends State<VolumeChangeBox> {
  int maxVolume = 100;
  int currentVolume = 0;

  setCurrentVolume() async {
    if (widget.music) {
      currentVolume = await getCurrentVolume(AudioManager.STREAM_MUSIC);
      print("music volume " + currentVolume.toString());
    } else {
      currentVolume = await getCurrentVolume(AudioManager.STREAM_RING);
      print("ringtone volume " + currentVolume.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    setCurrentVolume();
  }

  @override
  Widget build(BuildContext context) {
//    var width = MediaQuery.of(context).size.width;
//    var height = MediaQuery.of(context).size.height;

    return RotatedBox(
      quarterTurns: 3,
      child: FluidSlider(
        value: currentVolume.toDouble(),
        min: 0.0,
        max: maxVolume.toDouble(),
        start: Container(),
        end: Container(),
        thumbColor: Colors.red,
        sliderColor: Theme.of(context).iconTheme.color == Colors.white70
            ? Colors.white
            : Colors.black,
        onChanged: (x) {
          setState(() {
            currentVolume = x.toInt();
          });
        },
        onChangeEnd: (x) {
          if (widget.music) {
            setVolume(x.toInt(), AudioManager.STREAM_MUSIC);
          } else {
            setVolume(x.toInt(), AudioManager.STREAM_RING);
          }
        },
      ),
    );
  }
}

setVolume(int userSetVolume, AudioManager audioManager) async {
  await Volume.controlVolume(audioManager);
  int maxVolume = await Volume.getMaxVol;
  double redefinedVolume = userSetVolume * maxVolume / 100;
  print(redefinedVolume);
  Volume.setVol(redefinedVolume.toInt(), showVolumeUI: ShowVolumeUI.HIDE);
}

Future<int> getCurrentVolume(AudioManager audioManager) async {
  await Volume.controlVolume(audioManager);
  var x = await Volume.getVol;
  print(audioManager.toString() + ": " + x.toString());
  return Volume.getVol;
}
