package com.example.mmkvandlayout;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

import com.tencent.mmkv.MMKV;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        String rootDir = MMKV.initialize(this);
        System.out.println("mmkv root: " + rootDir);


        MMKV kv = MMKV.defaultMMKV();

        kv.encode("bool", true);
        boolean bValue = kv.decodeBool("bool");

        kv.encode("int", Integer.MIN_VALUE);
        int iValue = kv.decodeInt("int");

        kv.encode("string", "Hello from mmkv");
        String str = kv.decodeString("string");



    }
}
