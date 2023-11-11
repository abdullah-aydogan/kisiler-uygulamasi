import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi/colors.dart';
import 'package:kisiler_uygulamasi/cubit/kisi_kayit_cubit.dart';

class KisiKayitSayfa extends StatefulWidget {

  const KisiKayitSayfa({super.key});

  @override
  State<KisiKayitSayfa> createState() => _KisiKayitSayfaState();
}

class _KisiKayitSayfaState extends State<KisiKayitSayfa> {

  var tfKisiAd = TextEditingController();
  var tfKisiTel = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        foregroundColor: foregroundColor,
        title: const Text("Yeni Kişi Ekle"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: tfKisiAd,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Kişi Adı",
                  hintText: "Kişi adını giriniz...",
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: tfKisiTel,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Kişi Telefon Numarası",
                  hintText: "Kişi telefon numarasını giriniz...",
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorAccent,
                  foregroundColor: Colors.black,
                ),
                onPressed: () {
                  if(tfKisiAd.text.isNotEmpty && tfKisiTel.text.isNotEmpty) {

                    context.read<KisiKayitCubit>().kayit(tfKisiAd.text, tfKisiTel.text);
                    Navigator.of(context).popUntil((route) => route.isFirst);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Yeni kişi kaydı başarıyla eklendi.")),
                    );
                  }

                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Alanlar boş geçilemez!")),
                    );
                  }
                },
                icon: const Icon(Icons.person_add),
                label: const Text("KİŞİ EKLE"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
