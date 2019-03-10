package pokestar.androidlab.nuc.com.example.astroweather;

import io.flutter.app.FlutterApplication;

public class MainApplication extends FlutterApplication {

    @Override
    public void onCreate() {
        super.onCreate();
        // 初始化百度地图 SDK
       // SDKInitializer.initialize(this);
        //SDKInitializer.setCoordType(CoordType.BD09LL);
    }
}
