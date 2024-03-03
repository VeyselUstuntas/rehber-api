import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi/ui/cubit/kayit_sayfa_cubit.dart';

class KayitSayfa extends StatefulWidget {
  const KayitSayfa({super.key});

  @override
  State<KayitSayfa> createState() => _KayitSayfaState();
}

class _KayitSayfaState extends State<KayitSayfa> {
  var tfKisiAd = TextEditingController();
  var tfKisiTel = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kişi Kayıt"),),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: TextField(controller: tfKisiAd, decoration: InputDecoration(hintText: "Kişi Adı Girin"),),
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: TextField(controller: tfKisiTel, decoration: InputDecoration(hintText: "Kişi Telefon Girin",), keyboardType: TextInputType.number,),
              ),
              ElevatedButton(
                  onPressed: (){
                    if(!tfKisiAd.text.isEmpty && !tfKisiTel.text.isEmpty){
                      var a = context.read<KayitSayfaCubit>().kaydet(tfKisiAd.text,tfKisiTel.text);
                      print("oldu hreal $a");
                    }
                    else
                      print("Boş girilemez");
                  },
                  child: Text("Kişiyi Kaydet",
                    style: TextStyle(fontSize: 18,),),
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))) ),),
            ],
          ),
        ),
      ),
    );
  }
}
