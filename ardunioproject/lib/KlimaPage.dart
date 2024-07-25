import 'package:flutter/material.dart';
import 'package:ardunioproject/yardimci.dart';
import 'package:easy_localization/easy_localization.dart';

import 'locale_keys.g.dart';

class KlimaPage extends StatefulWidget {
  final String baslik;

  const KlimaPage({required this.baslik});

  @override
  _KlimaPageState createState() => _KlimaPageState();
}

class _KlimaPageState extends State<KlimaPage> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.baslik,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.ac_unit),
                labelText: tr(LocaleKeys.ac_info_text),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String klimaBilgisi = _controller.text;
                // Klima bilgisini ekleyerek veritabanına da kaydet
                await KlimaVeritabaniYardimcisi().klimaEkle(klimaBilgisi);
                Navigator.pop(context, true); // Klima sayfasından çık ve geri dönüş değerini gönder
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: Text(
                tr(LocaleKeys.add_ac_text),
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
