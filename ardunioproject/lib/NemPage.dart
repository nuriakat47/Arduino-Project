import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'locale_keys.g.dart';

class NemPage extends StatefulWidget {
  final String title;

  const NemPage({Key? key, required this.title}) : super(key: key);

  @override
  _NemPageState createState() => _NemPageState();
}

class _NemPageState extends State<NemPage> {
  String _nemDurumu = '';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _getHumidity, // Nem ölçümünü al
              child: Text('Nem Ölç'),
            ),
            SizedBox(height: 20),
            Text(
              'Nem Durumu: $_nemDurumu',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  void _getHumidity() async {
    final response =
        await http.get(Uri.parse('http://arduino-ip-adresi/getHumidity'));
    if (response.statusCode == 200) {
      setState(() {
        _nemDurumu = response.body;
      });
    } else {
      // Arduino ile iletişimde hata oluştu
      print('Arduino ile iletişimde hata oluştu.');
    }
  }
}
