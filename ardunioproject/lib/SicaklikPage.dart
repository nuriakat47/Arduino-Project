import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';

import 'locale_keys.g.dart';

class SicaklikPage extends StatefulWidget {
  final String baslik;

  const SicaklikPage({required this.baslik});

  @override
  _SicaklikPageState createState() => _SicaklikPageState();
}

class _SicaklikPageState extends State<SicaklikPage> {
  double _ortamSicakligi = 20.0;
  double _bitkiSicakligi = 25.0;
  double _toprakSicakligi = 22.0;

  void setTemperature(double temperature) async {
    final response = await http.get('http://arduino-ip-adresi/setTemperature?temperature=$temperature' as Uri);
    if (response.statusCode == 200) {
      // Başarılı bir şekilde veri gönderildi
    } else {
      // Hata durumu
      print('Arduino ile iletişimde bir hata oluştu.');
    }
  }

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
        padding: EdgeInsets.all(20),
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                tr(LocaleKeys.ambient_temperature, args: [_ortamSicakligi.toStringAsFixed(1)]),
                style: TextStyle(fontSize: 20),
              ),
              Slider(
                value: _ortamSicakligi,
                min: 0,
                max: 50,
                onChanged: (newValue) {
                  setState(() {
                    _ortamSicakligi = newValue;
                  });
                },
              ),
              SizedBox(height: 20),
              Text(
                tr(LocaleKeys.plant_temperature, args: [_bitkiSicakligi.toStringAsFixed(1)]),
                style: TextStyle(fontSize: 20),
              ),
              Slider(
                value: _bitkiSicakligi,
                min: 0,
                max: 50,
                onChanged: (newValue) {
                  setState(() {
                    _bitkiSicakligi = newValue;
                  });
                },
              ),
              SizedBox(height: 20),
              Text(
                tr(LocaleKeys.soil_temperature, args: [_toprakSicakligi.toStringAsFixed(1)]),
                style: TextStyle(fontSize: 20),
              ),
              Slider(
                value: _toprakSicakligi,
                min: 0,
                max: 50,
                onChanged: (newValue) {
                  setState(() {
                    _toprakSicakligi = newValue;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
