package com.bridgereactnativeexample.counter;

import com.facebook.react.bridge.*
import com.facebook.react.modules.core.DeviceEventManagerModule

class CounterEventEmitterModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

    override fun getName(): String {
        return "CounterWithEvents"
    }

    private var count = 0;

    private var _reactContext = reactContext;

    private var listenerCount = 0

    private fun sendEvent(reactContext: ReactContext, eventName: String, params: WritableMap?) {
        reactContext
            .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter::class.java)
            .emit(eventName, params)
    }

    @ReactMethod
    fun addListener(eventName: String) {
        if(listenerCount == 0) {
            // Set up any upstream listeners or background tasks as necessary
        }

        listenerCount += 1;
    }

    @ReactMethod
    fun removeListeners(count: Int) {
        listenerCount -= count;
        if(listenerCount == 0) {
            // Remove upstream listeners, stop unnecessary background tasks
        }
    }

    @ReactMethod
    fun increment() {
        count += 1;

        val params = Arguments.createMap().apply {
            putInt("count", count)
        };
        sendEvent(_reactContext, "onIncrement", params);
    }
}