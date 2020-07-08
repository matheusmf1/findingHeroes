package br.com.argrolabs.finding_heroes

import android.app.Activity
import android.content.Intent
import android.os.Bundle
import androidx.annotation.NonNull;
import com.mercadopago.android.px.core.MercadoPagoCheckout
import com.mercadopago.android.px.model.Payment
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }

    private val REQUEST_CODE = 1

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        initFlutterChannels()

    }

    private fun initFlutterChannels() {

        val channelMercadoPago = MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, "matheus.com/mercadoPago" )


        channelMercadoPago.setMethodCallHandler { call, result ->

            val args = call.arguments as HashMap<String, Any>
            val publicKey = args["publicKey"] as String
            val preferenceID = args["preferenceID"] as String

            when( call.method ) {
                "mercadoPago" -> mercadoPago( publicKey, preferenceID, result )
                else -> return@setMethodCallHandler
            }
        }

    }

    private fun mercadoPago( publicKey: String, preferenceID: String, channelResult: MethodChannel.Result ) {
        MercadoPagoCheckout.Builder( publicKey, preferenceID ).build().startPayment( applicationContext, REQUEST_CODE )
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        val channelMercadoPagoResposta = MethodChannel( flutterEngine?.dartExecutor?.binaryMessenger, "matheus.com/mercadoPagoResposta" )

        if ( resultCode == MercadoPagoCheckout.PAYMENT_RESULT_CODE ) {

            val payment = data!!.getSerializableExtra( MercadoPagoCheckout.EXTRA_PAYMENT_RESULT ) as Payment
            val paymentStatus = payment.paymentStatus
            val paymentStatusDetails = payment.paymentStatusDetail
            val paymentID = payment.id

            val arrayList = ArrayList<String>()
            arrayList.add( paymentID.toString() )
            arrayList.add( paymentStatus )
            arrayList.add( paymentStatusDetails )

            channelMercadoPagoResposta.invokeMethod( "mercadoPagoOK", arrayList )

        }
        else if ( resultCode == Activity.RESULT_CANCELED ) {

            val arrayList = ArrayList<String>()
            arrayList.add( "pagoErro" )
            channelMercadoPagoResposta.invokeMethod( "mercadoPagoErro", arrayList )

        }
        else {

            val arrayList = ArrayList<String>()
            arrayList.add( "pagoCancelado" )
            channelMercadoPagoResposta.invokeMethod( "mercadoPagoErro", arrayList )

        }
    }
}
