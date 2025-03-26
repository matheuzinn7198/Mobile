import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

//class de janela
class MyApp extends StatelessWidget{
  //contrutor de widget
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("Exemplo Widget de Exibição"),),
      body: Center(
        child: Column(
          children: [
            Text("Exemplo de Texto",
            style: TextStyle(
              fontSize: 20,
              color: Colors.blue,
            ),),
            Text("Texto Personalizado",
            style: TextStyle(
              fontSize: 24,
              color: Colors.red,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              wordSpacing: 2,
              decoration: TextDecoration.underline
            ),),
            //icones 
            Icon(Icons.star, size: 50, color: Colors.amber,),
            IconButton(
              onPressed: () => print("Icone Pressionado"),
               icon: Icon(Icons.add_a_photo),
               iconSize: 50),
               //imagens
               Image.network("https://imgs.search.brave.com/U6cjd5N7_tyCf06aYW3Kw5gHTL758LtaTRxRL0EaxoQ/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9vY2Mt/MC04MTA0LTE4NS4x/Lm5mbHhzby5uZXQv/ZG5tL2FwaS92Ni9R/czAwbUtDcFJ2cmts/M0haQU41S3dFTDFr/cEUvQUFBQUJWYTRS/eDNMakVhYmFDVm4t/cWZOWWQ2anBNRnBS/MEgydlRXVU0xNUdW/RTM4aWtUaFRSN041/MHVTZTRXempXQUZS/SGtoblZSUHN2ZTBD/TnhudjEzS0huZmdv/dFQ5M2x2Q3hoaF8u/anBnP3I9YzIx",
               width: 200, height: 200, fit: BoxFit.cover,),
               Image.asset("assets/img/image.png",
                width: 200, height: 200, fit: BoxFit.cover,),
                //Box para Exibição de Imagem
                Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        "assets/img/image.png",
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "assets/img/image.png",
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                    ),
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }
}