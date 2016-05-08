//
//  UIImage+Swizzling.h
//  Runtime
//
//  Created by 王飞 on 16/5/8.
//  Copyright © 2016年 com.wangfei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Swizzling)
+ (UIImage *)tuc_imageNamedMethod:(NSString *)name;

@end
