import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi/data/entity/kisiler.dart';
import 'package:kisiler_uygulamasi/ui/cubit/detay_sayfa_cubit.dart';

class DetaySayfa extends StatefulWidget {

  Kisiler kisi;

  DetaySayfa({required this.kisi});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  var tfKisiAd = TextEditingController();
  var tfKisiTel = TextEditingController();





  @override
  void initState() {
    super.initState();
    var kisi = widget.kisi;
    tfKisiAd.text = kisi.kisi_ad;
    tfKisiTel.text = kisi.kisi_tel;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kişi Detay"),),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: TextField(
                  controller: tfKisiAd,
                  decoration: InputDecoration(hintText: "Kişi Adı Girin"),),
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: TextField(
                  controller: tfKisiTel,
                  decoration: InputDecoration(hintText: "Kişi Telefon Girin",),
                  keyboardType: TextInputType.number,),
              ),
              ElevatedButton(
                onPressed: (){
                  if(!tfKisiAd.text.isEmpty && !tfKisiTel.text.isEmpty)
                    context.read<DetaySayfaCubit>().guncelle(int.parse(widget.kisi.kisi_id), tfKisiAd.text, tfKisiTel.text);
                  else
                    print("Boş girilemez");
                },
                child: Text("Kişiyi Güncelle",
                  style: TextStyle(fontSize: 18,),),
                style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))) ),),
            ],
          ),
        ),
      ),);
  }
}
