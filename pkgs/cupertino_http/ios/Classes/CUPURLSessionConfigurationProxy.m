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
    NSURLSessionConfiguration *configuration =  [NSURLSessionConfiguration defaultSessionConfiguration];
    if (CUPCronet.isCronetStarted) {
        [Cronet installIntoSessionConfiguration:configuration];
    }
    return configuration;
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
