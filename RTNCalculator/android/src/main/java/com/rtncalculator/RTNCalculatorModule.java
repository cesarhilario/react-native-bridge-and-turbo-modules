package com.RTNCalculator;

import androidx.annotation.NonNull;
import com.facebook.react.bridge.NativeModule;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import java.util.Map;
import java.util.HashMap;
import com.calculator.NativeCalculatorSpec;

public class RTNCalculatorModule extends NativeCalculatorSpec {

    public static String NAME = "RTNCalculator";

    RTNCalculatorModule(ReactApplicationContext context) {
        super(context);
    }

    @Override
    @NonNull
    public String getName() {
        return NAME;
    }

    @Override
    public double add(double a, double b) {
       return a + b;
    }
}