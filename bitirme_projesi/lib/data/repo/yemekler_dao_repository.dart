// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:bitirme_projesi/data/entity/sepetteki_yemekler.dart';
import 'package:bitirme_projesi/data/entity/yemekler.dart';
import 'package:dio/dio.dart';

class YemeklerDaoRepository {
  List<Yemekler> parseYemeklerCevap(String cevap) =>
      YemeklerCevap.fromJson(json.decode(cevap)).yemekler;
  List<SepettekiYemekler> parseSepetYemeklerCevap(String cevap) {
    try {
      var decodedJson = jsonDecode(cevap);
      return SepetCevap.fromJson(decodedJson).sepettekiYemekler;
    } catch (e) {
      print("Ayrıştırma Hatası:$e");
      return [];
    }
  }

  Future<List<Yemekler>> yemekleriGetir() async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);
    return parseYemeklerCevap(cevap.data.toString());
  }

  Future<List<Yemekler>> ara(String aramaKelimesi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);
    List<Yemekler> tumYemekler = parseYemeklerCevap(cevap.data.toString());
    List<Yemekler> filtrelenmisYemekler = tumYemekler
        .where((element) => element.yemek_ad
            .toLowerCase()
            .contains(aramaKelimesi.toLowerCase()))
        .toList();
    return filtrelenmisYemekler;
  }
  

  Future<List<SepettekiYemekler>> sepettekiYemekleriGetir(
      String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri = {"kullanici_adi": kullanici_adi};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    return parseSepetYemeklerCevap(cevap.data.toString());
  }



  Future<void> sepeteYemekEkle(String yemek_adi, String yemek_resim_adi,
      String yemek_fiyat, String yemek_siparis_adet, String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var veri = {
      "yemek_adi": yemek_adi,
      "yemek_resim_adi": yemek_resim_adi,
      "yemek_fiyat": yemek_fiyat,
      "yemek_siparis_adet": yemek_siparis_adet,
      "kullanici_adi": kullanici_adi
    };
   
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
  }

  Future<void> sepettekiYemekleriSil(
      String sepet_yemek_id, String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri = {
      "sepet_yemek_id": sepet_yemek_id,
      "kullanici_adi": kullanici_adi
    };
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
  }
}
