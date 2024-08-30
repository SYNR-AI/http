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
    public var experimentalOptions: String?
    
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
        Cronet.setNetworkThreadPriority(1.0)
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
       
       
       do {
//           let options = ["AsyncDNS": ["enable":true], "StaleDNS": ["enable": true, "persist_to_disk":true, "delay_ms":0, "max_expired_time_ms":86400000, "max_stale_uses":1000, "allow_other_network":true]]
//           let optionsJsonData = try JSONSerialization.data(withJSONObject: options, options: [])
//           let optionJsonStr = String(data: optionsJsonData, encoding: .utf8)
           //         Cronet.setExperimentalOptions("{\"AsyncDNS\":{\"enable\":true},\"StaleDNS\":{\"delay_ms\":0,\"enable\":true,\"persist_to_disk\":true,\"max_stale_uses\":1000,\"max_expired_time_ms\":0,\"allow_other_network\":true}}")
           if (config.experimentalOptions != nil) {
               let options: String = config.experimentalOptions ?? ""
                   print("CUPCronet dnsOptions =" + options)
                   Cronet.setExperimentalOptions(options)
           }
          
       }catch  {
            print(error)
       }
        Cronet.start()
//        Cronet.setHostResolverRulesForTesting("MAP s1-resource-dev.museland.ai 13.107.246.73:443")

//       Cronet.startNetLog(toFile: "cronet_1.log" , logBytes: false)
//       Cronet.registerHttpProtocolHandler()
//       Cronet.setRequestFilterBlock { request in
//           guard let host = request?.url?.host else {
//               return false
//           }
//           guard let whiteList = config.interceptHostWhiteList else {
//               return false
//           }
//           if (whiteList.contains(where: { host.hasSuffix($0) })) {
//               return true
//           }
//           return false
//       }
        isStarted = true
    }
    
}
