import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'locale_keys.g.dart';

class DenemePage extends StatelessWidget {
  final String baslik;

  const DenemePage({required this.baslik});

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
        color: Colors.green.withOpacity(0.8),
        child: Center(
          child: ElevatedButton.icon(
            onPressed: () {
              // Kamera işlevselliği buraya eklenecek
            },
            icon: Icon(
              Icons.camera_alt,
              size: 48,
              color: Colors.white,
            ),
            label: Text(
              LocaleKeys.camera_button_text.tr(), // CAMERA kelimesi burada kullanılacak
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
