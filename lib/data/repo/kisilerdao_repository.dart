import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:kisiler_uygulamasi/data/entity/kisiler_cevap.dart';

import '../entity/kisiler.dart';

class KisilerDaoRepository{
  
  List<Kisiler> parseKisiler(String cevap){
    return KisilerCevap.fromJson(jsonDecode(cevap)).kisiler;
  }
  
  
  
  Future<String> kaydet(String kisi_ad, String kisi_tel) async{
    var url = "http://kasimadalan.pe.hu/kisiler/insert_kisiler.php";
    Map<String,dynamic> kisi = <String,dynamic>{};
    kisi["kisi_ad"] = kisi_ad;
    kisi["kisi_tel"] = kisi_tel;
    var cevap = await Dio().post(url,data: FormData.fromMap(kisi));
    return cevap.data;

  }

  Future<void> guncelle(String kisi_id, String kisi_ad, String kisi_tel) async{
    var url = "http://kasimadalan.pe.hu/kisiler/update_kisiler.php";
    Map<String,dynamic> kisi = <String,dynamic>{};
    kisi["kisi_id"] = kisi_id;
    kisi["kisi_ad"] = kisi_ad;
    kisi["kisi_tel"] = kisi_tel;

    await Dio().post(url,data: FormData.fromMap(kisi));

  }

  Future<List<Kisiler>> kisileriYukle() async {
    var url = "http://kasimadalan.pe.hu/kisiler/tum_kisiler.php";
    var cevap = await Dio().get(url);
    return parseKisiler(cevap.data as String);
  }

  Future<List<Kisiler>> ara(String aramaKelimesi) async{
    var url = "http://kasimadalan.pe.hu/kisiler/tum_kisiler_arama.php";
    var map = {"kisi_ad":aramaKelimesi};
    var response = await Dio().post(url,data: FormData.fromMap(map));
    return parseKisiler(response.data as String);



  }

  Future<String> kisiSil(String kisi_id) async{
    var url = "http://kasimadalan.pe.hu/kisiler/delete_kisiler.php";
    Map<String,dynamic> map = <String,dynamic>{};
    map["kisi_id"] = kisi_id;
    var cevap = await Dio().post(url,data: FormData.fromMap(map));
    return cevap.data as String;
  }
}