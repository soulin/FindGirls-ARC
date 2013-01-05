//
//  ZJTHomeViewController.h
//  FindGirls-ARC
//
//  Created by Patrick.Z on 12/25/12.
//  Copyright (c) 2012 ZJTSoft,Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADBannerView.h"
#import "AFHTTPClient.h"
#import "ASIFormDataRequest.h"
#import "UIImageView+WebCache.h"
#import "JSON.h"
#import "EGORefreshTableHeaderView.h"

@interface ZJTHomeViewController : UIViewController<ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate,GADBannerViewDelegate,EGORefreshTableHeaderDelegate>
{    
	EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL _reloading;
}
@property (strong, nonatomic) GADBannerView *bannerView;

@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) NSMutableArray *girlsArr;//ZJTGirl

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
