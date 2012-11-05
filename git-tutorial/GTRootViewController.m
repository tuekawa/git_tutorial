//
//  GTRootViewController.m
//  git-tutorial
//
//  Created by Takeshi Shoji on 12/11/05.
//  Copyright (c) 2012年 Takeshi Shoji. All rights reserved.
//

#import "GTRootViewController.h"

@interface GTRootViewController ()

@end

@implementation GTRootViewController{
  UIView *_testView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor orangeColor];

  _testView = [UIView new];
  _testView.frame = CGRectMake(self.view.center.x - 100,100,200,200);
  _testView.backgroundColor = [UIColor blueColor];
  [self.view addSubview:_testView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
