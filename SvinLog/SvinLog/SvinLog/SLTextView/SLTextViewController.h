//
//  SLTextViewController.h
//  SvinLog
//
//  Created by GJP on 2018/3/23.
//  Affer log display,search and select
//  Copyright © 2018年 svinvy.lnc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SLTextView.h"

@interface SLTextViewController : UIViewController

@property(nonatomic,copy)NSString                   *logRegex;/* only display which confirm to this regex if not nil */
@property(nonatomic,strong,readonly)SLTextView *logView;
@property(nonatomic,strong,readonly)UISearchBar*searchBar;
@end
