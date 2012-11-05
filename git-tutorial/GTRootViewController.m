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

@implementation GTRootViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
