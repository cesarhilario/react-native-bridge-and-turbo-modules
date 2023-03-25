package com.bridgereactnativeexample.counter;

import com.facebook.react.bridge.*

class CounterModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {
    private var count: Int = 0;

    override fun getName(): String {
        return "Counter"
    }

    // How to expose a Kotlin method
    @ReactMethod
    fun increment() {
        count += 1;
        println("count is $count")
    }

    // How to expose static Kotlin data
    override fun getConstants(): MutableMap<String, Any>? {
        val myHashMap = hashMapOf<String, Any>();
        // Examples
        myHashMap["number"] = 123.4;
        myHashMap["string"] = "foo bar";
        myHashMap["boolean"] = true;
        myHashMap["array"] = arrayOf(1, 22.2, "33", false);
        myHashMap["object"] = mapOf("a" to 1, "b" to 2)

        // To export
        myHashMap["initialCount"] = count

        return  myHashMap
    }

    // How to exposed a Kotlin method with a callback
    @ReactMethod
    fun getCount(callback: Callback) {
        callback.invoke(count);
    }

    // Passing multiple arguments to a callback
    @ReactMethod
    fun callbackMethodWithArguments(callback: Callback) {
        val array: WritableArray = WritableNativeArray();
        array.pushInt(count); // Variable
        array.pushDouble(123.9); // int or float
        array.pushString("second argument"); // string
        val nestedArray: WritableArray = WritableNativeArray();
        nestedArray.pushInt(1);
        nestedArray.pushDouble(2.2);
        nestedArray.pushString("3");
        array.pushArray(nestedArray); // array
        val map: WritableMap = WritableNativeMap();
        map.putInt("a", 1);
        map.putInt("b", 2);
        array.pushMap(map); // object
        callback.invoke(array);
    }

    // How to exposed a Kotlin promise
    // For this example:
    // resolves by decrementing this count if its greater than 0
    // rejects when the count is less than  0
    @ReactMethod
    fun decrement(promise: Promise) {
        try {
            if(count <= 0) {
                throw Exception("Count cannot be negative");
            } else {
                count -= 1;
                promise.resolve("Count was decremented");

            }
        } catch (e: Throwable) {
            promise.reject("200", e)
        }
    }

}