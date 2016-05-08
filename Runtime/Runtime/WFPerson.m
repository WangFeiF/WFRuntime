//
//  WFPerson.m
//  Runtime
//
//  Created by 王飞 on 16/5/8.
//  Copyright © 2016年 com.wangfei. All rights reserved.
//

#import "WFPerson.h"
#import <objc/runtime.h>

@implementation WFPerson
#pragma mark -- 消息机制
- (void)eat {
    NSLog(@"讷了药次漏") ;
}
- (void)runWithCount:(int)count {
    NSLog(@"跑了%d步",count);
}


#pragma mark -- 动态加载方法
void hello(id self, SEL _cmd) {
    NSLog(@"还的跑");
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == NSSelectorFromString(@"sayHello")) {
        // 动态添加 run: 方法
        class_addMethod(self, @selector(sayHello), (IMP)hello, "v@:");
        
        return NO;
    }
    
    return [super resolveInstanceMethod:sel];
}


#pragma mark -- 消息转发
// 指定方法签名，若返回 nil，则不会进入下一步，而是无法处理消息
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if ([NSStringFromSelector(aSelector) isEqualToString:@"stoke"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    
    return [super methodSignatureForSelector:aSelector];
}

// 当实现了此方法后，-doesNotRecognizeSelector: 将不会被调用
// 如果要测试找不到方法，可以注释掉这一个方法
// 在这里进行消息转发
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
    // 我们还可以改变方法选择器
    [anInvocation setSelector:@selector(touch)];
    // 改变方法选择器后，还需要指定是哪个对象的方法
    [anInvocation invokeWithTarget:self];
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"无法处理消息：%@", NSStringFromSelector(aSelector));
}

+ (void)touch {
    NSLog(@"Person 没有实现 stoke 方法，并且成功的转成了 touch 方法");
}

- (void)stoke {
    WFPerson *person = [[WFPerson alloc] init];
    [WFPerson performSelector:@selector(touch) withObject:nil afterDelay:0];
}
@end
