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
  
  UILabel* _label = [[UILabel alloc]initWithFrame:CGRectMake(100,100, 300,300)];
  _label.text = @"TB001";
  [self.view addSubview:_label];

  self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

@end
