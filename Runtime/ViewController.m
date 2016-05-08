//
//  ViewController.m
//  Runtime
//
//  Created by 王飞 on 16/5/8.
//  Copyright © 2016年 com.wangfei. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "WFPerson.h"
#import "UIImage+Swizzling.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageOrigin;
@property (weak, nonatomic) IBOutlet UIImageView *imageSwizzling;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sendMessage];
    
    [self methodSwizzling];
}

- (void)sendMessage {
#pragma 消息机制
    Class classPerson  = objc_getClass("WFPerson");
    
    // 同过类创建实例对象
    // 如果这里报错，请将 Build Setting -> Enable Strict Checking of objc_msgSend Calls 改为 NO
    WFPerson *person = objc_msgSend(classPerson, @selector(alloc));
    
    person = objc_msgSend(person,@selector(init));
//    [person eat];
    
    objc_msgSend(person,@selector(runWithCount:),10);
    objc_msgSend(person, @selector(eat));
    
#pragma 动态关联方法
    /**
     *  person 对象并没有 sayHello 方法 这时候  用WFPerson 内部的hello 代替 sayHello
     */
    objc_msgSend(person, @selector(sayHello));

#pragma 消息转发
    /**
     *  person 发给stoke  的方法，通过黑魔法操作，转给了 touch
     */
    objc_msgSend(person, @selector(stoke));
}

#pragma 方法交换  详细操作  看UIImage＋Swizzling的分类
- (void)methodSwizzling {
    UIImage *image = [UIImage imageNamed:@"hitLive"];
    _imageOrigin.image = image;
    
    NSLog(@"--------这是分界线---------");
    
    UIImage *imge = [UIImage tuc_imageNamedMethod:@"hitLive"];
    _imageSwizzling.image = imge;
}



@end
