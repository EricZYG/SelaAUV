package com.example.flutter_pag_plugin;

import android.content.Context;
import android.graphics.SurfaceTexture;
import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.view.Surface;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import org.libpag.PAGFile;
import org.libpag.PAGLayer;
import org.libpag.PAGSurface;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.view.TextureRegistry;
import kotlin.Unit;
import kotlin.jvm.functions.Function1;

import java.util.concurrent.atomic.AtomicInteger;

import android.app.ActivityManager;

/**
 * FlutterPagPlugin
 */
public class FlutterPagPlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    TextureRegistry textureRegistry;
    Context context;
    //    io.flutter.plugin.common.PluginRegistry.Registrar registrar;
    FlutterPlugin.FlutterAssets flutterAssets;
    private Handler handler = new Handler(Looper.getMainLooper());

    private final HashMap<String, FlutterPagPlayer> layerMap = new HashMap<String, FlutterPagPlayer>();
    private final HashMap<String, TextureRegistry.SurfaceProducer> entryMap = new HashMap<>();

    private boolean isLowRamDevice = false;

    // 原生接口
    final static String _nativeInit = "initPag";
    final static String _nativeRelease = "release";
    final static String _nativeStart = "start";
    final static String _nativeStop = "stop";
    final static String _nativePause = "pause";
    final static String _nativeSetProgress = "setProgress";
    final static String _nativeGetPointLayer = "getLayersUnderPoint";

    // 参数
    final static String _argumentTextureId = "textureId";
    final static String _argumentAssetName = "assetName";
    final static String _argumentPackage = "package";
    final static String _argumentUrl = "url";
    final static String _argumentBytes = "bytesData";
    final static String _argumentRepeatCount = "repeatCount";
    final static String _argumentInitProgress = "initProgress";
    final static String _argumentAutoPlay = "autoPlay";
    final static String _argumentWidth = "width";
    final static String _argumentHeight = "height";
    final static String _argumentPointX = "x";
    final static String _argumentPointY = "y";
    final static String _argumentProgress = "progress";
    final static String _argumentEvent = "PAGEvent";
    final static String _argumentViewId = "viewId";
    final static String _argumentFrameAvailable = "frameAvailable";

    // 回调
    final static String _playCallback = "PAGCallback";
    final static String _eventStart = "onAnimationStart";
    final static String _eventEnd = "onAnimationEnd";
    final static String _eventCancel = "onAnimationCancel";
    final static String _eventRepeat = "onAnimationRepeat";
    final static String _eventUpdate = "onAnimationUpdate";
    final static String _eventFrameReady = "onFrameReady";

    //原子计数器
    AtomicInteger atomic = new AtomicInteger();

    public FlutterPagPlugin() {
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        atomic.incrementAndGet();

        flutterAssets = binding.getFlutterAssets();
        channel = new MethodChannel(binding.getBinaryMessenger(), "flutter_pag_plugin");
        channel.setMethodCallHandler(this);
        context = binding.getApplicationContext();
        textureRegistry = binding.getTextureRegistry();
        DataLoadHelper.INSTANCE.initDiskCache(context, DataLoadHelper.INSTANCE.DEFAULT_DIS_SIZE);

        ActivityManager am =
                (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);

        // 标记低内存机器，后面禁用 PAG / 降帧 / 降分辨率
        isLowRamDevice = am != null && am.isLowRamDevice();

        //Log.w("PAG_PLUGIN", "onAttachedToEngine");
    }

//    public static void registerWith(io.flutter.plugin.common.PluginRegistry.Registrar registrar) {
//        final FlutterPagPlugin plugin = new FlutterPagPlugin(registrar);
//        registrar.addViewDestroyListener(new PluginRegistry.ViewDestroyListener() {
//            @Override
//            public boolean onViewDestroy(FlutterNativeView flutterNativeView) {
//                plugin.onDestroy();
//                pluginList.remove(this);
//                return false; // We are not interested in assuming ownership of the NativeView.
//            }
//        });
//    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        switch (call.method) {
            case _nativeInit:
                initPag(call, result);
                break;
            case _nativeStart:
                start(call);
                result.success("");
                break;
            case _nativeStop:
                stop(call);
                result.success("");
                break;
            case _nativePause:
                pause(call);
                result.success("");
                break;
            case _nativeSetProgress:
                setProgress(call);
                result.success("");
                break;
            case _nativeRelease:
                release(call);
                result.success("");
                break;
            case _nativeGetPointLayer:
                result.success(getLayersUnderPoint(call));
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private void initPag(final MethodCall call, final Result result) {
        String assetName = call.argument(_argumentAssetName);
        byte[] bytes = call.argument(_argumentBytes);
        String url = call.argument(_argumentUrl);

        String flutterPackage = call.argument(_argumentPackage);
        int viewId = call.argument(_argumentViewId);

        //Log.w("PAG_PLUGIN", "assetName:" + assetName + ", viewId:" + viewId);

        if (bytes != null) {
            initPagPlayerAndCallback(PAGFile.Load(bytes), call, result);
        } else if (assetName != null) {
            String assetKey;
            if (flutterAssets != null) {
                if (flutterPackage == null || flutterPackage.isEmpty()) {
                    assetKey = flutterAssets.getAssetFilePathByName(assetName);
                } else {
                    assetKey = flutterAssets.getAssetFilePathByName(assetName, flutterPackage);
                }
            } else {
                assetKey = "";
            }

            if (assetKey == null) {
                error(call, result, "-1100", "asset资源加载错误: " + assetName, null);
                return;
            }

            int tag = atomic.get();
            WorkThreadExecutor.getInstance().post(() -> {
                if (tag != atomic.get()) return;
                PAGFile composition = PAGFile.Load(context.getAssets(), assetKey);
                handler.post(() -> {
                    if (tag != atomic.get()) return;

                    initPagPlayerAndCallback(composition, call, result);
                });
            });
        } else if (url != null) {

            int tag = atomic.get();
            DataLoadHelper.INSTANCE.loadPag(url, new Function1<byte[], Unit>() {
                @Override
                public Unit invoke(final byte[] bytes) {

                    if (tag != atomic.get()) return null;

                    handler.post(new Runnable() {
                        @Override
                        public void run() {
                            if (tag != atomic.get()) return;

                            if (bytes == null) {
                                error(call, result, "-1100", "url资源加载错误: " + url, null);
                                return;
                            }

                            initPagPlayerAndCallback(PAGFile.Load(bytes), call, result);
                        }
                    });

                    return null;
                }
            }, DataLoadHelper.FROM_PLUGIN);
        } else {
            error(call, result, "-1100", "未添加资源", null);
        }
    }

    private void initPagPlayerAndCallback(PAGFile composition, MethodCall call, final Result result) {
        if (composition == null) {
            error(call, result, "-1100", "load composition is null! " + call.argument(_argumentAssetName), null);
            return;
        }

        final int repeatCount = call.argument(_argumentRepeatCount);
        final double initProgress = call.argument(_argumentInitProgress);
        final boolean autoPlay = call.argument(_argumentAutoPlay);

        final int viewId = call.argument(_argumentViewId);

        //Log.w("PAG_PLUGIN", "viewId:" + viewId + ", layerMap:" + layerMap.size());

        final FlutterPagPlayer pagPlayer = new FlutterPagPlayer();
        if (channel == null || textureRegistry == null) {
            return;
        }

        final TextureRegistry.SurfaceProducer entry = textureRegistry.createSurfaceProducer();
        final String currentId = String.valueOf(entry.id());
        entryMap.put(String.valueOf(entry.id()), entry);
        layerMap.put(String.valueOf(entry.id()), pagPlayer);

        entry.setSize(composition.width(), composition.height());
        Surface surface = entry.getSurface();
        final PAGSurface pagSurface = PAGSurface.FromSurface(surface);
        pagPlayer.setSurface(pagSurface);

        int tag = atomic.get();
        WorkThreadExecutor.getInstance().post(() -> {
            if (tag != atomic.get()) return;

            pagPlayer.init(composition, repeatCount, initProgress, channel, Long.parseLong(currentId), isLowRamDevice);
            if (channel == null || textureRegistry == null) {
                return;
            }
            pagPlayer.updateBufferSize();

            handler.post(new Runnable() {
                @Override
                public void run() {
                    if (tag != atomic.get()) return;

                    notifyFrameReady(Long.parseLong(currentId), viewId);
                    if (autoPlay) {
                        pagPlayer.start();
                    }

                    final HashMap<String, Object> callback = new HashMap<String, Object>();
                    callback.put(_argumentTextureId, Long.parseLong(currentId));
                    callback.put(_argumentWidth, (double) composition.width());
                    callback.put(_argumentHeight, (double) composition.height());
                    result.success(callback);
                }
            });
        });
    }

    private void notifyFrameReady(long textureId, int viewId) {
        if (channel == null) {
            return;
        }

        final HashMap<String, Object> arguments = new HashMap<>();
        arguments.put(FlutterPagPlugin._argumentTextureId, textureId);
        arguments.put(FlutterPagPlugin._argumentViewId, viewId);
        arguments.put(FlutterPagPlugin._argumentEvent, _eventFrameReady);
        channel.invokeMethod(FlutterPagPlugin._playCallback, arguments);
    }

    void error(MethodCall call, Result result, @NonNull String errorCode, @Nullable String errorMessage, @Nullable Object errorDetails) {
        result.error(errorCode, errorMessage, errorDetails);
    }

    void start(MethodCall call) {
        FlutterPagPlayer flutterPagPlayer = getFlutterPagPlayer(call);
        if (flutterPagPlayer != null) {
            flutterPagPlayer.start();
        }
    }

    void stop(MethodCall call) {
        FlutterPagPlayer flutterPagPlayer = getFlutterPagPlayer(call);
        if (flutterPagPlayer != null) {
            flutterPagPlayer.stop();
        }
    }

    void pause(MethodCall call) {
        FlutterPagPlayer flutterPagPlayer = getFlutterPagPlayer(call);
        if (flutterPagPlayer != null) {
            flutterPagPlayer.pause();
        }
    }

    void setProgress(MethodCall call) {
        double progress = call.argument(_argumentProgress);
        FlutterPagPlayer flutterPagPlayer = getFlutterPagPlayer(call);
        if (flutterPagPlayer != null) {
            flutterPagPlayer.setProgressValue(progress);
        }
    }

    void release(MethodCall call) {
        final int viewId = call.argument(_argumentViewId);
        final int textureId = call.argument(_argumentTextureId);
        final boolean frameAvailable = call.argument(_argumentFrameAvailable); //标记surface是否正常，不正常不走缓存

        if (textureId < 0) return;

        String keyId = getTextureId(call);
        FlutterPagPlayer flutterPagPlayer = layerMap.remove(keyId);
        if (flutterPagPlayer != null) {
            flutterPagPlayer.stop();
            flutterPagPlayer.release();
        }

        TextureRegistry.SurfaceProducer entry = entryMap.remove(keyId);
        if (entry != null) {
            entry.release();
        }
    }

    List<String> getLayersUnderPoint(MethodCall call) {
        FlutterPagPlayer flutterPagPlayer = getFlutterPagPlayer(call);

        List<String> layerNames = new ArrayList<>();
        PAGLayer[] layers = null;
        if (flutterPagPlayer != null) {
            layers = flutterPagPlayer.getLayersUnderPoint(
                    ((Double) call.argument(_argumentPointX)).floatValue(), ((Double) call.argument(_argumentPointY)).floatValue());
        }

        if (layers != null) {
            for (PAGLayer layer : layers) {
                layerNames.add(layer.layerName());
            }
        }

        return layerNames;
    }

    FlutterPagPlayer getFlutterPagPlayer(MethodCall call) {
        return layerMap.get(getTextureId(call));
    }

    String getTextureId(MethodCall call) {
        return "" + call.argument(_argumentTextureId);
    }


    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        atomic.incrementAndGet();

        for (FlutterPagPlayer pagPlayer : layerMap.values()) {
            pagPlayer.release();
        }

        for (TextureRegistry.SurfaceProducer entry : entryMap.values()) {
            entry.release();
        }

        Log.w("PAG_PLUGIN", "onDetachedFromEngine,layers:" + layerMap.size());

        layerMap.clear();
        entryMap.clear();
        channel.setMethodCallHandler(null);
        channel = null;
        textureRegistry = null;
    }
}
