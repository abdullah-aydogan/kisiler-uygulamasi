import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi/colors.dart';
import 'package:kisiler_uygulamasi/cubit/anasayfa_cubit.dart';
import 'package:kisiler_uygulamasi/cubit/kisi_detay_cubit.dart';
import 'package:kisiler_uygulamasi/entity/kisiler.dart';

class KisiDetaySayfa extends StatefulWidget {

  Kisiler kisi;

  KisiDetaySayfa({required this.kisi});

  @override
  State<KisiDetaySayfa> createState() => _KisiDetaySayfaState();
}

class _KisiDetaySayfaState extends State<KisiDetaySayfa> {

  var tfKisiAd = TextEditingController();
  var tfKisiTel = TextEditingController();

  @override
  void initState() {

    super.initState();

    var kisi = widget.kisi;
    tfKisiAd.text = kisi.kisi_ad;
    tfKisiTel.text = kisi.kisi_tel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        foregroundColor: foregroundColor,
        title: const Text("Kişi Detayları"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${widget.kisi.kisi_ad} kişi listesinden silinsin mi?"),
                  action: SnackBarAction(
                    label: "EVET",
                    onPressed: () {
                      context.read<AnasayfaCubit>().sil(widget.kisi.kisi_id);
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${widget.kisi.kisi_ad} kişi listesinden silindi.")),
                      );
                    },
                  ),
                ),
              );
            },
            icon: const Icon(Icons.delete_outline),
          ),
        ],
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
                  prefixIcon: Icon(Icons.person_outlined),
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

                    context.read<KisiDetayCubit>().guncelle(widget.kisi.kisi_id, tfKisiAd.text, tfKisiTel.text);
                    Navigator.of(context).popUntil((route) => route.isFirst);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Kişi kaydı başarıyla güncellendi.")),
                    );
                  }

                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Alanlar boş geçilemez!")),
                    );
                  }
                },
                label: const Text("KAYDI GÜNCELLE"),
                icon: const Icon(Icons.update_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }
}