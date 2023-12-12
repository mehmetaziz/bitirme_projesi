import 'package:bitirme_projesi/data/entity/yemekler.dart';
import 'package:bitirme_projesi/ui/cubit/anasayfa_cubit.dart';
import 'package:bitirme_projesi/ui/views/sepet_sayfa.dart';
import 'package:bitirme_projesi/ui/views/urun_sayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  var tfKontrol = TextEditingController();
  ThemeMode themeMode=ThemeMode.system;
  void modSecin(ThemeMode mode)=>setState(() {
    themeMode=mode;
  });
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AnasayfaCubit>().yemekleriGetir();
  }

  var siparisAdet = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hoşgeldiniz"),actions: [
          PopupMenuButton<ThemeMode>(
            onSelected:modSecin ,
            itemBuilder: (context) => <PopupMenuEntry<ThemeMode>>[
              PopupMenuItem<ThemeMode>(
                value: ThemeMode.system,
                child: Text("Sistem Teması"),),
              PopupMenuItem<ThemeMode>(
                value: ThemeMode.light,
                child: Text("Açık Tema"),),
              PopupMenuItem<ThemeMode>(
                value: ThemeMode.dark,
                child: Text("Koyu Tema"),),
            ],
          )
          ],
      ),
      body: CustomScrollView(slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              TextField(controller: tfKontrol,
                decoration: InputDecoration(hintText: "Ara"),
                onChanged: (sonuc) =>context.read<AnasayfaCubit>().ara(sonuc) ,
              ),
              SizedBox(
                height: 550,
                child: BlocBuilder<AnasayfaCubit, List<Yemekler>>(
                  builder: (context, yemekListesi) {
                    if (yemekListesi.isNotEmpty) {
                      return GridView.builder(
                        itemCount: yemekListesi.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 1 / 1.8),
                        itemBuilder: (context, index) {
                          var yemek = yemekListesi[index];
                          return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UrunSayfa(yemek: yemek),
                                )),
                            child: SizedBox(
                              child: Card(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Image.network(
                                      "http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}",
                                      width: 100,
                                      height: 100,
                                    ),
                                    Text(yemek.yemek_ad),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("Fiyat: ${yemek.yemek_fiyat} ₺"),
                                        ElevatedButton(
                                            onPressed: () => context
                                                .read<AnasayfaCubit>()
                                                .sepeteYemekEkle(
                                                    yemek.yemek_ad,
                                                    yemek.yemek_resim_adi,
                                                    yemek.yemek_fiyat,
                                                    siparisAdet.toString(),
                                                    "Mehmet"),
                                            child: const Icon(
                                                Icons.add_shopping_cart)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SepetSayfa(),
                  )),
              child: const Icon(Icons.shopping_cart)
              ),
      
    );
  }
}
