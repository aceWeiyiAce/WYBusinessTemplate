//
//  NSBundle+CPD_CurrentBundle.m
//  PROJECT
//
//  Created by CREATEDBYAUTHOR on YEAR/MONTH/DAY.
//  Copyright © YEAR年 CUSTOMORGANIZATIONNAME. All rights reserved.
//

#import "NSBundle+CPD_CurrentBundle.h"

@interface CPDCurrentBundlePrivate : NSObject
@end

@implementation CPDCurrentBundlePrivate
@end

static NSBundle *_funccpdResources_bundle = nil;
@implementation NSBundle (CPD_CurrentBundle)

+ (NSBundle *)funccpd_currentBundle
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _funccpdResources_bundle = [NSBundle bundleForClass:[CPDCurrentBundlePrivate class]];
    });
    return _funccpdResources_bundle;
}

@end
