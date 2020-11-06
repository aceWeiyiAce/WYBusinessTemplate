//
//  CPDExampleAboutViewController.m
//  PROJECT
//
//  Created by CREATEDBYAUTHOR on YEAR/MONTH/DAY.
//  Copyright © YEAR年 CUSTOMORGANIZATIONNAME. All rights reserved.
//

#import "CPDExampleAboutViewController.h"

@interface CPDExampleAboutViewController ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UILabel *copyrightLabel;

@end

@implementation CPDExampleAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.title = [NSString stringWithFormat:@"关于%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]];
    [self.view addSubview:self.iconView];
    [self.view addSubview:self.infoLabel];
    [self.view addSubview:self.copyrightLabel];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.iconView.frame = CGRectMake((self.view.bounds.size.width - 60.f) / 2, (self.view.bounds.size.width - 60.f) / 2, 60.f, 60.f);
    self.infoLabel.frame = CGRectMake(10.f, CGRectGetMaxY(self.iconView.frame) + 10.f, self.view.bounds.size.width - 20.f, self.infoLabel.font.lineHeight);
    self.copyrightLabel.frame = CGRectMake(10.f, self.view.bounds.size.height - self.copyrightLabel.font.lineHeight - 10.f, self.view.bounds.size.width - 20.f, self.copyrightLabel.font.lineHeight);
}

#pragma mark - Properties
- (UIImageView *)iconView
{
    if (_iconView == nil) {
        NSDictionary *infoPlist = [[NSBundle mainBundle] infoDictionary];
        NSString *icon = [[infoPlist valueForKeyPath:@"CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] lastObject];
        _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
        _iconView.layer.cornerRadius = 5.f;
        _iconView.layer.masksToBounds = YES;
    }
    return _iconView;
}

- (UILabel *)infoLabel
{
    if (_infoLabel == nil) {
        _infoLabel = [[UILabel alloc] init];
        _infoLabel.textColor = [UIColor colorWithWhite:0 alpha:0.8f];
        _infoLabel.font = [UIFont systemFontOfSize:15.f];
        _infoLabel.textAlignment = NSTextAlignmentCenter;
        _infoLabel.text = [NSString stringWithFormat:@"%@ %@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    }
    return _infoLabel;
}

- (UILabel *)copyrightLabel
{
    if (_copyrightLabel == nil) {
        _copyrightLabel = [[UILabel alloc] init];
        _copyrightLabel.textColor = [UIColor colorWithWhite:0 alpha:0.6f];
        _copyrightLabel.font = [UIFont systemFontOfSize:13.f];
        _copyrightLabel.textAlignment = NSTextAlignmentCenter;
        _copyrightLabel.text = @"Copyright © YEAR年 CUSTOMORGANIZATIONNAME. All rights reserved.";
    }
    return _copyrightLabel;
}

@end
