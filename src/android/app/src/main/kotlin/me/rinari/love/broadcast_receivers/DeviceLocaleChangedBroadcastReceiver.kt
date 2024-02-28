package me.rinari.love.broadcast_receivers

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import me.rinari.love.MainActivity
import me.rinari.love.NotesActivity
import java.util.*

class DeviceLocaleChangedBroadcastReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        if (intent?.action == Intent.ACTION_LOCALE_CHANGED) {
            val languageTag = Locale.getDefault().toLanguageTag()
            MainActivity.self?.dispatchDeviceLocaleChangedEvent(languageTag)
            NotesActivity.self?.dispatchDeviceLocaleChangedEvent(languageTag)
        }
    }
}