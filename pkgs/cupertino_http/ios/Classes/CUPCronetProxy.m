//
//  CUPCronetProxy.m
//  cupertino_http
//
//  Created by xp on 2024/8/27.
//

#import "CUPCronetProxy.h"
@import Cronet;

@implementation CUPCronetProxy

+ (void)setInterceptHostWhiteList: (NSArray<NSString *> *)whiteList {
    [Cronet setRequestFilterBlock:^BOOL(NSURLRequest *request) {
        if (request.URL.host == NULL) {
            return NO;
        }
        for(NSString *whiteHost in whiteList) {
            if ([request.URL.host hasSuffix:whiteHost]) {
                return YES;
            }
        }
        return NO;
    }];
}

@end
