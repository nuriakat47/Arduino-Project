import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';

import 'locale_keys.g.dart';

class LightPage extends StatefulWidget {
  final String title;

  const LightPage({required this.title});

  @override
  _LightPageState createState() => _LightPageState();
}

class _LightPageState extends State<LightPage> {
  bool _lightOn = false;
  double _brightness = 0.5;

  void _toggleLight() {
    setState(() {
      _lightOn = !_lightOn;
      _sendLightDataToArduino();
    });
  }

  void _changeBrightness(double value) {
    setState(() {
      _brightness = value;
      _sendLightDataToArduino();
    });
  }

  void _sendLightDataToArduino() async {
    final response = await http.get(Uri.parse(
        'http://arduino-ip-adresi/setLight?on=$_lightOn&brightness=$_brightness'));
    if (response.statusCode == 200) {
      // Successfully sent data
    } else {
      // Error case
      print('An error occurred while communicating with the Arduino.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          textAlign: TextAlign.center, // Başlığı ortala
          style: TextStyle(
            color: Colors.white, // Başlık rengini beyaz yap
          ),
        ),
        backgroundColor: Colors.green[400],
        centerTitle: true, // Başlığı ortala
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green.withOpacity(0.8),
              Colors.green.withOpacity(0.5),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _lightOn ? Icons.lightbulb : Icons.lightbulb_outline,
                size: 150, // Ampul simgesini büyüttüm
                color: _lightOn
                    ? Colors.yellow.withOpacity(_brightness)
                    : Colors.grey.withOpacity(0.5),
              ),
              SizedBox(height: 20),
              Slider(
                value: _brightness,
                min: 0.0,
                max: 1.0,
                onChanged: _changeBrightness,
              ),
              SizedBox(height: 10),
              Text(
                '${(_brightness * 1000).toInt()} lm', // Işık birimi lumen olarak gösteriliyor
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _toggleLight,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _lightOn ? Colors.blue : Colors.yellow,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(_lightOn
                    ? LocaleKeys.turn_off_light.tr()
                    : LocaleKeys.turn_on_light.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
