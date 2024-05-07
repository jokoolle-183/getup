package com.example.getup

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.location.GnssMeasurementsEvent
import android.location.Location
import android.location.LocationManager
import android.os.*
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel

class MainActivity: FlutterActivity() {
    private lateinit var locationManager: LocationManager
    private val CHANNEL = "com.stanisic.getup"
    private var eventSink: EventChannel.EventSink? = null

    private val gnssCallback: GnssMeasurementsEvent.Callback = @RequiresApi(Build.VERSION_CODES.N) object : GnssMeasurementsEvent.Callback() {
        override fun onGnssMeasurementsReceived(eventArgs: GnssMeasurementsEvent?) {
            super.onGnssMeasurementsReceived(eventArgs)
            val accumulatedDeltaRangeMeters = eventArgs?.measurements?.firstOrNull()?.accumulatedDeltaRangeMeters
            eventSink?.success(accumulatedDeltaRangeMeters)
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setStreamHandler(
            object : EventChannel.StreamHandler {

                @RequiresApi(Build.VERSION_CODES.N)
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    eventSink = events
                    registerMeasurementsCallback()
                }

                @RequiresApi(Build.VERSION_CODES.N)
                override fun onCancel(arguments: Any?) {
                    eventSink = null
                    locationManager.unregisterGnssMeasurementsCallback(gnssCallback)
                }
            }
        )
    }

    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
        locationManager = getSystemService(Context.LOCATION_SERVICE) as LocationManager
    }

    @RequiresApi(Build.VERSION_CODES.N)
    private fun registerMeasurementsCallback() {
        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            // TODO: Consider calling
            //    ActivityCompat#requestPermissions
            // here to request the missing permissions, and then overriding
            //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
            //                                          int[] grantResults)
            // to handle the case where the user grants the permission. See the documentation
            // for ActivityCompat#requestPermissions for more details.
            return
        }
        if (!this::locationManager.isInitialized) {
            locationManager = getSystemService(Context.LOCATION_SERVICE) as LocationManager
            locationManager.registerGnssMeasurementsCallback(gnssCallback, null)
        } else {
            locationManager.registerGnssMeasurementsCallback(gnssCallback, null)
        }
    }
}
