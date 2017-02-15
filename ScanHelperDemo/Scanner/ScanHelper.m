//
//  ScanHelper.m
//  ScanHelperDemo
//
//  Created by zhengrui on 17/2/14.
//  Copyright © 2017年 zhengrui. All rights reserved.
//

#import "ScanHelper.h"
#import "ScanQRViewController.h"
#import "MyQRViewController.h"
#import "LBXScanView.h"
#import <objc/message.h>
#import "LBXScanResult.h"
#import "LBXScanWrapper.h"

@implementation ScanHelper

static ScanHelper *scanHelper;

+ (instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        scanHelper = [[self alloc] init];
    });
    return scanHelper;
}

- (void)goScanWithStyle:(NSString *)style{
    
    if (![self cameraPemission])
    {
        [self showError:@"没有摄像机权限"];
        
        return;
    }
    
    NSString *methodName = style;
    
    SEL normalSelector = NSSelectorFromString(methodName);
    if ([self respondsToSelector:normalSelector]) {
        
        ((void (*)(id, SEL))objc_msgSend)(self, normalSelector);
    }
    
}

- (BOOL)cameraPemission
{
    
    BOOL isHavePemission = NO;
    if ([AVCaptureDevice respondsToSelector:@selector(authorizationStatusForMediaType:)])
    {
        AVAuthorizationStatus permission =
        [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        switch (permission) {
            case AVAuthorizationStatusAuthorized:
                isHavePemission = YES;
                break;
            case AVAuthorizationStatusDenied:
            case AVAuthorizationStatusRestricted:
                break;
            case AVAuthorizationStatusNotDetermined:
                isHavePemission = YES;
                break;
        }
    }
    
    return isHavePemission;
}

- (void)showError:(NSString*)str
{
    [LBXAlertAction showAlertWithTitle:@"提示" msg:str chooseBlock:nil buttonsStatement:@"知道了",nil];
}

#pragma mark -模仿qq界面
- (void)qqStyle
{
    //设置扫码区域参数设置
    
    //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;
    
    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;
    
    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;
    
    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;
    
    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;
    
    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    
    //SubLBXScanViewController继承自LBXScanViewController
    //添加一些扫码或相册结果处理
    [self openScanVCWithStyle:style];
}

#pragma mark --模仿支付宝
- (void)ZhiFuBaoStyle
{
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    style.centerUpOffset = 60;
    style.xScanRetangleOffset = 30;
    
    if ([UIScreen mainScreen].bounds.size.height <= 480 )
    {
        //3.5inch 显示的扫码缩小
        style.centerUpOffset = 40;
        style.xScanRetangleOffset = 20;
    }
    
    
    style.alpa_notRecoginitonArea = 0.6;
    
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
    style.photoframeLineW = 2.0;
    style.photoframeAngleW = 16;
    style.photoframeAngleH = 16;
    
    style.isNeedShowRetangle = NO;
    
    style.anmiationStyle = LBXScanViewAnimationStyle_NetGrid;
    
    //使用的支付宝里面网格图片
    UIImage *imgFullNet = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_full_net"];
    
    
    style.animationImage = imgFullNet;
    
    
    [self openScanVCWithStyle:style];
}



#pragma mark -无边框，内嵌4个角
- (void)InnerStyle
{
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    style.centerUpOffset = 44;
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
    style.photoframeLineW = 3;
    style.photoframeAngleW = 18;
    style.photoframeAngleH = 18;
    style.isNeedShowRetangle = NO;
    
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    //qq里面的线条图片
    UIImage *imgLine = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    
    style.animationImage = imgLine;
    //非正方形
    //        style.isScanRetangelSquare = NO;
    //        style.xScanRetangleOffset = 40;
    
    
    [self openScanVCWithStyle:style];
}

#pragma mark -无边框，内嵌4个角
- (void)weixinStyle
{
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    style.centerUpOffset = 44;
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
    style.photoframeLineW = 2;
    style.photoframeAngleW = 18;
    style.photoframeAngleH = 18;
    style.isNeedShowRetangle = YES;
    
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    style.colorAngle = [UIColor colorWithRed:0./255 green:200./255. blue:20./255. alpha:1.0];
    
    
    //qq里面的线条图片
    UIImage *imgLine = [UIImage imageNamed:@"CodeScan.bundle/qrcode_Scan_weixin_Line"];
    
    // imgLine = [self createImageWithColor:[UIColor colorWithRed:120/255. green:221/255. blue:71/255. alpha:1.0]];
    
    style.animationImage = imgLine;
    
    
    
    
    [self openScanVCWithStyle:style];
}

#pragma mark -框内区域识别
- (void)recoCropRect
{
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    style.centerUpOffset = 44;
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_On;
    style.photoframeLineW = 6;
    style.photoframeAngleW = 24;
    style.photoframeAngleH = 24;
    style.isNeedShowRetangle = YES;
    
    style.anmiationStyle = LBXScanViewAnimationStyle_NetGrid;
    
    
    //矩形框离左边缘及右边缘的距离
    style.xScanRetangleOffset = 80;
    
    //使用的支付宝里面网格图片
    UIImage *imgPartNet = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_part_net"];
    
    style.animationImage = imgPartNet;
    [self openScanVCWithStyle:style];
}




#pragma mark -4个角在矩形框线上,网格动画
- (void)OnStyle
{
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    style.centerUpOffset = 44;
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_On;
    style.photoframeLineW = 6;
    style.photoframeAngleW = 24;
    style.photoframeAngleH = 24;
    style.isNeedShowRetangle = YES;
    
    style.anmiationStyle = LBXScanViewAnimationStyle_NetGrid;
    
    
    //使用的支付宝里面网格图片
    UIImage *imgPartNet = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_part_net"];
    
    style.animationImage = imgPartNet;
    
    //非正方形
    //        style.isScanRetangelSquare = NO;
    //        style.xScanRetangleOffset = 40;
    
    [self openScanVCWithStyle:style];
}


#pragma mark -改变扫码区域位置
- (void)changeSize
{
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    
    //矩形框向上移动
    style.centerUpOffset = 60;
    //矩形框离左边缘及右边缘的距离
    style.xScanRetangleOffset = 100;
    
    
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_On;
    style.photoframeLineW = 6;
    style.photoframeAngleW = 24;
    style.photoframeAngleH = 24;
    style.isNeedShowRetangle = YES;
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    //qq里面的线条图片
    UIImage *imgLine = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];
    
    style.animationImage = imgLine;
    
    [self openScanVCWithStyle:style];
}

#pragma mark -非正方形，可以用在扫码条形码界面

- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)notSquare
{
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    style.centerUpOffset = 44;
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
    style.photoframeLineW = 4;
    style.photoframeAngleW = 28;
    style.photoframeAngleH = 16;
    style.isNeedShowRetangle = NO;
    
    style.anmiationStyle = LBXScanViewAnimationStyle_LineStill;
    
    
    style.animationImage = [self createImageWithColor:[UIColor redColor]];
    //非正方形
    //设置矩形宽高比
    style.whRatio = 4.3/2.18;
    
    //离左边和右边距离
    style.xScanRetangleOffset = 30;
    
    
    
    [self openScanVCWithStyle:style];
}


- (void)openScanVCWithStyle:(LBXScanViewStyle*)style
{
    ScanQRViewController *vc = [ScanQRViewController new];
    vc.style = style;
    vc.isQQSimulator = YES;
    vc.isVideoZoom = YES;
    [self.delegate pushScanController:vc];
}
@end
