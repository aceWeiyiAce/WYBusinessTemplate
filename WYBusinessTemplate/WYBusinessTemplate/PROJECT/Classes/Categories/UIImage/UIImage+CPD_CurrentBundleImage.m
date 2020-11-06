//
//  UIImage+CPD_CurrentBundleImage.m
//  PROJECT
//
//  Created by CREATEDBYAUTHOR on YEAR/MONTH/DAY.
//  Copyright © YEAR年 CUSTOMORGANIZATIONNAME. All rights reserved.
//

#import "UIImage+CPD_CurrentBundleImage.h"

@implementation UIImage (CPD_CurrentBundleImage)

+ (UIImage *)funccpd_imageNamed:(NSString *)name
{
    UIImage *image = [self imageNamed:name inBundle:[NSBundle funccpd_currentBundle] compatibleWithTraitCollection:nil];
    if (image == nil) {
        NSLog(@"============== %@ 图片丢失！=================", name);
    }
    return image;
}

@end
