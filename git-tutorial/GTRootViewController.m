#import "GTRootViewController.h"

@implementation GTRootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor orangeColor];
  
  UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(100,100, 300,300)];
  label.text = @"TB001";
  [self.view addSubview:label];

  self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

@end
