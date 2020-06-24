import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:finding_heroes/utils/globals.dart' as globals;
import 'package:mercadopago_sdk/mercadopago_sdk.dart';

class MercadoPagoDonation extends StatefulWidget {

	@override
	_MercadoPagoDonationState createState() => _MercadoPagoDonationState( );

}

class _MercadoPagoDonationState extends State < MercadoPagoDonation > {


	TextEditingController _nomeInputController = TextEditingController();
	TextEditingController _valorInputController = TextEditingController();

	@override
	void initState() {

		super.initState();

		const channelMercadoPagoResposta =
			const MethodChannel("matheus.com/mercadoPagoResposta");

		channelMercadoPagoResposta.setMethodCallHandler((MethodCall call) async {

			switch (call.method) {
				case 'mercadoPagoOK':

					var idPago = call.arguments[0];
					var status = call.arguments[1];
					var statusDetails = call.arguments[3];

					return mercadoPagoOK(idPago, status, statusDetails);

				case 'mercadoPagoErro':

					var erro = call.arguments[0];
					return mercadoPagoErro(erro);

			}
		});

	}

	@override
	Widget build(BuildContext context) {
		return _buildHomeScreen();
	}

_buildHomeScreen() => Column (
    
    children: <Widget>[

    Container(
  
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
  
      child: TextField (
  
        controller: _valorInputController,
  
        decoration: InputDecoration(labelText: "Valor a doar"),
  
        keyboardType: TextInputType.numberWithOptions(decimal: true),
  
      ),
  
    ),
  
  
    Container(
  
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
  
      decoration: new BoxDecoration(
  
        color: Color.fromARGB(255, 112, 167, 169),
  
        borderRadius: new BorderRadius.all( Radius.circular( 10 ) )),
  
        alignment: Alignment.center,
  
  
      child: _mercadoPagoButton()
  

    ),
  
  ],

);



_mercadoPagoButton() => CupertinoButton (
  
  child: Text('Mercado Pago', style: TextStyle(color: Colors.white)),
  onPressed: () async {
    print("testeeeeee");

    _criaPreferencia().then((result) {

      if (result != null) {

        var preferenceID = result['response']['id'];

        try {

          const channelMercadoPago =
            const MethodChannel("matheus.com/mercadoPago");
          final response = channelMercadoPago.invokeMethod("mercadoPago",

            <
            String, dynamic > {
              "publicKey": globals.mpTESTPublicKey,
              "preferenceID": preferenceID
            });

          print("oooi: $response");

        }
        on PlatformException
        catch (error) {
          print(error.message);
        }

      }

    });

  },
);



	Future <Map <String,dynamic>> _criaPreferencia() async {

		var mp = MP(globals.mpClientID, globals.mpClientSecret);

		var preference = {
			"items": [{
				"title": "doacao",
				"quantity": 1,
				"currency_id": "BRL",
				"unit_price": 40.0
			}],

			"payer": {
				"name": "Matheus",
				"email": "test_user_19653727@testuser.com"
			},

			"payment_methods": {
				"excluded_payment_types": [

					{ "id": "ticket"},
					{ "id": "atm" }
				]
			}

		};

		var result = await mp.createPreference(preference);

		return result;
	}


	void mercadoPagoOK(idPago, status, statusDetails) {
		print("idPago: $idPago");
		print("status: $status");
		print("statusDetails: $statusDetails");
	}

	void mercadoPagoErro(erro) {
		print("erro: $erro");
	}

}