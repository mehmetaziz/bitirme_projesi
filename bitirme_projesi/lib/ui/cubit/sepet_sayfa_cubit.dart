import 'package:bitirme_projesi/data/entity/sepetteki_yemekler.dart';
import 'package:bitirme_projesi/data/repo/yemekler_dao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SepetSayfaCubit extends Cubit<List<SepettekiYemekler>> {
  SepetSayfaCubit() : super(<SepettekiYemekler>[]);
  var repo = YemeklerDaoRepository();
  Future<void> sepettekiYemekleriGetir(String kullanici_adi) async {
    var liste = await repo.sepettekiYemekleriGetir(kullanici_adi);
    emit(liste);
  }

  Future<void> sepettekiYemekleriSil(
      String sepet_yemek_id, String kullanici_adi) async {
    await repo.sepettekiYemekleriSil(sepet_yemek_id, kullanici_adi);
    sepettekiYemekleriGetir(kullanici_adi);
  }
}
