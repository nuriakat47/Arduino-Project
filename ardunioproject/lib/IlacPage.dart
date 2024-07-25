import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';

import 'locale_keys.g.dart';

class IlacPage extends StatefulWidget {
  final String baslik;

  const IlacPage({required this.baslik});

  @override
  _IlacPageState createState() => _IlacPageState();
}

class _IlacPageState extends State<IlacPage> {
  List<Ilac> ilacListesi = [];

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                _ilacEkleDialogGoster();
              },
              child: Text(LocaleKeys.new_medication.tr()),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: ilacListesi.length,
                itemBuilder: (context, index) {
                  final ilac = ilacListesi[index];
                  return ListTile(
                    title: Text(ilac.ad),
                    subtitle: Text(
                        '${LocaleKeys.selected_time.tr()}: ${ilac.zaman.hour}:${ilac.zaman.minute}, ${LocaleKeys.period.tr()}: ${ilac.periyot} dakika'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _ilacEkleDialogGoster() {
    TextEditingController adController = TextEditingController();
    TimeOfDay? secilenZaman;
    int periyot = 0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(LocaleKeys.new_medication.tr()),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: adController,
                  decoration: InputDecoration(labelText: LocaleKeys.medication_name.tr()),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        _zamanSec(context).then((value) {
                          setState(() {
                            secilenZaman = value;
                          });
                        });
                      },
                      child: Text(secilenZaman != null
                          ? '${LocaleKeys.selected_time.tr()}: ${secilenZaman!.hour}:${secilenZaman!.minute}'
                          : LocaleKeys.select_time.tr()),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        _periyotDialogSec().then((value) {
                          setState(() {
                            periyot = value ?? 0;
                          });
                        });
                      },
                      child: Text(periyot != 0 ? '${LocaleKeys.period.tr()}: $periyot dakika' : LocaleKeys.select_period.tr()),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(LocaleKeys.cancel.tr()),
            ),
            ElevatedButton(
              onPressed: () {
                if (adController.text.isNotEmpty && secilenZaman != null && periyot != 0) {
                  setState(() {
                    ilacListesi.add(
                      Ilac(
                        ad: adController.text,
                        zaman: secilenZaman!,
                        periyot: periyot,
                      ),
                    );
                  });
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(LocaleKeys.please_fill_all_fields.tr()),
                    ),
                  );
                }
              },
              child: Text(LocaleKeys.add.tr()),
            ),
          ],
        );
      },
    );
  }

  Future<TimeOfDay?> _zamanSec(BuildContext context) async {
    final secilenZaman = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    return secilenZaman;
  }

  Future<int?> _periyotDialogSec() async {
    return showDialog<int>(
      context: context,
      builder: (context) {
        int secilenDeger = 0;
        return AlertDialog(
          title: Text(LocaleKeys.select_period.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              10,
                  (index) {
                int deger = (index + 1) * 10;
                return RadioListTile<int>(
                  title: Text('$deger ${LocaleKeys.minute.tr()}'),
                  value: deger,
                  groupValue: secilenDeger,
                  onChanged: (deger) {
                    secilenDeger = deger ?? 0;
                    Navigator.pop(context, secilenDeger);
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(LocaleKeys.cancel.tr()),
            ),
          ],
        );
      },
    );
  }
}

class Ilac {
  final String ad;
  final TimeOfDay zaman;
  final int periyot; // Dakika cinsinden

  Ilac({
    required this.ad,
    required this.zaman,
    required this.periyot,
  });
}

void setMedicine(int medicineID, int dosage) async {
  final response = await http.get(Uri.parse('http://arduino-ip-address/setMedicine?medicine=$medicineID&dosage=$dosage'));
  if (response.statusCode == 200) {
    // Medication successfully set
  } else {
    // Error case
    print('An error occurred while setting the medication.');
  }
}
