package com.etzuk.flutter.flutterheremaps.location

import FlutterHereMaps.LocationObjects
import FlutterHereMaps.MapObjects
import android.app.*
import android.content.Context
import android.content.Intent

import android.os.Build
import android.os.IBinder
import android.os.PowerManager
import android.util.Log
import androidx.core.app.NotificationCompat
import androidx.localbroadcastmanager.content.LocalBroadcastManager
import com.here.android.mpa.common.GeoCoordinate
import com.here.android.mpa.common.GeoPosition
import com.here.android.mpa.common.LocationDataSourceHERE
import com.here.android.mpa.common.PositioningManager
import java.lang.ref.WeakReference
import kotlin.math.max


class BackgroundLocationService : Service(), PositioningManager.OnPositionChangedListener {

    private lateinit var localBroadcastReceiver: LocalBroadcastManager
    private lateinit var positioningManager: PositioningManager

    companion object {
        const val BROADCAST_ACTION = "Location_Broadcast_Actions"
        const val EXTRA_DATA = "Location_Read_Data"
        const val EXTRA_SETTINGS = "Location_Settings"
        const val WAKE_LOCK_TAG = "BackgroundLocationService::WakeLock"

    }


    override fun onCreate() {
        super.onCreate()
        (getSystemService(Context.POWER_SERVICE) as PowerManager)
                .run {
                    newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, WAKE_LOCK_TAG).apply {
                        acquire()
                    }
                }
        localBroadcastReceiver = LocalBroadcastManager.getInstance(this)
    }

    override fun onBind(intent: Intent?): IBinder? {
        return null
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        val androidLocationSettings = intent?.getByteArrayExtra(EXTRA_SETTINGS)?.let {
            LocationObjects.AndroidLocationSettings.parseFrom(it)
        }

        androidLocationSettings?.let { androidSettings ->
            createNotificationChannel(androidSettings)
            val iconRes = androidSettings.notificationSettings.iconData.toResId(context = this)

            val launchIntent = packageManager.getLaunchIntentForPackage(packageName)

            val notifyPendingIntent = PendingIntent.getActivity(
                    this, 0, launchIntent, PendingIntent.FLAG_UPDATE_CURRENT
            )

            val notification: Notification = NotificationCompat.Builder(this, androidSettings.notificationSettings.channelId)
                    .setContentTitle(androidSettings.notificationSettings.title)
                    .setContentText(androidSettings.notificationSettings.body)
                    .setSmallIcon(iconRes)
                    .setContentIntent(notifyPendingIntent)
                    .build()

            startForeground(androidSettings.locationServiceId, notification)
            startTracking(androidSettings.locationMethod)
            return START_NOT_STICKY
        } ?: return super.onStartCommand(intent, flags, startId)
    }

    override fun onTaskRemoved(root: Intent?) {
        super.onTaskRemoved(root)
        cleanup()
    }

    private fun createNotificationChannel(androidSettings: LocationObjects.AndroidLocationSettings) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val serviceChannel = NotificationChannel(
                    androidSettings.notificationSettings.channelId,
                    androidSettings.notificationSettings.channelName,
                    NotificationManager.IMPORTANCE_DEFAULT
            )
            val manager: NotificationManager = getSystemService(NotificationManager::class.java)
            manager.createNotificationChannel(serviceChannel)
        }
    }


    private fun startTracking(locationMethod: LocationObjects.AndroidLocationSettings.LocationMethod) {
        if (!::positioningManager.isInitialized) {
            positioningManager = PositioningManager.getInstance()
        }

        val hereDataSource = LocationDataSourceHERE.getInstance()
        if (hereDataSource != null) {

            positioningManager.dataSource = hereDataSource
            positioningManager.addListener(WeakReference<PositioningManager.OnPositionChangedListener>(this))
            if (positioningManager.start(PositioningManager.LocationMethod.values()[locationMethod.ordinal])) {
                Log.d("Background locations", "tracking started")
                // Position updates started successfully.
            } else {
                Log.e("Background locations", "error starting tracking")
                stopSelf()
            }
        }
    }

    override fun onDestroy() {
        cleanup()
        super.onDestroy()
    }

    private fun cleanup() {
        if (::positioningManager.isInitialized) {
            positioningManager.stop()
            positioningManager.removeListener(this)
        }
        (getSystemService(Context.POWER_SERVICE) as PowerManager).run {
            newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, WAKE_LOCK_TAG).apply {
                if (isHeld) {
                    setReferenceCounted(false)
                    release()
                }
            }
        }
        stopForeground(true)
        stopSelf()
    }

    override fun onPositionFixChanged(p0: PositioningManager.LocationMethod?, p1: PositioningManager.LocationStatus?) {

    }

    override fun onPositionUpdated(p0: PositioningManager.LocationMethod?, geoPosition: GeoPosition, p2: Boolean) {
        val data = Intent().setAction(BROADCAST_ACTION).putExtra(EXTRA_DATA, geoPosition.toLocation().toByteArray())
        localBroadcastReceiver.sendBroadcast(data)
    }


}

private fun GeoPosition.toLocation(): LocationObjects.LocationReading {
    return LocationObjects.LocationReading.newBuilder().apply {
        this.coordinate = this@toLocation.coordinate.toCoordinate()
        this.heading = this@toLocation.heading
        this.altitude = this@toLocation.coordinate.altitude
        this.speed = this@toLocation.speed
        this.accuracy = max(this@toLocation.latitudeAccuracy, this@toLocation.longitudeAccuracy).toDouble()
    }.build()

}

private fun GeoCoordinate.toCoordinate(): MapObjects.Coordinate {
    return MapObjects.Coordinate.newBuilder().apply {
        this.lng = this@toCoordinate.longitude
        this.lat = this@toCoordinate.latitude
    }.build()
}


fun LocationObjects.AndroidIconData.toResId(context: Context): Int {
    val type = when (iconType) {
        LocationObjects.AndroidIconData.Type.DRAWABLE -> "drawable"
        LocationObjects.AndroidIconData.Type.MIPMAP -> "mipmap"
        else -> ""
    }

    return context.resources.getIdentifier(iconName, type, context.packageName)
}




