//
//  UIImage+Swizzling.m
//  Runtime
//
//  Created by 王飞 on 16/5/8.
//  Copyright © 2016年 com.wangfei. All rights reserved.
//

#import "UIImage+Swizzling.h"
#import <objc/runtime.h>

@implementation UIImage (Swizzling)
+ (void)load {
    Method imageNamedMethod = class_getClassMethod(self, @selector(imageNamed:));
    Method tuc_imageNamedMethod =class_getClassMethod(self, @selector(tuc_imageNamedMethod:));
    
    method_exchangeImplementations(imageNamedMethod, tuc_imageNamedMethod);
}

+ (UIImage *)tuc_imageNamedMethod:(NSString *)name {
    NSLog(@"创建了一个名字%@的图片",name);
    UIImage *image = [UIImage tuc_imageNamedMethod:name];
    return image;
}
@end
