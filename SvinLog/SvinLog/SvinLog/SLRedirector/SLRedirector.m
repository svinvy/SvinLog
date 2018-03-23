//
//  SLRedirector.m
//  SvinLog
//
//  Created by GJP on 2018/3/23.
//  Copyright © 2018年 svinvy.lnc. All rights reserved.
//

#import "SLRedirector.h"

@implementation SLRedirector
{
    NSPointerArray *_observers;
}
+(SLRedirector *)getInstance
{
    static dispatch_once_t onceToken;
    static SLRedirector *redirector = nil;
    dispatch_once(&onceToken, ^{
        redirector = [[SLRedirector alloc] init];
        [redirector instanceInits];
    });
    return redirector;
}
#pragma mark - Interface
-(void)registerObserver:(id<SLRedirectorObserver>)observer
{
    if (observer&&![_observers.allObjects containsObject:observer]) {
        [_observers addPointer:(__bridge void * _Nullable)(observer)];
    }
}
#pragma mark - Notifications
- (void)redirectNotification:(NSNotification*)notice
{
    NSData*data = [[notice userInfo] objectForKey:NSFileHandleNotificationDataItem];
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    for (NSObject<SLRedirectorObserver>*observer in _observers.allObjects) {
        [observer redirectingTheLog:str];
    }
    [[notice object] readInBackgroundAndNotify];
}
#pragma mark - Privates
- (void)_redirectSTD:(int)fd
{
    NSPipe *pipe = [NSPipe pipe];
    NSFileHandle *pipeReadHandle = [pipe fileHandleForReading];
    dup2([[pipe fileHandleForWriting] fileDescriptor], fd);
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(redirectNotification:) name:NSFileHandleReadCompletionNotification object:pipeReadHandle];
    [pipeReadHandle readInBackgroundAndNotify];
}
#pragma mark - LifeCycle
- (void)instanceInits
{
    _observers = [NSPointerArray weakObjectsPointerArray];
    
    /* redirects begin */
    [self _redirectSTD:STDOUT_FILENO];
    [self _redirectSTD:STDERR_FILENO];
}
@end
