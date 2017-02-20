//
//  ViewController.m
//  ScanHelperDemo
//
//  Created by zhengrui on 17/2/14.
//  Copyright © 2017年 zhengrui. All rights reserved.
//

#import "ViewController.h"
#import "ScanHelper.h"

@interface ViewController ()
/**点击二维码手势*/
@property (nonatomic , strong) UITapGestureRecognizer *tap;
@property (nonatomic ,strong)UIImageView *scanImage;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setScanImage];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setScanImage{
    [self.navigationController.navigationBar addSubview:self.scanImage];
}

- (void)tapScanView{
    //所有扫码样式在ScanHelper中可见
    
    [self.navigationController pushViewController:[[ScanHelper shareInstance] ScanVCWithStyle:qqStyle qrResultCallBack:^(id result) {
        //扫码结果
        NSLog(@"-----%@",result);
    }] animated:YES];
}



- (UITapGestureRecognizer *)tap{
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScanView)];
    }
    return _tap;
}

- (UIImageView *)scanImage{
    if (!_scanImage) {
        _scanImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-44, 0, 44, 44)];
        _scanImage.image = [UIImage imageNamed:@"erweima"];
        _scanImage.userInteractionEnabled = YES;
        [_scanImage addGestureRecognizer:self.tap];
    }
    return _scanImage;
}


@end
