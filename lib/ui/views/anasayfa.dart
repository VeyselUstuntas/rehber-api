import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi/data/entity/kisiler.dart';
import 'package:kisiler_uygulamasi/ui/cubit/anasayfa_cubit.dart';
import 'package:kisiler_uygulamasi/ui/views/detay_sayfa.dart';
import 'package:kisiler_uygulamasi/ui/views/kayit_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;
  var tfAra = TextEditingController();




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AnasayfaCubit>().kisileriYukle();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !aramaYapiliyorMu ? Text("Kişiler"): TextField(
            controller: tfAra,
            onChanged: (aramaSonucu){
              context.read<AnasayfaCubit>().ara(aramaSonucu);
              print(tfAra);
            },
            decoration: InputDecoration(hintText: "Ara...")),
        actions: [
          IconButton(
            onPressed: (){
              setState(() {
                if(aramaYapiliyorMu){
                  aramaYapiliyorMu = false;
                  tfAra.text = "";
                  context.read<AnasayfaCubit>().kisileriYukle();
                }
                else{
                  aramaYapiliyorMu = true;
                }
              });
            },
            icon:  Icon( !aramaYapiliyorMu? Icons.search: Icons.clear))
        ],),
      body: BlocBuilder<AnasayfaCubit,List<Kisiler>>(
          builder: (context, kisilerListesi){
            if(kisilerListesi.isNotEmpty){
              return ListView.builder(
                itemCount: kisilerListesi.length,
                itemBuilder: (context, indeks){ // itemBuilder for yapısı gibi çalışır
                  var kisi = kisilerListesi[indeks];
                  return Padding(
                    padding: const EdgeInsets.only(left: 10.0,right: 10.0, bottom: 3.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(kisi: kisi)))
                            .then((value) {
                              print("anasayfaya dönüldü");
                              context.read<AnasayfaCubit>().kisileriYukle();
                        });
                      },
                      child: Card(
                        color: Colors.blueGrey,
                        shadowColor: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Align(alignment: Alignment.centerLeft,
                            child: SizedBox(height: 100,
                              child: Row(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(kisi.kisi_ad, style: TextStyle(fontSize: 22),),
                                      Text(kisi.kisi_tel,style: TextStyle(fontSize: 22),),
                                    ],
                                  ),
                                  Spacer(),
                                  Align(alignment: Alignment.centerRight,
                                      child:
                                      IconButton(
                                          onPressed: (){
                                            setState(() {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text("\'${kisi.kisi_ad}\' isimli kisi silinsin mi?"),
                                                    action: SnackBarAction(
                                                        label: "Evet",
                                                        onPressed: (){
                                                          context.read<AnasayfaCubit>().kisiSil(int.parse(kisi.kisi_id));
                                                          print("silindi mi");
                                                        }),
                                                  ),
                                              );
                                            });
                                          },
                                          icon: Icon(Icons.clear,size: 25.0, color: Colors.black26,),)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            else{
              return const Center();
            }
          },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> KayitSayfa()))
                .then((value){
              context.read<AnasayfaCubit>().kisileriYukle();
              print("Kişi kayıt ekranınıdan anasayfaya dönüldü.");
            });
          },
          child: Icon(Icons.add)),

    );
  }
}
