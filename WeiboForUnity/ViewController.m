//
//  ViewController.m
//  WeiboForUnity
//
//  Created by Shawn wu on 7/20/12.
//  Copyright (c) 2012 the9. All rights reserved.
//

#import "ViewController.h"
#import "WBEngine.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _loginButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _loginButton.frame = CGRectMake(40,40,80,40);
    [_loginButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];

    [_loginButton setTitle:@"login" forState:UIControlStateNormal];
    [self.view addSubview:_loginButton];
    [_loginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    _writeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _writeButton.frame = CGRectMake(40,100,80,40);
    [_writeButton setTitle:@"write" forState:UIControlStateNormal];
    [_writeButton addTarget:self action:@selector(writeStatus) forControlEvents:UIControlEventTouchUpInside];
    [_writeButton setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [self.view addSubview:_writeButton];
    
    if ([[WBEngine sharedEngine] isLoggedIn] && ![[WBEngine sharedEngine] isAuthorizeExpired]){
        [_loginButton setEnabled:NO];
        [_writeButton setEnabled:YES];
    }else{
        _loginButton.enabled = YES;
        _writeButton.enabled = NO;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    

        
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



- (void)login
{
    NSLog(@"hha");
    [[WBEngine sharedEngine] setDelegate:self];
    [[WBEngine sharedEngine] logIn];
}


#pragma mark Authorize

- (void)engineAlreadyLoggedIn:(WBEngine *)engine
{

    if ([engine isUserExclusive])
    {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil 
                                                           message:@"请先登出！" 
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定" 
                                                 otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        
        _loginButton.enabled = NO;
        _writeButton.enabled = YES;
    }
}

- (void)engineDidLogIn:(WBEngine *)engine
{

    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil 
													   message:@"登录成功！" 
													  delegate:self
											 cancelButtonTitle:@"确定" 
											 otherButtonTitles:nil];

	[alertView show];
	[alertView release];
}

- (void)engine:(WBEngine *)engine didFailToLogInWithError:(NSError *)error
{

    NSLog(@"didFailToLogInWithError: %@", error);
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil 
													   message:@"登录失败！" 
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}


- (void)writeStatus
{
    WBSendView *sendView = [[WBSendView alloc] initWithAppKey:[WBEngine sharedEngine].appKey appSecret:[WBEngine sharedEngine].appSecret text:@"test" image:nil];
    [sendView setDelegate:self];
    
    [sendView show:YES];
    [sendView release];
}


#pragma mark - WBSendViewDelegate Methods

- (void)sendViewDidFinishSending:(WBSendView *)view
{
    [view hide:YES];
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"微博发送成功！"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

- (void)sendView:(WBSendView *)view didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    [view hide:YES];
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"微博发送失败！"
													  delegate:nil
											 cancelButtonTitle:@"确定"
											 otherButtonTitles:nil];
	[alertView show];
	[alertView release];
}

- (void)sendViewNotAuthorized:(WBSendView *)view
{
    [view hide:YES];
    
    [self dismissModalViewControllerAnimated:YES];
}


- (void)sendViewAuthorizeExpired:(WBSendView *)view
{
    [view hide:YES];
    
    [self dismissModalViewControllerAnimated:YES];
}

@end
