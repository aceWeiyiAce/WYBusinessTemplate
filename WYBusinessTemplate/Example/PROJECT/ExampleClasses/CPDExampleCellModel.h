//
//  CPDExampleCellModel.h
//  PROJECT
//
//  Created by CREATEDBYAUTHOR on YEAR/MONTH/DAY.
//  Copyright © YEAR年 CUSTOMORGANIZATIONNAME. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPDExampleCellModel : NSObject

///例子标题
@property (nonatomic, strong) NSString *exampleName;
///目标控制器
@property (nonatomic, strong) Class destinationViewController;
///点击时的操作
@property (nonatomic, copy) void (^clickBlock)(void);

- (instancetype)initWithExampleName:(NSString *)exampleName;
+ (instancetype)exampleWithExampleName:(NSString *)exampleName;

@end
