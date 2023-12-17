package com.crossplatformpython;
import com.facebook.react.bridge.NativeModule
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.ReactContext
import com.facebook.react.bridge.ReactContextBaseJavaModule
import com.facebook.react.bridge.ReactMethod

import android.util.Log

class TestModule(reactContext: ReactApplicationContext) : ReactContextBaseJavaModule(reactContext) {

    override fun getName() = "TestModule"

    @ReactMethod
    fun helloWorld(name: String){
        Log.d("TestModule", "Hello World! : $name") 
    }

}
