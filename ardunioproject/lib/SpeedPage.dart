import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'locale_keys.g.dart';

class SpeedPage extends StatelessWidget {
  final String baslik;

  const SpeedPage({required this.baslik});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.page_title.tr(),
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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.green.withOpacity(0.8),
              Colors.green.withOpacity(0.5),
            ],
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FanButton(
              icon: Icons.power_settings_new,
              text: tr(LocaleKeys.fan_on_text),
              endpoint: '/fanOn',
            ),
            SizedBox(height: 20),
            FanButton(
              icon: Icons.power_off,
              text: tr(LocaleKeys.fan_off_text),
              endpoint: '/fanOff',
            ),
            SizedBox(height: 20),
            FanSpeedSlider(), // Hız ayarlama kaydırıcısı
          ],
        ),
      ),
    );
  }
}

class FanButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final String endpoint;

  const FanButton({
    required this.icon,
    required this.text,
    required this.endpoint,
  });

  void _sendRequest() async {
    final response =
        await http.get(Uri.parse('http://arduino-ip-adresi' + endpoint));
    if (response.statusCode == 200) {
      // Arduino'dan başarılı bir yanıt alındı
      print('İşlem başarılı: $text');
    } else {
      // Arduino ile iletişimde hata oluştu
      print('Arduino ile iletişimde hata oluştu.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      elevation: 5,
      child: InkWell(
        onTap: _sendRequest,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 50),
              SizedBox(height: 10),
              Text(text, style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}

class FanSpeedSlider extends StatefulWidget {
  @override
  _FanSpeedSliderState createState() => _FanSpeedSliderState();
}

class _FanSpeedSliderState extends State<FanSpeedSlider> {
  double _currentSpeed = 0.0;

  void _setFanSpeed(double speed) async {
    final response = await http
        .get(Uri.parse('http://arduino-ip-adresi/setFanSpeed?speed=$speed'));
    if (response.statusCode == 200) {
      // Arduino'dan başarılı bir yanıt alındı
      print('Fan hızı ayarlandı: $speed');
    } else {
      // Arduino ile iletişimde hata oluştu
      print('Arduino ile iletişimde hata oluştu.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          value: _currentSpeed,
          min: 0,
          max: 100,
          onChanged: (double value) {
            setState(() {
              _currentSpeed = value;
            });
            _setFanSpeed(value);
          },
        ),
        Text(tr(LocaleKeys.fan_speed_text) + ': $_currentSpeed'),
      ],
    );
  }
}
