### 摘要
 这个工程会讲述oc 中Runtime 的使用。如果讲的不太全面或者有问题。可以随时联系我 
 
 
 The  project will tell about the use of Runtime in oc. If the project is not comprehensive or there is a problem. You can contact me at any time
 
 
 
 E-mail : wangfeifei0525@163.com
 
 QQ : 422967884
 
 FaceBook :wangfeifei0525@163.com          
 name:王飞
 
 
###主要内容
 
 ```c
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
 ```