//
//  ScanHelper.h
//  ScanHelperDemo
//
//  Created by zhengrui on 17/2/14.
//  Copyright © 2017年 zhengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ScanStyleDelegate <NSObject>

-(void)pushScanController:(UIViewController *)controller;

@end

@interface ScanHelper : NSObject

- (void)goScanWithStyle:(NSString *)style;

+ (instancetype)shareInstance;

@property(nonatomic,assign) id<ScanStyleDelegate>        delegate;
@end
