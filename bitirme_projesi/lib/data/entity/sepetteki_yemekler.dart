// ignore_for_file: non_constant_identifier_names

class SepettekiYemekler {
  String sepet_yemek_id;
  String yemek_ad;
  String yemek_resim_adi;
  String yemek_fiyat;
  String yemek_siparis_adet;
  String kullanici_adi;
  SepettekiYemekler(
      {required this.sepet_yemek_id,
      required this.yemek_ad,
      required this.yemek_resim_adi,
      required this.yemek_fiyat,
      required this.yemek_siparis_adet,
      required this.kullanici_adi});
  factory SepettekiYemekler.fromJson(Map<String, dynamic> json) {
    return SepettekiYemekler(
        sepet_yemek_id: json["sepet_yemek_id"] as String,
        yemek_ad: json["yemek_adi"] as String,
        yemek_resim_adi: json["yemek_resim_adi"] as String,
        yemek_fiyat: json["yemek_fiyat"] as String,
        yemek_siparis_adet: json["yemek_siparis_adet"] as String,
        kullanici_adi: json["kullanici_adi"] as String);
  }
}
class SepetCevap {
  List<SepettekiYemekler> sepettekiYemekler;
  int success;
  SepetCevap({required this.sepettekiYemekler, required this.success});
  factory SepetCevap.fromJson(Map<String, dynamic> json) {
    
    int success = json["success"] as int;
    var sepettekiYemekListesi = json["sepet_yemekler"] as List;
    List<SepettekiYemekler> sepettekiYemekler =
        sepettekiYemekListesi.map((yemek) => SepettekiYemekler.fromJson(yemek)).toList();
    return SepetCevap(sepettekiYemekler: sepettekiYemekler, success: success);
  }
}