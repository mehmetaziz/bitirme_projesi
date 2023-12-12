import 'package:bitirme_projesi/data/entity/yemekler.dart';
import 'package:bitirme_projesi/data/repo/yemekler_dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnasayfaCubit extends Cubit<List<Yemekler>> {
  AnasayfaCubit() : super(<Yemekler>[]);
  var repo = YemeklerDaoRepository();
  Future<void> yemekleriGetir() async {
    var liste = await repo.yemekleriGetir();
    emit(liste);
  }

  Future<void> sepeteYemekEkle(String yemek_adi, String yemek_resim_adi,
      String yemek_fiyat, String yemek_siparis_adet, String kullanici_adi) async {
    await repo.sepeteYemekEkle(yemek_adi, yemek_resim_adi, yemek_fiyat,
        yemek_siparis_adet, kullanici_adi);
  }

  Future<void> ara(String aramaKelimesi) async {
    var liste = await repo.ara(aramaKelimesi);
    emit(liste);
  }
}
