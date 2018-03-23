//
//  SLTextView.m
//  SvinLog
//
//  Created by GJP on 2018/3/23.
//  Copyright © 2018年 svinvy.lnc. All rights reserved.
//

#import "SLTextView.h"

@implementation SLTextView

+(SLTextView *)view
{
    SLTextView *view = [[SLTextView alloc] init];
    view.backgroundColor = [UIColor blackColor];
    view.textColor = [UIColor whiteColor];
    view.font = [UIFont systemFontOfSize:14];
    view.editable = NO;
    return view;
}
#pragma mark - Override
-(void)setText:(NSString *)text
{
    [super setText:text];
    [self scrollRangeToVisible:NSMakeRange(self.text.length-1, 1)];
}
@end
