//
//  Mediasoupclient.h
//  mediasoup-client-ios
//
//  Created by Ethan.
//  Copyright © 2019 Ethan. All rights reserved.
//
#import <Foundation/Foundation.h>

#ifndef Mediasoupclient_h
#define Mediasoupclient_h

__attribute__((visibility("default")))
@interface Mediasoupclient : NSObject {}
/*!
    @returns The libmediasoupclient version
 */
+(NSString *)version;
@end

#endif /* Mediasoupclient_h */
