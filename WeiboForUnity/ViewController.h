//
//  ViewController.h
//  WeiboForUnity
//
//  Created by Shawn wu on 7/20/12.
//  Copyright (c) 2012 the9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBEngine.h"
#import "WBSendView.h"

@interface ViewController : UIViewController<WBEngineDelegate, WBSendViewDelegate>
{
    UIButton *_loginButton;
    UIButton *_writeButton;
}



@end
