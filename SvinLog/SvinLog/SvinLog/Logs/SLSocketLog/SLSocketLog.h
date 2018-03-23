//
//  SLSocketLog.h
//  SvinLog
//
//  Created by GJP on 2018/3/23.
//  WIll connect to the server and upload the log
//  Copyright © 2018年 svinvy.lnc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLSocketLog : NSObject

-(instancetype)initWithServerIP:(NSString*)ip port:(int)port NS_DESIGNATED_INITIALIZER;
-(instancetype)init NS_UNAVAILABLE;
@end
