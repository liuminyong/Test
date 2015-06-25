//
//  URLUpdateViewController.m
//  PhotoMania
//
//  Created by liuminyong on 15/6/25.
//  Copyright (c) 2015年 liuminyong. All rights reserved.
//

#import "URLUpdateViewController.h"

@interface URLUpdateViewController ()
@property (strong, nonatomic) IBOutlet UITextView *uitext;

@end

@implementation URLUpdateViewController

-(void)setUrl:(NSURL *)url
{
    _url=url;
    
    [self updateUi];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateUi];
}

-(void)updateUi
{
    self.uitext.text=[self.url absoluteString];
}

@end
