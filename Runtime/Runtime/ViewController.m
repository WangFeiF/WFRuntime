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
//    Class ClassPerson = object_getClass("");
    Class classPerson  = objc_getClass("WFPerson");
    
    // 同过类创建实例对象
    // 如果这里报错，请将 Build Setting -> Enable Strict Checking of objc_msgSend Calls 改为 NO
    WFPerson *person = objc_msgSend(classPerson, @selector(alloc));
    
    person = objc_msgSend(person,@selector(init));
//    [person eat];
    
    objc_msgSend(person,@selector(runWithCount:),10);
    objc_msgSend(person, @selector(eat));
    
    objc_msgSend(person, @selector(sayHello));
    
    objc_msgSend(person, @selector(stoke));
}

- (void)methodSwizzling {
    UIImage *image = [UIImage imageNamed:@"hitLive"];
    _imageOrigin.image = image;
    
    NSLog(@"--------这是分界线---------");
    
    UIImage *imge = [UIImage tuc_imageNamedMethod:@"hitLive"];
    _imageSwizzling.image = imge;
}



@end
