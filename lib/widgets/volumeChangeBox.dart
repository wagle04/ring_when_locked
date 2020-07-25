import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:volume/volume.dart';

class VolumeChangeBox extends StatefulWidget {
  @override
  _VolumeChangeBoxState createState() => _VolumeChangeBoxState();
}

class _VolumeChangeBoxState extends State<VolumeChangeBox> {
  int maxVolume = 100;
  int currentVolume = 0;

  setCurrentVolume() async {
    var list = await getVolume(AudioManager.STREAM_RING);
    currentVolume = list[0];
    maxVolume = list[1];
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
        value: (100 * currentVolume / maxVolume).toDouble(),
        min: 0.0,
        max: 100.0,
        start: Container(),
        end: Container(),
        thumbColor: Colors.red,
        sliderColor: Theme.of(context).iconTheme.color == Colors.white70
            ? Colors.white
            : Colors.black,
        onChanged: (x) {
          setState(() {
            currentVolume = maxVolume * x ~/ 100;
          });
        },
        onChangeEnd: (x) {
          setVolume(x.toInt(), AudioManager.STREAM_RING);
        },
      ),
    );
  }
}

setVolume(int userSetVolume, AudioManager audioManager) async {
  await Volume.controlVolume(audioManager);
  int maxVolume = await Volume.getMaxVol;
  double redefinedVolume = userSetVolume * maxVolume / 100;
  print(audioManager.toString() + " new volume: " + redefinedVolume.toString());
  await Volume.setVol(redefinedVolume.toInt(), showVolumeUI: ShowVolumeUI.HIDE);
}

Future<List<int>> getVolume(AudioManager audioManager) async {
  await Volume.controlVolume(audioManager);
  var x = await Volume.getVol;
  var y = await Volume.getMaxVol;
  return [x, y];
}
