import 'package:flutter_bloc/flutter_bloc.dart';
import '../repo/kisilerdao_repository.dart';

class KisiDetayCubit extends Cubit<void> {

  KisiDetayCubit() : super(0);

  var repo = KisilerDaoRepository();

  Future<void> guncelle(int kisi_id, String kisi_ad, String kisi_tel) async {

    await repo.kisiGuncelle(kisi_id, kisi_ad, kisi_tel);
  }
}