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
  self.view.backgroundColor = [UIColor orangeColor];

  _testView = [UIView new];
  _testView.frame = CGRectMake(self.view.center.x - 100,100,200,200);
  _testView.backgroundColor = [UIColor blueColor];
  [self.view addSubview:_testView];
  [self setHelloButton];

  self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)setHelloButton{
  UIButton *helloButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  helloButton.frame = CGRectMake(0, self.view.frame.size.height-88, self.view.frame.size.width, 44);
  [helloButton setTitle:@"Button" forState:UIControlStateNormal];
  [helloButton addTarget:self action:@selector(tapHello:) forControlEvents:UIControlEventTouchDown];
  [self.view addSubview:helloButton];
}

-(void)tapHello:(UIButton *)button{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello YAMASHITA" message:nil delegate:nil cancelButtonTitle:@"了解" otherButtonTitles:nil];
  [alert show];
}
@end
