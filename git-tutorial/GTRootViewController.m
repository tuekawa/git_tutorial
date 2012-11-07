#import "GTRootViewController.h"
#import "GTScreen2ViewController.h"

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
  
  UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(100,100, 30,100)];
  label.text = @"TB001";
  [self.view addSubview:label];

  self.navigationItem.rightBarButtonItem = self.editButtonItem;

  // 画面２への遷移ボタン
  UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  button2.frame = CGRectMake((320-220)/2, 320, 220, 40);
  [button2 setTitle:@"画面２へ遷移" forState:UIControlStateNormal];
  [button2 addTarget:self action:@selector(pushButton2:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button2];
  
}

- (void)pushButton2:(UIButton *)button {
  GTScreen2ViewController *screen2ViewController = [[GTScreen2ViewController alloc] init];
  [self.navigationController pushViewController:screen2ViewController animated:YES];
}

@end
