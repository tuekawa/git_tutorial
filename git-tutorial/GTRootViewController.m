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
  self.view.backgroundColor = [UIColor yellowColor];
  
  UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(100,100, 300,300)];
  label.text = @"TB001";
  [self.view addSubview:label];
  
  UIButton *changeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  changeButton.frame = CGRectMake(0, self.view.frame.size.height-120, self.view.frame.size.width/2, 44);

  [changeButton setTitle:@"change bg-color" forState:UIControlStateNormal];
  [changeButton addTarget:self action:@selector(downChangeBgColor:) forControlEvents:UIControlEventTouchDown];
  [changeButton addTarget:self action:@selector(upChangeBgColor:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:changeButton];

  self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)downChangeBgColor:(UIButton *)button{
  self.view.backgroundColor = [UIColor redColor];
}
-(void)upChangeBgColor:(UIButton *)button{
  self.view.backgroundColor = [UIColor yellowColor];
}

@end
