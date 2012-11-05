#import "GTRootViewController.h"

@implementation GTRootViewController {
  UIView *_testView;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor brownColor];

  _testView = [UIView new];
  _testView.frame = CGRectMake(self.view.center.x - 100,100,200,200);
  _testView.backgroundColor = [UIColor blueColor];
  [self.view addSubview:_testView];

  self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

@end
