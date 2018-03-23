//
//  SLSandBoxLog.m
//  SvinLog
//
//  Created by GJP on 2018/3/23.
//  Copyright © 2018年 svinvy.lnc. All rights reserved.
//

#import "SLSandBoxLog.h"
#import "SLRedirector.h"
@interface SLSandBoxLog()<SLRedirectorObserver>
{
    dispatch_queue_t    _sandBoxQueue;
}
@end
@implementation SLSandBoxLog
{
    NSString    *_logPath;
}
-(instancetype)initWithFilePath:(NSString *)path andName:(NSString *)name
{
    if (self = [super init]) {
        _logPath= path?:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) firstObject];
        _logPath = [_logPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.log",name?name:@"svin"]];
        NSLog(@"[SLSandBoxLog]:%@",_logPath);
        
        /* check and remote the file if exist,we only want the log for current process  */
        if ([[NSFileManager defaultManager] fileExistsAtPath:_logPath]) {
            [[NSFileManager defaultManager] removeItemAtPath:_logPath error:nil];
        }
        [[NSFileManager defaultManager] createFileAtPath:_logPath contents:nil attributes:nil];
        
        _sandBoxQueue = dispatch_queue_create("SLSandBoxLogSerialQueue", NULL);
        [[SLRedirector getInstance] registerObserver:self];
    }return self;
}
#pragma mark - SLRedirectorObserver
-(void)redirectingTheLog:(NSString *)message
{
    dispatch_async(_sandBoxQueue,
    ^{
        NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:_logPath];
        [handle seekToEndOfFile];
        [handle writeData:[message dataUsingEncoding:NSUTF8StringEncoding]];
        [handle synchronizeFile];
    });
}
@end
