基于LBXScan进行的扫码封装，更加简化了实用方式，两行代码即可实现扫码功能
1.首先在项目中pod如下库
pod 'ZXingObjC', '~> 3.0'
pod 'LBXAlertAction'
pod 'ZYCornerRadius', git:'https://github.com/liuzhiyi1992/ZYCornerRadius.git',tag:'0.9.1'
2.在项目中建立全局pch文件加入如下代码，不然会报错
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
