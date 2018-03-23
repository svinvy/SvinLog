//
//  SLTextViewController.m
//  SvinLog
//
//  Created by GJP on 2018/3/23.
//  Copyright © 2018年 svinvy.lnc. All rights reserved.
//

#import "SLTextViewController.h"
#import "SLRedirector.h"
#import <objc/runtime.h>

@interface SLTextViewController ()<SLRedirectorObserver,UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_logmessages,*_resultMessages;
    UITableView       *_resultTable;
}
@end

@implementation SLTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _logmessages = @[].mutableCopy;
     _resultMessages = @[].mutableCopy;
    
    [self.view addSubview:_searchBar = [self _getSearchBar]];
    _logView = [SLTextView view];
    _logView.frame = CGRectMake(0, CGRectGetMaxY(_searchBar.frame), self.view.bounds.size.width, self.view.bounds.size.height-_searchBar.bounds.size.height);
    [self.view addSubview:_logView];
    
    [[SLRedirector getInstance] registerObserver:self];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    // Do any additional setup after loading the view.
}
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [_logmessages removeAllObjects];
}
#pragma mark - SLRedirectorObserver
-(void)redirectingTheLog:(NSString *)message
{
    if (_logRegex&&[message rangeOfString:_logRegex options:NSRegularExpressionSearch].location==NSNotFound) {
        return;
    }
    [_logmessages addObject:message];
    [_logView setText:[NSString stringWithFormat:@"%@%@",_logView.text,message]];
}
#pragma mark - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    if(_resultMessages.count){[_resultMessages removeAllObjects];}
   BOOL portrait = (self.view.bounds.size.height>self.view.bounds.size.width);
    for (NSString*msg in _logmessages) {
        if ([msg rangeOfString:searchBar.text options:NSRegularExpressionSearch].location!=NSNotFound) {
            CGSize size = [msg boundingRectWithSize:CGSizeMake((portrait?self.view.bounds.size.width:self.view.bounds.size.height)-60, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:NULL].size;
            objc_setAssociatedObject(msg, @selector(tableView:heightForRowAtIndexPath:), @(size.height), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            [_resultMessages addObject:msg];
        }else{/* continue */}
    }
    if (!_resultTable) {
        CGFloat margin = 30;
        _resultTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width-margin*2, self.view.bounds.size.height-margin*2)];
        _resultTable.center = self.view.center;
        _resultTable.dataSource = self;
        _resultTable.backgroundColor = [UIColor clearColor];
        _resultTable.delegate = self;
        _resultTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    if(![self.view.subviews containsObject:_resultTable]){
        [self.view addSubview:_resultTable];
    }else{[_resultTable reloadData];}
    if(!_resultMessages.count){[_resultTable removeFromSuperview];}
}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _resultMessages.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifer = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer];
    if (!cell) {
        cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor orangeColor];
        cell.backgroundColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.numberOfLines = 0;
    }
    cell.textLabel.text = _resultMessages[indexPath.row];
    return cell;
}
#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString*msg = _resultMessages[indexPath.row];
    NSNumber*height = objc_getAssociatedObject(msg, _cmd);
    return height?height.floatValue:44;
}
#pragma mark - Notification
- (void)deviceOrientationChanged:(NSNotification*)notice
{
    //change textView frame
    _searchBar.frame = CGRectMake(0, 0, self.view.bounds.size.width, 35);
    _logView.frame = CGRectMake(0, CGRectGetMaxY(_searchBar.frame), self.view.bounds.size.width, self.view.bounds.size.height-_searchBar.bounds.size.height);
    if (!_resultTable.hidden) {
         CGFloat margin = 30;
        _resultTable.frame = CGRectMake(0, 0,self.view.bounds.size.width-margin*2, self.view.bounds.size.height-margin*2);
        _resultTable.center = self.view.center;
    }
}
#pragma mark - Getters
- (UISearchBar*)_getSearchBar
{
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 35)];
    searchBar.delegate = self;
    searchBar.tintColor = [UIColor orangeColor];
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    UITextField *textField = [searchBar valueForKey:@"searchBarTextField"];
    if(textField){[textField setTextColor:UIColor.whiteColor];}
    return searchBar;
}
@end
