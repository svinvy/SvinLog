//
//  ViewController.m
//  SvinLog
//
//  Created by GJP on 2018/3/23.
//  Copyright © 2018年 svinvy.lnc. All rights reserved.
//

#import "ViewController.h"
#import "SLSandBoxLog.h"
#import "SLTextViewController.h"

@interface ViewController ()
{
    SLSandBoxLog *_sandBoxLog;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(logSomething:) userInfo:nil repeats:YES];
    
    _sandBoxLog = [[SLSandBoxLog alloc] initWithFilePath:nil andName:nil];
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    SLTextViewController *ctl = [[SLTextViewController alloc] init];
    [self presentViewController:ctl animated:YES completion:nil];
}
- (void)logSomething:(NSTimer*)timer
{
    static int index = 0;
    index++;
    NSLog(@"[SvinLog]:Loging ViewController by index %d",index);
}
@end
