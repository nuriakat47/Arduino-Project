import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'Dil.dart';
import 'locale_keys.g.dart'; // locale_keys.g.dart dosyasını ekliyoruz
import 'veritabaniekrani.dart';
import 'yardimci.dart';
import 'DenemePage.dart';
import 'IlacPage.dart';
import 'KlimaPage.dart';
import 'NemPage.dart';
import 'SicaklikPage.dart';
import 'SpeedPage.dart';
import 'SuPage.dart';
import 'TimePage.dart';
import 'lightpage.dart';

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  late List<String> _klimaBilgileri = [];
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _klimaBilgileriniYukle();
  }

  Future<void> _klimaBilgileriniYukle() async {
    List<String> klimaBilgileri = await KlimaVeritabaniYardimcisi().tumKlimaBilgileriGetir();
    setState(() {
      _klimaBilgileri = klimaBilgileri;
    });
  }

  Future<void> _tumKlimalariSil() async {
    await KlimaVeritabaniYardimcisi().tumKlimalariSil();
    _klimaBilgileriniYukle(); // Klimaların silinmesiyle birlikte listeyi güncelleyin
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.ana_sayfa.tr(),
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green[400],
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),

      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
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
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  LocaleKeys.menu.tr(),
                  textAlign: TextAlign.center, // Yatayda ortalama
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                  ),
                ),
              ),
            ),
            for (String klimaBilgisi in _klimaBilgileri)
              ListTile(
                title: Text(klimaBilgisi),
                onTap: () async {
                  String selectedKlimaBilgisi = klimaBilgisi;
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SpeedPage(baslik: '${LocaleKeys.fan_hizi_ayarla.tr()} - $selectedKlimaBilgisi'),
                    ),
                  );
                },
              ),
            ListTile(
              leading: Icon(Icons.delete), // Veritabanını temizle ikonu
              title: Text(LocaleKeys.veritabani_temas.tr()),
              onTap: _tumKlimalariSil,
            ),
            ListTile(
              leading: Icon(Icons.storage), // Veritabanı ikonu
              title: Text(LocaleKeys.veritabani.tr()),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => KlimaBilgileriEkran()),
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration( // Yeşil arka plan için container ekledik
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.green.withOpacity(0.8), // Yeşil rengi burada belirleyebilirsiniz, opacity ile saydamlık ayarlanabilir
                  Colors.green.withOpacity(0.5),
                ],
              ),
            ),
            child: GridView.count(
              crossAxisCount: 3,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              padding: EdgeInsets.fromLTRB(20, 60, 20, 0),
              children: [
                MenuButon(
                  text: LocaleKeys.grow_box.tr(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KlimaPage(baslik: LocaleKeys.grow_box.tr()),
                      ),
                    ).then((value) {
                      if (value != null && value) {
                        _klimaBilgileriniYukle();
                      }
                    });
                  },
                ),
                MenuButon(
                  text: LocaleKeys.sicaklik.tr(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SicaklikPage(baslik: LocaleKeys.sicaklik.tr()),
                      ),
                    );
                  },
                ),
                MenuButon(
                  text: LocaleKeys.nem.tr(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NemPage(title: LocaleKeys.nem.tr()),
                      ),
                    );
                  },
                ),
                MenuButon(
                  text: LocaleKeys.fan_hizlari.tr(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SpeedPage(baslik: LocaleKeys.fan_hizlari.tr()),
                      ),
                    );
                  },
                ),
                MenuButon(
                  text: LocaleKeys.isik.tr(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LightPage(title: LocaleKeys.isik.tr())),
                    );
                  },
                ),
                MenuButon(
                  text: LocaleKeys.su.tr(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SuPage(baslik: LocaleKeys.su.tr())),
                    );
                  },
                ),
                MenuButon(
                  text: LocaleKeys.ilac.tr(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => IlacPage(baslik: LocaleKeys.ilac.tr())),
                    );
                  },
                ),
                MenuButon(
                  text: LocaleKeys.kamera.tr(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DenemePage(baslik: LocaleKeys.kamera.tr())),
                    );
                  },
                ),
                MenuButon(
                  text: LocaleKeys.zamanlar.tr(),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TimePage(baslik: LocaleKeys.zamanlar.tr())),
                    );
                  },
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 115,
            child: Container(
              height: 150,
              alignment: Alignment.center,
              child: Image.asset('assets/images/logo_white.png'), // Logoyu 2 tık yukarı al
            ),
          ),
        ],
      ),
    );
  }
}

class MenuButon extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MenuButon({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(13),
          child: Center(
            child: Text(
              text,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ),
      ),
    );
  }
}
