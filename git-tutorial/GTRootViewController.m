#import "GTRootViewController.h"
#import <CoreMotion/CoreMotion.h>
#import "GTHaraguchiViewController.h"
#import "GTKawaTableViewController.h"

@implementation GTRootViewController {
  UIView *_testView;
  CMMotionManager *_motionManager;
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

  UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(100,100, 300,300)];
  label.text = @"TB001";
  [self.view addSubview:label];

  UIButton *changeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  changeButton.frame = CGRectMake(0, self.view.frame.size.height-120, self.view.frame.size.width/2, 44);

  [changeButton setTitle:@"change bg-color" forState:UIControlStateNormal];
  [changeButton addTarget:self action:@selector(downChangeBgColor:) forControlEvents:UIControlEventTouchDown];
  [changeButton addTarget:self action:@selector(upChangeBgColor:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:changeButton];

  _testView = [UIView new];
  _testView.frame = CGRectMake(self.view.center.x - 100,100,200,200);
  _testView.backgroundColor = [UIColor blueColor];
  [self.view addSubview:_testView];
  [self setHelloButton];

  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"kawaTableVC"
                                                                    style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                    action:@selector(kawaTableVC)];

  [self setLabelToTestView];
  UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]
                                        initWithTarget:self
                                        action:@selector(tapTestView:)];
  [_testView addGestureRecognizer:tapGesture];

}

- (void)kawaTableVC {
  GTKawaTableViewController *kawaTVC = [[GTKawaTableViewController alloc] initWithStyle:UITableViewStylePlain];
  [self.navigationController pushViewController:kawaTVC animated:YES];
}



-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  float ballSize = 44;

  UIButton *ball = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  ball.tintColor = [UIColor grayColor];
  ball.frame = CGRectMake(0, 0, ballSize, ballSize);
  [ball addTarget:self action:@selector(tapMovingButton) forControlEvents:UIControlEventTouchDown];
  [self.view addSubview:ball];

  _motionManager = [[CMMotionManager alloc] init];
  if (_motionManager.accelerometerAvailable) {
  [_motionManager setAccelerometerUpdateInterval:0.01f];
    [_motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                         withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                             float x = accelerometerData.acceleration.x*10;
                                             float y = -accelerometerData.acceleration.y*10;
                                             float ballX = ball.center.x;
                                             float ballY = ball.center.y;
                                             ballX += x;
                                             ballY += y;
                                             if (ballX < ballSize/2 ){
                                               ballX = ballSize/2;
                                             }
                                             if(ballX > 320 - ballSize/2){
                                               ballX = 320 - ballSize/2;

                                             }if(ballY < ballSize/2){
                                               ballY = ballSize/2;
                                             }
                                             if(ballY > self.view.frame.size.height - ballSize/2) {
                                               ballY = self.view.frame.size.height - ballSize/2;
                                             }
                                             ball.center = CGPointMake(ballX, ballY);
                                           });
                                         }];
  }
}

-(void)setHelloButton{
  UIButton *helloButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  helloButton.frame = CGRectMake(0, self.view.frame.size.height-88, self.view.frame.size.width, 44);
  [helloButton setTitle:@"Button of Secret" forState:UIControlStateNormal];
  [helloButton addTarget:self action:@selector(tapHello:) forControlEvents:UIControlEventTouchDown];
  [self.view addSubview:helloButton];
}
-(void)downChangeBgColor:(UIButton *)button{
  self.view.backgroundColor = [UIColor redColor];
}
-(void)upChangeBgColor:(UIButton *)button{
  self.view.backgroundColor = [UIColor orangeColor];
}

-(void)tapHello:(UIButton *)button{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Hello YOSHINAGA" message:nil delegate:nil cancelButtonTitle:@"了解" otherButtonTitles:nil];
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

-(void)tapMovingButton{
  [_motionManager stopAccelerometerUpdates];
  GTHaraguchiViewController *vc = [GTHaraguchiViewController new];
  UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
  [self presentViewController:nc animated:NO completion:^{
  }];
}


@end
