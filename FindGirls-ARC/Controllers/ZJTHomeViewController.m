//
//  ZJTHomeViewController.m
//  FindGirls-ARC
//
//  Created by Patrick.Z on 12/25/12.
//  Copyright (c) 2012 ZJTSoft,Inc. All rights reserved.
//

#import "ZJTHomeViewController.h"
#import "AFJSONRequestOperation.h"
#import "ZJTHomeTableCell.h"
#import "ZJTLoadMoreCell.h"
#import "ZJTGirl.h"

enum
{
    eTableRowImages = 0,
    eTableRowLoadMore,
    eTableRowCount
};

@interface ZJTHomeViewController ()

@end

@implementation ZJTHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Find Girls", nil);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.backgroundColor = [UIColor colorWithRed:245.0/255.0
                                                       green:245.0/255.0
                                                        blue:241.0/255.0
                                                       alpha:1.0];
    if ([ZJTConfigration sharedConfigration].hasAD) {
        CGRect frame = _table.frame;
        frame.size.height = self.view.bounds.size.height - 50;
        _table.frame = frame;
        [self addAD];
    }
    else
    {
        CGRect frame = _table.frame;
        frame.size.height = self.view.bounds.size.height;
        _table.frame = frame;
    }
}

-(void)loadData
{    
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:@"http://relaxfindgirl.sinaapp.com/Mobile/MeiZiTu/randomList"]];
    request.delegate = self;
    [request startAsynchronous];
}

-(void)addAD
{    
    _bannerView = [[GADBannerView alloc]init];
    [_bannerView setDelegate:self];
    CGFloat originY = _table.frame.origin.y + _table.frame.size.height;
    [_bannerView setFrame:CGRectMake(0, originY, 320, 50)];
    
    _bannerView.adUnitID = MY_BANNER_UNIT_ID;
    
    _bannerView.rootViewController = self;
    _bannerView.backgroundColor = [UIColor colorWithRed:245.0/255.0
                                                  green:245.0/255.0
                                                   blue:241.0/255.0
                                                  alpha:1.0];
    [self.view addSubview:_bannerView];
    
    [_bannerView loadRequest:[GADRequest request]];
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    NSString *response = [request responseString];
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSDictionary *result = [parser objectWithString:response];
    parser = nil;
    NSDictionary *data = [result objectForKey:@"data"];
    NSArray *girls = [data objectForKey:@"girls"];
        
    if (_girlsArr == nil) {
        _girlsArr = [NSMutableArray new];
    }
    for (NSDictionary *eachDict in girls) {
        ZJTGirl *girl = [[ZJTGirl alloc] initWithDictionary:eachDict];
        if ([girl.imageURL.absoluteString hasSuffix:@".gif"] ||
            [girl.imageURL.absoluteString hasSuffix:@".GIF"])
        {
            //gif
        }
        else {
            [_girlsArr addObject:girl];
        }
    }
    
    [_table reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [[SDImageCache sharedImageCache] clearMemory];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _girlsArr.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //images
    if (indexPath.row != _girlsArr.count) {
        static NSString *cellId = @"home cell";
        ZJTHomeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"ZJTHomeTableCell" owner:self options:nil];
            cell = [nibs objectAtIndex:0];
            [cell setup];
        }
        
        ZJTGirl *girl = nil;
        if (_girlsArr && indexPath.row < _girlsArr.count) {
            girl = [_girlsArr objectAtIndex:indexPath.row];
        }
        [cell updateWithGirl:girl index:indexPath.row];
        
        [cell.contentImageView setImageWithURL:girl.imageURL
                                          size:CGSizeZero//[girl sizeForWidth:300]
                              placeholderImage:nil
                                       options:SDWebImageRetryFailed
                                      progress:^(NSUInteger receivedSize, long long expectedSize){
                                          NSLog(@"%f",((float)receivedSize / (float)expectedSize));
                                      }
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType){
                                         NSLog(@"%@",NSStringFromCGSize(image.size));
                                         NSLog(@"wid = %f hei = %f",girl.width,girl.height);
                                         NSLog(@"cell.contentImageView = %@",NSStringFromCGRect(cell.contentImageView.frame));
                                         NSLog(@"[girl heightForWidth:280] = %f",[girl heightForWidth:280]);
                                         
                                     }];
        return cell;
    }
    
    //load more
    else
    {
        static NSString *cellId = @"load more cell";
        ZJTLoadMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"ZJTLoadMoreCell" owner:self options:nil];
            cell = [nibs objectAtIndex:0];
        }
        [cell setup];
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZJTGirl *girl = nil;
    if (_girlsArr && indexPath.row < _girlsArr.count) {
        girl = [_girlsArr objectAtIndex:indexPath.row];
    }
    NSLog(@"heightForWidth %f",[girl heightForWidth:280]);
    return [girl heightForWidth:280] + 72;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _girlsArr.count) {
        [self loadData];
//        ZJTLoadMoreCell *loadCell = (ZJTLoadMoreCell*)cell;
//        [loadCell setup];
    }
}

@end