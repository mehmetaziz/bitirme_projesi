// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:bitirme_projesi/data/entity/yemekler.dart';
import 'package:bitirme_projesi/ui/cubit/urun_sayfa_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UrunSayfa extends StatefulWidget {
  Yemekler yemek;

  UrunSayfa({super.key, required this.yemek});

  @override
  State<UrunSayfa> createState() => _UrunSayfaState();
}

class _UrunSayfaState extends State<UrunSayfa> {
  var siparisSayiKontrol = TextEditingController();
  int siparisAdet = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var yemek = widget.yemek;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ürün Detayı"),
      ),
      body: Center(
        child: Column(
          children: [
            Image.network(
              "http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}",
              width: 100,
              height: 100,
            ),
            Text(widget.yemek.yemek_ad),
            Text("${widget.yemek.yemek_fiyat} ₺"),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                const Text(
                  "Adet:",
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                    onPressed: () {
                      siparisAdet--;
                      siparisSayiKontrol.text = siparisAdet.toString();
                    },
                    icon: Icon(Icons.remove_circle_outline)),
                SizedBox(
                  width: 75,
                  height: 75,
                  child: TextField(
                    controller: siparisSayiKontrol,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      siparisAdet++;
                      siparisSayiKontrol.text = siparisAdet.toString();
                    },
                    icon: Icon(Icons.add_circle_outline)),
              ],
            ),
            IconButton(
              onPressed: () {
                context.read<UrunSayfaCubit>().sepeteYemekEkle(
                    widget.yemek.yemek_ad,
                    widget.yemek.yemek_resim_adi,
                    widget.yemek.yemek_fiyat,
                    siparisSayiKontrol.text,
                    "Mehmet");
              },
              icon: const Icon(Icons.add_shopping_cart_outlined),
            )
          ],
        ),
      ),
    );
  }
}
