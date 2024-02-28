package me.rinari.love.broadcast_receivers

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import me.rinari.love.MainActivity

class AppChangeReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context?, intent: Intent?) {
        val packageName = intent?.data?.encodedSchemeSpecificPart ?: return

        handle(intent.action, packageName, false)
    }

    companion object {
        fun handle(
            action: String?,
            packageName: String,
            replacing: Boolean
        ) {
            val isRemoved = action == Intent.ACTION_PACKAGE_REMOVED

            MainActivity.self?.dispatchAppChangedEvent(packageName, isRemoved)
        }
    }
}