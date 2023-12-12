// ignore_for_file: non_constant_identifier_names

class Yemekler {
  String yemek_id;
  String yemek_ad;
  String yemek_resim_adi;
  String yemek_fiyat;
  Yemekler(
      {required this.yemek_id,
      required this.yemek_ad,
      required this.yemek_resim_adi,
      required this.yemek_fiyat});
  factory Yemekler.fromJson(Map<String, dynamic> json) {
    return Yemekler(
        yemek_id: json["yemek_id"] as String,
        yemek_ad: json["yemek_adi"] as String,
        yemek_resim_adi: json["yemek_resim_adi"] as String,
        yemek_fiyat: json["yemek_fiyat"] as String);
  }
}



class YemeklerCevap {
  List<Yemekler> yemekler;
  int success;
  YemeklerCevap({required this.yemekler, required this.success});
  factory YemeklerCevap.fromJson(Map<String, dynamic> json) {
    int success = json["success"] as int;
    var yemekListesi = json["yemekler"] as List;
    List<Yemekler> yemekler =
        yemekListesi.map((yemek) => Yemekler.fromJson(yemek)).toList();
    return YemeklerCevap(yemekler: yemekler, success: success);
  }
}


