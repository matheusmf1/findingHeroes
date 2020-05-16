import 'package:donateapp/cards/donation_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: createHomePageBody(),
    );
  }

  createHomePageBody() {
    return DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder:
            (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 400.0,
              floating: true,
              pinned: false,
              backgroundColor:  Color.fromARGB(255, 215, 245, 248),
              flexibleSpace: FlexibleSpaceBar(
                  background: Image(
                    image: AssetImage(
                      'assets/images/persons.png'
                      ),
                      fit: BoxFit.fill,
                    )
                ),
              ),
          ];
        },
        body: Container(
          color: Color.fromARGB(255, 215, 245, 248),
          child: Column(
            children: <Widget>[
              createContentArea()
            ],
          ),
        )
      ),
    );
  }

  createContentArea() {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.fromLTRB(6, 0, 6, 0),
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.only(
            topRight: const Radius.circular(15.0),
            topLeft: const Radius.circular(15.0)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            DonationCard(
              "Covid-A",
                "   Recebe doações para comprar macacões impermeáveis, respiradores, alimentos e produtos de limpeza e higiene. Essas arrecadações são para ajudar o sistema de saúde da cidade e famílias em situação de vulnerabilidade diante da crise do novo coronavírus."
            ),
            DonationCard(
                "Projeto Atitude Cidadã",
                "   Está em Nossas Mãos, superou as expectativas. Mais de 100 toneladas de alimentos, produtos de limpeza e equipamentos de segurança foram arrecadados em apenas um dia. Todo esse material já começou a fazer a diferença para o grupo Unificados pela População de Rua, que atua no enfrentamento ao novo coronavírus."
            ),
            DonationCard(
              "Grupo Empresarial Solidário",
              "   Uma parte das doações é em dinheiro. Outra, em produtos - alimentos, material de limpeza, higiene pessoal e equipamentos hospitalares. E, ainda, em serviços prestados, como transporte."
            )
          ],
        ),
      )
    );
  }

}
