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

  [self setLabelToTestView];
  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                        initWithTarget:self
                                        action:@selector(tapTestView:)];
  [_testView addGestureRecognizer:tapGesture];
}

-(void)setHelloButton{
  UIButton *helloButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  helloButton.frame = CGRectMake(0, self.view.frame.size.height-88, self.view.frame.size.width, 44);
  [helloButton setTitle:@"Button of Secret" forState:UIControlStateNormal];
  [helloButton addTarget:self action:@selector(tapHello:) forControlEvents:UIControlEventTouchDown];
  [self.view addSubview:helloButton];
}

-(void)tapHello:(UIButton *)button{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello YAMASHITA" message:nil delegate:nil cancelButtonTitle:@"了解" otherButtonTitles:nil];
  [alert show];
}

-(void)setLabelToTestView{
  UILabel *testViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,
                                                                     _testView.frame.size.width,
                                                                     _testView.frame.size.height)];
  testViewLabel.backgroundColor = [UIColor clearColor];
  testViewLabel.textAlignment = NSTextAlignmentCenter;
  testViewLabel.textColor = [UIColor cyanColor];
  testViewLabel.minimumScaleFactor = 1.0f;
  testViewLabel.adjustsFontSizeToFitWidth = YES;
  testViewLabel.adjustsLetterSpacingToFitWidth = YES;
  testViewLabel.font = [UIFont boldSystemFontOfSize:40];
  testViewLabel.text = @"Tap";
  [_testView addSubview:testViewLabel];
}

-(void)tapTestView:(id)sender{
  [UIView animateWithDuration:3.0 animations:^{
    CGAffineTransform scale = CGAffineTransformMakeScale(1.5f, 1.5f);
    CGAffineTransform trans = CGAffineTransformMakeTranslation(88, 88);
    CGAffineTransform rotate = CGAffineTransformMakeRotation((M_PI/180)*180);
    _testView.transform = CGAffineTransformConcat(scale, CGAffineTransformConcat(trans, rotate));
  } completion:^(BOOL finished) {
    [UIView animateWithDuration:1.0f animations:^{
      _testView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
    }];
  }];
}
@end
