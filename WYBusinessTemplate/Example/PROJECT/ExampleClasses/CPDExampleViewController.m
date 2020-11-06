//
//  CPDExampleViewController.m
//  PROJECT
//
//  Created by CREATEDBYAUTHOR on YEAR/MONTH/DAY.
//  Copyright © YEAR年 CUSTOMORGANIZATIONNAME. All rights reserved.
//

#import "CPDExampleViewController.h"
#import "CPDExampleCellModel.h"

static NSString *reusableExampleCellIdentifier = @"MIAExampleCell";

@interface CPDExampleViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *exampleCellModels;

@end

@implementation CPDExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"PROJECT";
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.exampleCellModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableExampleCellIdentifier forIndexPath:indexPath];
    CPDExampleCellModel *example = [self.exampleCellModels objectAtIndex:indexPath.row];
    cell.textLabel.text = example.exampleName;
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CPDExampleCellModel *example = [self.exampleCellModels objectAtIndex:indexPath.row];
    if (example.destinationViewController) {
        UIViewController *destinationVc = [[[example.destinationViewController class] alloc] init];
        destinationVc.title = example.exampleName;
        [self.navigationController pushViewController:destinationVc animated:YES];
    } else if (example.clickBlock) {
        example.clickBlock();
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Properties
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reusableExampleCellIdentifier];
    }
    return _tableView;
}

- (NSMutableArray *)exampleCellModels
{
    if (_exampleCellModels == nil) {
        _exampleCellModels = [NSMutableArray array];
        
        CPDExampleCellModel *aboutExample = [CPDExampleCellModel exampleWithExampleName:@"关于 PROJECT"];
        aboutExample.destinationViewController = NSClassFromString(@"CPDExampleAboutViewController");
        [_exampleCellModels addObject:aboutExample];
        
    }
    return _exampleCellModels;
}

@end
