<p align="center" >
  <img src="http://upload.jianshu.io/users/upload_avatars/2572187/5a03413614d6?imageMogr2/auto-orient/strip|imageView2/1/w/240/h/240" alt="MichealMIX" title="MichealMIX">
</p>
####基于LBXScan进行的扫码封装，更加简化了实用方式，两行代码即可实现扫码功能<p>
###1.首先在项目中pod如下库<br>
```pod 'ZXingObjC', '~> 3.0'```<br>
```pod 'LBXAlertAction'```<br>
```pod 'ZYCornerRadius', git:'https://github.com/liuzhiyi1992/ZYCornerRadius.git',tag:'0.9.1'```<br>
###2.在项目中建立全局pch文件加入如下代码，不然会报错<br>
```#import <Foundation/Foundation.h>```<br>
```#import <UIKit/UIKit.h>```<br>
###3.在项目中拖入ScanHelper以及LBXScan两个文件夹<br>
###4.在需要实现扫码的地方导入头文件<br>
```#import "ScanHelper.h"```<br>
###5.在相应位置添加代理<br>
```@interface ViewController ()<ScanStyleDelegate>```<br>
###6.在扫码方法中添加如下两行代码<br>
    //如果想自定义样式在ScanHelper中修改即可，将“qqStyle”替换为相应样式名称
    [ScanHelper shareInstance].delegate = self;
    [[ScanHelper shareInstance] goScanWithStyle:@"qqStyle"];
###7.实现相应代理方法即可实现扫码<br>
    #pragma mark ScanHelper 代理方法
    - (void)pushScanController:(UIViewController *)controller{
         [self.navigationController pushViewController:controller animated:YES];
    }
###8.扫码结果在ScanQRViewController中showNextVCWithScanResult方法处理
    - (void)showNextVCWithScanResult:(LBXScanResult*)strResult
    {
         //这里处理扫描结果
    }
###9.特别注意在iOS10以上要修改隐私权限，找到info.plist文件右键source code方式打开，添加如下代码即可
        <key>NSCameraUsageDescription</key>
	    <string>是否允许使用相机</string>
	    <key>NSPhotoLibraryUsageDescription</key>
	    <string>是否允许打开相册</string>
