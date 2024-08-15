package io.flutter.plugins.cronet_http

import org.chromium.net.RequestFinishedInfo
import java.util.concurrent.Executor

class RequestFinishInfoListenerProxy(val listener: RequestFinishInfoListenerInterface, executor: Executor?): RequestFinishedInfo.Listener(
    executor
) {
    public interface RequestFinishInfoListenerInterface {
        fun onRequestFinished(requestInfo: RequestFinishedInfo?);
    }

    override fun onRequestFinished(requestInfo: RequestFinishedInfo?) {
        listener.onRequestFinished(requestInfo);
    }
}