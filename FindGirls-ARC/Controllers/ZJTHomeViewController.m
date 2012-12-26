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
#import "ZJTGirl.h"

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
    [self loadData];
}

-(void)loadData
{    
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:[NSURL URLWithString:@"http://relaxfindgirl.sinaapp.com/Mobile/MeiZiTu/randomList"]];
    request.delegate = self;
    [request startAsynchronous];
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
        [_girlsArr addObject:girl];
    }
    
    [_table reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _girlsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"home cell";
    ZJTHomeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"ZJTHomeTableCell" owner:self options:nil];
        cell = [nibs objectAtIndex:0];
        [cell setup];
    }
    
    ZJTGirl *girl = [_girlsArr objectAtIndex:indexPath.row];
    [cell.contentImageView setImageWithURL:girl.imageURL placeholderImage:nil options:SDWebImageProgressiveDownload];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 286;
}

@end