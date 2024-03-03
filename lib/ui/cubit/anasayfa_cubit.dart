import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi/data/entity/kisiler.dart';
import 'package:kisiler_uygulamasi/data/repo/kisilerdao_repository.dart';

class AnasayfaCubit extends Cubit<List<Kisiler>>{
  AnasayfaCubit():super(<Kisiler>[]);

  var krepo = KisilerDaoRepository();

  Future<void> kisileriYukle() async{
    emit(await krepo.kisileriYukle());
  }

  Future<void> ara(String aramaKelimesi) async{
    emit(await krepo.ara(aramaKelimesi));
  }

  Future<void> kisiSil(int kisi_id) async{
    await krepo.kisiSil(kisi_id.toString());
    await kisileriYukle();
  }
}