import 'package:flutter/material.dart';
import 'package:ardunioproject/yardimci.dart';

class KlimaBilgileriEkran extends StatefulWidget {
  @override
  _KlimaBilgileriEkranState createState() => _KlimaBilgileriEkranState();
}

class _KlimaBilgileriEkranState extends State<KlimaBilgileriEkran> {
  late Future<List<String>> _klimaBilgileriFuture;

  @override
  void initState() {
    super.initState();
    _klimaBilgileriFuture = _getKlimaBilgileri();
  }

  Future<List<String>> _getKlimaBilgileri() async {
    return await KlimaVeritabaniYardimcisi().tumKlimaBilgileriGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Klima Bilgileri'),
      ),
      body: Container(
        color: Colors.green[400], // Arka plan rengi
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder<List<String>>(
          future: _klimaBilgileriFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
            } else {
              List<String> klimaBilgileri = snapshot.data!;
              return ListView.builder(
                itemCount: klimaBilgileri.length,
                itemBuilder: (context, index) {
                  String klimaBilgisi = klimaBilgileri[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Card(
                      elevation: 4.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        title: Text(
                          klimaBilgisi,
                          style: TextStyle(fontSize: 18.0),
                        ),
                        // İlgili klima bilgisine göre yapılacak işlemleri buraya ekleyebilirsiniz
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
