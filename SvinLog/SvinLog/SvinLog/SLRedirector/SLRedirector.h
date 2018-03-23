//
//  SLRedirector.h
//  SvinLog
//
//  All logs source are from this class,which will retranfer the logs from stdout and stderr.
//  Not thread safe.Youd should register observer in main thread
//  Created by GJP on 2018/3/23.
//  Copyright © 2018年 svinvy.lnc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SLRedirectorObserver.h"

@interface SLRedirector : NSObject

+ (SLRedirector*)getInstance;

- (void)registerObserver:(id<SLRedirectorObserver>)observer/* got notice when redirecting the log */;
@end
