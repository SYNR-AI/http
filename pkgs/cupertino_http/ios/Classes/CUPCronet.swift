//
//  CUPCronet.swift
//  cupertino_http
//
//  Created by xp on 2024/8/6.
//

import Foundation
import Cronet

public enum CUPCronetHttpCacheMode: Int {
    case disabled = 1
    case disk = 2
    case memory = 3
}

@objcMembers
public class CUPCronetConfig: NSObject {
    public var enableHttp2 = true
    public var enableQuic = true
    public var enableBroli = true
    public var enableMetrics = true
    public var httpCacheMode = CUPCronetHttpCacheMode.disabled
    public var userAgent: String = "Cronet"
    public var interceptHostWhiteList: [String]?
    
}

@objcMembers
public class CUPCronet: NSObject {
    static var isStarted: Bool = false
    
    public class func isCronetStarted() -> Bool {
        return isStarted;
    }
    
    public class func start(config: CUPCronetConfig) -> Void{
        if (isStarted) {
            return
        }
        Cronet.setHttp2Enabled(config.enableHttp2)
        // 设置支持 QUIC
        Cronet.setQuicEnabled(config.enableQuic)
        // 设置支持 Br 压缩算法，并列的有gzip算法
        Cronet.setBrotliEnabled(config.enableBroli)
        Cronet.setMetricsEnabled(config.enableMetrics)
        Cronet.setUserAgent(config.userAgent, partial: true)
        var cacheType = CRNHttpCacheType.disabled
        switch config.httpCacheMode {
        case .disabled:
            cacheType = .disabled
            break
        case .disk:
            cacheType = .disk
            break
        case .memory:
            cacheType = .memory
            break
        }
        Cronet.setHttpCacheType(cacheType)
        Cronet.start()
        Cronet.registerHttpProtocolHandler()
        Cronet.setRequestFilterBlock { request in
            guard let host = request?.url?.host else {
                return false
            }
            guard let whiteList = config.interceptHostWhiteList else {
                return false
            }
            if (whiteList.contains(where: { host.hasSuffix($0) })) {
                return true
            }
            return false
        }
        isStarted = true
    }
    
}
