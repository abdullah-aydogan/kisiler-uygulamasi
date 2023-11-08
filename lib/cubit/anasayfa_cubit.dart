import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi/entity/kisiler.dart';
import '../repo/kisilerdao_repository.dart';

class AnasayfaCubit extends Cubit<List<Kisiler>> {

  AnasayfaCubit() : super(<Kisiler>[]);

  var repo = KisilerDaoRepository();

  Future<void> kisileriYukle() async {

    var liste = await repo.tumKisileriAl();

    emit(liste);
  }

  Future<void> ara(String aramaKelimesi) async {

    var liste = await repo.kisiAra(aramaKelimesi);

    emit(liste);
  }

  Future<void> sil(int kisi_id) async {

    await repo.kisiSil(kisi_id);
    await kisileriYukle();
  }
}