//
//  ZJTHomeViewController.m
//  FindGirls-ARC
//
//  Created by Patrick.Z on 12/25/12.
//  Copyright (c) 2012 ZJTSoft,Inc. All rights reserved.
//

#import "ZJTHomeViewController.h"
#import "AFJSONRequestOperation.h"
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
    self.navigationController.navigationBar.titleTextAttributes = Nav_TitleTextAttributes;
    _table.scrollsToTop = YES;
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.backgroundColor = [UIColor colorWithRed:245.0/255.0
                                                       green:245.0/255.0
                                                        blue:241.0/255.0
                                                       alpha:1.0];
    
    [self setupPullDownRefreshView];
    [self setupBarButtons];
    
    //ADs
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

-(void)setupBarButtons
{
    UIButton *nNavBtn = [[UIButton alloc] initWithFrame:NAVIGATION_BAR_BTN_RECT];
    [nNavBtn setImage:[UIImage imageNamed:@"refresh_normal.png"] forState:UIControlStateNormal];
    [nNavBtn addTarget:self action:@selector(reloadTableViewDataSource) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *nBtnItem = [[UIBarButtonItem alloc] initWithCustomView:nNavBtn];
    self.navigationItem.rightBarButtonItem = nBtnItem;
}

-(void)setupPullDownRefreshView
{
    
	if (_refreshHeaderView == nil) {
		
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - _table.bounds.size.height, self.view.frame.size.width, _table.bounds.size.height) table:_table];
		view.delegate = self;
		[_table addSubview:view];
		_refreshHeaderView = view;		
	}
	
	//  update the last update date
	[_refreshHeaderView refreshLastUpdatedDate];
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
    [self doneLoadingTableViewData];
    [self hideProgressHUD:YES];
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
            cell.delegate = self;
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
                                          float progress = ((float)receivedSize / (float)expectedSize);
                                          cell.progress = progress;
                                      }
                                     completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType){
                                         
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
    return [girl heightForWidth:280] + 72;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == _girlsArr.count) {
        [self loadData];
    }
}

-(void)homeCell:(ZJTHomeTableCell*)cell
     imageTaped:(UITapGestureRecognizer*)tap
{
    _tapImage = cell.contentImageView.image;
    if (_tapImage == nil) {
        return;
    }
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    UINavigationControllerForiOS6 *nc = [[UINavigationControllerForiOS6 alloc] initWithRootViewController:browser];
    browser.displayActionButton = YES;
    
    nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//    [self.navigationController pushViewController:browser animated:YES];
    [self presentModalViewController:nc animated:YES];
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return 1;
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    return [[MWPhoto alloc] initWithImage:_tapImage];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	_reloading = YES;
    [self showProgressHUDWithMessage:[NSString stringWithFormat:@"%@\u2026" , NSLocalizedString(@"Updating", @"Displayed with ellipsis as 'Copying...' when an item is in the process of being copied")]];
    
    [_table beginUpdates];
    [_table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                  atScrollPosition:UITableViewScrollPositionTop
                          animated:YES];
    [_table endUpdates];
    
    [self performSelector:@selector(delayLoad) withObject:nil afterDelay:.1];
}

-(void)delayLoad
{    
    if (_girlsArr) {
        [_girlsArr removeAllObjects];
    }
	[self loadData];
}

- (void)doneLoadingTableViewData{
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:_table];	
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{	
	[self reloadTableViewDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return NO;
}

-(BOOL)shouldAutorotate
{
    return NO;
}

#pragma mark - MBProgressHUD

- (MBProgressHUD *)progressHUD {
    if (!_progressHUD) {
        _progressHUD = [[MBProgressHUD alloc] initWithView:self.view];
        _progressHUD.minSize = CGSizeMake(120, 120);
        _progressHUD.minShowTime = 1;
        // The sample image is based on the
        // work by: http://www.pixelpressicons.com
        // licence: http://creativecommons.org/licenses/by/2.5/ca/
        self.progressHUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MWPhotoBrowser.bundle/images/Checkmark.png"]];
        [self.view addSubview:_progressHUD];
    }
    return _progressHUD;
}

- (void)showProgressHUDWithMessage:(NSString *)message {
    self.progressHUD.labelText = message;
    self.progressHUD.mode = MBProgressHUDModeIndeterminate;
    [self.progressHUD show:YES];
    self.navigationController.navigationBar.userInteractionEnabled = NO;
}

- (void)hideProgressHUD:(BOOL)animated {
    [self.progressHUD hide:animated];
    self.navigationController.navigationBar.userInteractionEnabled = YES;
}

- (void)showProgressHUDCompleteMessage:(NSString *)message {
    if (message) {
        if (self.progressHUD.isHidden) [self.progressHUD show:YES];
        self.progressHUD.labelText = message;
        self.progressHUD.mode = MBProgressHUDModeCustomView;
        [self.progressHUD hide:YES afterDelay:1.5];
    } else {
        [self.progressHUD hide:YES];
    }
    self.navigationController.navigationBar.userInteractionEnabled = YES;
}


@end