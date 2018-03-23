//
//  SLRedirectorObserver.h
//  SvinLog
//
//  Created by GJP on 2018/3/23.
//  Copyright © 2018年 svinvy.lnc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SLRedirectorObserver <NSObject>

- (void)redirectingTheLog:(NSString*)message;
@end
