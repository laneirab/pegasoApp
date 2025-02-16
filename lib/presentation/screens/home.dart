import 'package:flutter/material.dart';
import '../widgets/fotoUsuario.dart';
class Home extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFFF0F0F0),
                    Color(0xFFF0F0F0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.6, 0.3])),
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hola",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 0,
                      ),
                      Text(
                        "¡Ten un lindo día!",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                          color: Colors.purple,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                  Spacer(),
                  Fotousuario(
                    imageUrl: "https://i.pinimg.com/736x/b1/a6/1e/b1a61e29eaa57410058f1d671931f7a4.jpg",
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          top: 185,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: MediaQuery.of(context).size.height - 245,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Color(0xFFD3AAFB),
              borderRadius: BorderRadius.circular(30),
            ),
            child: ListView(
              children: [
                buildTitleRow("CLASES DE HOY", 0),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 25,
                ),
                buildTitleRow("PENDIENTES", 0),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Row buildTitleRow(String title, int number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
              text: title,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: "($number)",
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                ),
              ]),
        ),
        Text(
          "Ver todo",
          style: TextStyle(
              fontSize: 13,
              color: Color(0XFF3E3993),
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}