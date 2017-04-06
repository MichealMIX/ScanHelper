
1.首先在项目中pod如下库
```
pod 'ZXingObjC', '~> 3.0
pod 'LBXAlertAction'
pod 'ZYCornerRadius', git:'https://github.com/liuzhiyi1992/ZYCornerRadius.git',tag:'0.9.1'
```
2.在项目中建立全局pch文件加入如下代码，不然会报错
```
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
```
3.在项目中拖入ScanHelper以及LBXScan两个文件夹
4.在需要实现扫码的地方导入头文件
```
#import "ScanHelper.h"
```
5.在扫码方法中添加如下代码，如果想自定义样式在ScanHelper中修改即可，并枚举出了封装好的几种风格
```
    [self.navigationController pushViewController:[[ScanHelper shareInstance] ScanVCWithStyle:qqStyle qrResultCallBack:^(id result) {
        //扫码结果
        NSLog(@"-----%@",result);
    }] animated:YES];
 ```
6.在回调方法中处理逻辑即可
7.特别注意在iOS10以上要修改隐私权限，找到info.plist文件右键source code方式打开，添加如下代码即可
```
        <key>NSCameraUsageDescription</key>
	    <string>是否允许使用相机</string>
	    <key>NSPhotoLibraryUsageDescription</key>
	    <string>是否允许打开相册</string>
```
