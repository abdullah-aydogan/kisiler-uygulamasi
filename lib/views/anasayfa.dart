import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi/colors.dart';
import 'package:kisiler_uygulamasi/entity/kisiler.dart';
import 'package:kisiler_uygulamasi/views/kisi_detay_sayfa.dart';
import 'package:kisiler_uygulamasi/views/kisi_kayit_sayfa.dart';
import '../cubit/anasayfa_cubit.dart';

class Anasayfa extends StatefulWidget {

  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  bool aramaYapiliyorMu = false;

  @override
  void initState() {

    super.initState();
    context.read<AnasayfaCubit>().kisileriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorPrimary,
        foregroundColor: foregroundColor,
        title: aramaYapiliyorMu ?
          TextField(
            decoration: const InputDecoration(
              hintText: "Kişi Ara...",
              hintStyle: TextStyle(color: Color.fromARGB(200, 255, 255, 255)),
            ),
            style: TextStyle(color: foregroundColor),
            onChanged: (aramaSonucu) {
              context.read<AnasayfaCubit>().ara(aramaSonucu);
            },
          ) :
          const Text("Kişiler"),
        actions: [
          aramaYapiliyorMu ?
          IconButton(
            onPressed: () {
              setState(() {
                aramaYapiliyorMu = false;
                context.read<AnasayfaCubit>().kisileriYukle();
              });
            },
            icon: const Icon(Icons.cancel),
          ) :
          IconButton(
            onPressed: () {
              setState(() {
                aramaYapiliyorMu = true;
              });
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: BlocBuilder<AnasayfaCubit, List<Kisiler>>(
        builder: (context, kisilerListesi) {
          if(kisilerListesi.isNotEmpty) {
            return ListView.builder(
              itemCount: kisilerListesi.length,
              itemBuilder: (context, indeks) {
                var kisi = kisilerListesi[indeks];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => KisiDetaySayfa(kisi: kisi)))
                      .then((value) {
                        context.read<AnasayfaCubit>().kisileriYukle();
                      });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 4.0, left: 12.0, right: 12.0),
                    child: Card(
                      color: foregroundColor,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.person_outlined,size: 30),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      width: 200,
                                      child: Text(kisi.kisi_ad, style: const TextStyle(fontSize: 18)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const Icon(Icons.phone, size: 30),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      width: 200,
                                      child: Text(kisi.kisi_tel, style: const TextStyle(fontSize: 18)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("${kisi.kisi_ad} kişi listesinden silinsin mi?"),
                                      action: SnackBarAction(
                                        label: "EVET",
                                        onPressed: () {
                                          context.read<AnasayfaCubit>().sil(kisi.kisi_id);
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("${kisi.kisi_ad} kişi listesinden silindi.")),
                                          );
                                        },
                                      ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.delete_outline, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }

          else {
            return const Center(
              child: Text("Kişi listeniz boş.", style: TextStyle(fontSize: 18)),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorAccent,
        foregroundColor: Colors.black,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const KisiKayitSayfa()))
              .then((value) {
                context.read<AnasayfaCubit>().kisileriYukle();
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}