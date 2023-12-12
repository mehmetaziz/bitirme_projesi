// ignore_for_file: must_be_immutable

import 'package:bitirme_projesi/data/entity/sepetteki_yemekler.dart';
import 'package:bitirme_projesi/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SepetSayfa extends StatefulWidget {
  SepetSayfa({
    super.key,
  });

  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {
  double urunToplam = 0;
  double sepetToplam = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SepetSayfaCubit>().sepettekiYemekleriGetir("Mehmet");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<SepetSayfaCubit, List<SepettekiYemekler>>(
        builder: (context, sepet) {
          if (sepet.isNotEmpty) {
            return ListView.builder(
              itemCount: sepet.length,
              itemBuilder: (context, index) {
                var sepettekiYemek = sepet[index];
                urunToplam = double.parse(sepettekiYemek.yemek_fiyat) *
                    double.parse(sepettekiYemek.yemek_siparis_adet);
                sepetToplam =sepetToplam+ urunToplam;

                return GestureDetector(
                  /*  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UrunSayfa(yemek: sepettekiYemek),
                      )),*/
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.network(
                            "http://kasimadalan.pe.hu/yemekler/resimler/${sepettekiYemek.yemek_resim_adi}"),
                        Column(
                          children: [
                            Text(sepettekiYemek.yemek_ad),
                            SizedBox(
                              height: 20,
                            ),
                            Text("Fiyat: ${sepettekiYemek.yemek_fiyat} ₺"),
                            SizedBox(
                              height: 20,
                            ),
                            Text("Adet: ${sepettekiYemek.yemek_siparis_adet}"),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                        Text(urunToplam.toString()),
                        IconButton(
                            onPressed: () => context
                                .read<SepetSayfaCubit>()
                                .sepettekiYemekleriSil(
                                    sepettekiYemek.sepet_yemek_id, "Mehmet"),
                            icon: const Icon(Icons.remove_shopping_cart))
                      ],
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
      bottomNavigationBar: BottomAppBar(
        child: Row(
          children: [
            Text("Toplam: ${sepetToplam.toStringAsFixed(2)} ₺")
          ],
        ),
      ),
    );
  }
}
