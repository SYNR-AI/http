//
//  CUPURLSessionConfigurationProxy.h
//  cupertino_http
//
//  Created by xp on 2024/8/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CUPURLSessionConfigurationProxy : NSObject

@property (class, readonly, strong) NSURLSessionConfiguration *cupDefaultSessionConfiguration;
@property (class, readonly, strong) NSURLSessionConfiguration *cupEphemeralSessionConfiguration;

+ (NSURLSessionConfiguration *)cupBackgroundSessionConfigurationWithIdentifier:(NSString *)identifier API_AVAILABLE(macos(10.10), ios(8.0), watchos(2.0), tvos(9.0));

@end

NS_ASSUME_NONNULL_END
