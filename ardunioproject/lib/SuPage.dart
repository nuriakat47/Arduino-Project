import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'locale_keys.g.dart';

class SuPage extends StatefulWidget {
  final String baslik;

  const SuPage({required this.baslik});

  @override
  _SuPageState createState() => _SuPageState();
}

class _SuPageState extends State<SuPage> {
  int _suMiktari = 0;
  int _toprakNemOrani = 50; // Başlangıçta toprak nem oranı %50 olarak ayarlandı
  int _verilenSuMiktari = 0;
  int _verilmeSikligi = 1; // Başlangıçta her saat başı su verme sıklığı

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.baslik.tr()),
        backgroundColor: Colors.teal[400],
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.teal.withOpacity(0.8),
              Colors.teal.withOpacity(0.5),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildRoundedCard(
                  LocaleKeys.soil_moisture.tr() + ' $_toprakNemOrani%'),
              SizedBox(height: 20),
              _buildRoundedCard(
                  LocaleKeys.given_water_amount.tr() + ' $_suMiktari 💧'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _verilenSuMiktari += _verilmeSikligi;
                  _suMiktari += _verilmeSikligi;
                  setState(() {
                    _toprakNemOrani = ((_suMiktari / 10) * 100).toInt();
                    if (_toprakNemOrani > 100) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(LocaleKeys.warning_title.tr()),
                            content:
                            Text(LocaleKeys.over_watering_message.tr()),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(LocaleKeys.ok_button.tr()),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(LocaleKeys.water_button.tr()),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildRoundedCard(LocaleKeys.watering_frequency.tr()),
                  SizedBox(width: 10),
                  DropdownButton<int>(
                    value: _verilmeSikligi,
                    items: [
                      DropdownMenuItem<int>(
                        value: 1,
                        child: Text(LocaleKeys.hourly.tr()),
                      ),
                      DropdownMenuItem<int>(
                        value: 6,
                        child: Text(LocaleKeys.every_6_hours.tr()),
                      ),
                      DropdownMenuItem<int>(
                        value: 24,
                        child: Text(LocaleKeys.daily.tr()),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _verilmeSikligi = value!;
                      });
                    },
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    dropdownColor: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedCard(String text) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 2,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
      ),
    );
  }
}
