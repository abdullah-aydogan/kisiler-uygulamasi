import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi/repo/kisilerdao_repository.dart';

class KisiKayitCubit extends Cubit<void> {

  KisiKayitCubit() : super(0);

  var repo = KisilerDaoRepository();

  Future<void> kayit(String kisi_ad, String kisi_tel) async {

    await repo.kisiKayit(kisi_ad, kisi_tel);
  }
}