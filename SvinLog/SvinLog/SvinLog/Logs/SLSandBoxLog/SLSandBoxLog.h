//
//  SLSandBoxLog.h
//  SvinLog
//
//  Will save the logs in the sandbox of a .log file.
//  Created by GJP on 2018/3/23.
//  Copyright © 2018年 svinvy.lnc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLSandBoxLog : NSObject
/**
 **      @param  path        will set under home directory if nil
 **      @param  name       will set "svin" if nil
 **/
- (instancetype)initWithFilePath:(NSString*)path andName:(NSString*)name NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@property(nonatomic,copy)NSString  *regex/* will only save which confirm to this regex if not nil */;
@end
