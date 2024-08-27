//
//  CUPCronetProxy.h
//  cupertino_http
//
//  Created by xp on 2024/8/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CUPCronetProxy : NSObject

+ (void)setInterceptHostWhiteList: (NSArray<NSString *> *)whiteList;

@end

NS_ASSUME_NONNULL_END
