//
//  CPDExampleCellModel.m
//  PROJECT
//
//  Created by CREATEDBYAUTHOR on YEAR/MONTH/DAY.
//  Copyright © YEAR年 CUSTOMORGANIZATIONNAME. All rights reserved.
//

#import "CPDExampleCellModel.h"

@implementation CPDExampleCellModel

- (instancetype)initWithExampleName:(NSString *)exampleName
{
    if (self = [self init]) {
        self.exampleName = exampleName;
    }
    return self;
}

+ (instancetype)exampleWithExampleName:(NSString *)exampleName
{
    return [[self alloc] initWithExampleName:exampleName];
}

@end
