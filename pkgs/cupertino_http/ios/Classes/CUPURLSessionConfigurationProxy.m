//
//  CUPURLSessionConfigurationProxy.m
//  cupertino_http
//
//  Created by xp on 2024/8/5.
//

#import "CUPURLSessionConfigurationProxy.h"
#import "cupertino_http/cupertino_http-Swift.h"
@import Cronet;

@implementation CUPURLSessionConfigurationProxy


+ (NSURLSessionConfiguration *)cupDefaultSessionConfiguration {
    NSURLSessionConfiguration  *cupDefaultSessionConfiguration =  [NSURLSessionConfiguration defaultSessionConfiguration];
    if (CUPCronet.isCronetStarted) {
        [Cronet installIntoSessionConfiguration:cupDefaultSessionConfiguration];
    }
    return cupDefaultSessionConfiguration;
}

+ (NSURLSessionConfiguration *)cupEphemeralSessionConfiguration {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
    if (CUPCronet.isCronetStarted) {
        [Cronet installIntoSessionConfiguration:configuration];
    }
    return configuration;
}

+ (NSURLSessionConfiguration *)cupBackgroundSessionConfigurationWithIdentifier:(NSString *)identifier {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:identifier];
    if (CUPCronet.isCronetStarted) {
        [Cronet installIntoSessionConfiguration:configuration];
    }
    return configuration;
}

@end
