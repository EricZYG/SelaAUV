package com.example.flutter_pag_plugin;

import android.animation.Animator;
import android.animation.AnimatorListenerAdapter;
import android.animation.ValueAnimator;
import android.graphics.SurfaceTexture;
import android.view.animation.LinearInterpolator;

import org.libpag.PAGFile;
import org.libpag.PAGPlayer;
import org.libpag.PAGSurface;

import java.util.HashMap;

import io.flutter.plugin.common.MethodChannel;

import android.os.SystemClock;


public class FlutterPagPlayer extends PAGPlayer {

    private final ValueAnimator animator = ValueAnimator.ofFloat(0.0F, 1.0F);
    private boolean isRelease;
    private long currentPlayTime = 0L;
    private double progress = 0;
    private double initProgress = 0;

    private MethodChannel channel;
    private long textureId;

    //最后的一次flush时间，用于降帧率
    private long lastFlushTime = 0; // ⭐ flush 节流
    //帧间隔，默认值为66， 即1000/66=15fps
    private int flushInterval = 66;

    public FlutterPagPlayer() {
        super();
        animator.setInterpolator(new LinearInterpolator());
        animator.addUpdateListener(animatorUpdateListener);
        animator.addListener(animatorListenerAdapter);
    }

    public boolean isRelease() {
        return isRelease;
    }

    public void init(PAGFile file, int repeatCount, double initProgress, MethodChannel channel, long textureId, boolean isLowRamDevice) {
        synchronized (this) {
            setComposition(file);
        }

        this.flushInterval = isLowRamDevice ? 200 : 66;
        this.channel = channel;
        this.textureId = textureId;
        progress = initProgress;
        this.initProgress = initProgress;
        animator.setDuration(duration() / 1000L);
        if (repeatCount < 0) {
            repeatCount = 0;
        }
        animator.setRepeatCount(repeatCount - 1);
        setProgressValue(initProgress);
    }

    private boolean valid() {
        return getSurface() != null;
    }


    public void setProgressValue(double value) {
        synchronized (this) {
            this.progress = Math.max(0.0D, Math.min(value, 1.0D));
            this.currentPlayTime = (long) (progress * (double) this.animator.getDuration());
            this.animator.setCurrentPlayTime(currentPlayTime);
            setProgress(progress);
            flush();
        }
    }

    public void start() {
        animator.start();
    }

    public void stop() {
        pause();
        setProgressValue(initProgress);
    }

    @Override
    public void setSurface(PAGSurface pagSurface) {
        super.setSurface(pagSurface);
    }


    public void updateBufferSize() {
        synchronized (this) {
            PAGSurface surface = getSurface();
            if (surface != null) {
                surface.updateSize();
                surface.clearAll();
            }
        }
    }

    public void clear() {
        synchronized (this) {
            setComposition(null);
            if (valid()) {
                getSurface().freeCache();
                getSurface().clearAll();
            }
        }
    }

    public void cancel() {
        animator.cancel();
    }

    public void pause() {
        animator.pause();
    }

    @Override
    public void release() {
        isRelease = true;

        animator.cancel();
        animator.removeAllUpdateListeners();
        animator.removeAllListeners();
        //此处如果放入子线程处理，会打印gl的错误日志，挪到主线程
        synchronized (this) {
            if (getSurface() != null) getSurface().release();
        }

        super.release();
    }

    @Override
    public boolean flush() {
        if (isRelease) {
            return false;
        }

        //降帧，最高15帧
        long now = SystemClock.uptimeMillis();
        if (now - lastFlushTime < flushInterval) return false; // ⭐ ~15fps
        lastFlushTime = now;

//        WorkThreadExecutor.getInstance().post(() -> {
        synchronized (this) {
            if (isRelease) {
                return false;
            }
            return FlutterPagPlayer.super.flush();
        }
//        });
    }

    // 更新PAG渲染
    private final ValueAnimator.AnimatorUpdateListener animatorUpdateListener = new ValueAnimator.AnimatorUpdateListener() {

        @Override
        public void onAnimationUpdate(ValueAnimator animation) {
            progress = (double) (Float) animation.getAnimatedValue();
            currentPlayTime = (long) (progress * (double) animator.getDuration());
            synchronized (FlutterPagPlayer.this) {
                setProgress(progress);
                flush();
            }
        }
    };

    // 动画状态监听
    private final AnimatorListenerAdapter animatorListenerAdapter = new AnimatorListenerAdapter() {
        @Override
        public void onAnimationStart(Animator animator) {
            super.onAnimationStart(animator);
            notifyEvent(FlutterPagPlugin._eventStart);
        }

        @Override
        public void onAnimationEnd(Animator animation) {
            super.onAnimationEnd(animation);
            // Align with iOS platform, avoid triggering this method when stopping
            int repeatCount = ((ValueAnimator) animation).getRepeatCount();
            if (repeatCount >= 0 && (animation.getDuration() > 0) &&
                    (currentPlayTime / animation.getDuration() > repeatCount)) {
                notifyEvent(FlutterPagPlugin._eventEnd);
            }
        }

        @Override
        public void onAnimationCancel(Animator animator) {
            super.onAnimationCancel(animator);
            notifyEvent(FlutterPagPlugin._eventCancel);
        }

        @Override
        public void onAnimationRepeat(Animator animator) {
            super.onAnimationRepeat(animator);
            notifyEvent(FlutterPagPlugin._eventRepeat);
        }
    };

    void notifyEvent(String event) {
        final HashMap<String, Object> arguments = new HashMap<>();
        arguments.put(FlutterPagPlugin._argumentTextureId, textureId);
        arguments.put(FlutterPagPlugin._argumentEvent, event);
        channel.invokeMethod(FlutterPagPlugin._playCallback, arguments);
    }
}
