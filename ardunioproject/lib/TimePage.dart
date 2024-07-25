import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'locale_keys.g.dart';

class TimePage extends StatefulWidget {
  final String baslik;

  const TimePage({required this.baslik});

  @override
  _TimePageState createState() => _TimePageState();
}

class _TimePageState extends State<TimePage> {
  int _toprakGelismeSure = 0;
  int _bitkiGelismeSure = 0;
  int _cicekAcmaSure = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.baslik.tr()),
        backgroundColor: Colors.green[400],
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTimePhaseCard(
                title: LocaleKeys.soil_development_duration.tr(),
                time: _toprakGelismeSure,
                onPressedIncrement: () {
                  setState(() {
                    _toprakGelismeSure++;
                  });
                },
                onPressedDecrement: () {
                  setState(() {
                    if (_toprakGelismeSure > 0) {
                      _toprakGelismeSure--;
                    }
                  });
                },
              ),
              SizedBox(height: 20),
              _buildTimePhaseCard(
                title: LocaleKeys.plant_development_duration.tr(),
                time: _bitkiGelismeSure,
                onPressedIncrement: () {
                  setState(() {
                    _bitkiGelismeSure++;
                  });
                },
                onPressedDecrement: () {
                  setState(() {
                    if (_bitkiGelismeSure > 0) {
                      _bitkiGelismeSure--;
                    }
                  });
                },
              ),
              SizedBox(height: 20),
              _buildTimePhaseCard(
                title: LocaleKeys.flowering_duration.tr(),
                time: _cicekAcmaSure,
                onPressedIncrement: () {
                  setState(() {
                    _cicekAcmaSure++;
                  });
                },
                onPressedDecrement: () {
                  setState(() {
                    if (_cicekAcmaSure > 0) {
                      _cicekAcmaSure--;
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimePhaseCard({
    required String title,
    required int time,
    required VoidCallback onPressedIncrement,
    required VoidCallback onPressedDecrement,
  }) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: onPressedDecrement,
                ),
                Text(
                  '$time ${LocaleKeys.hour.tr()}',
                  style: TextStyle(fontSize: 18),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: onPressedIncrement,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
