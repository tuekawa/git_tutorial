#import "GTHaraguchiViewController.h"
#import <GameKit/GameKit.h>

@interface GTHaraguchiViewController ()<GKSessionDelegate,UITextFieldDelegate>

@end

@implementation GTHaraguchiViewController{
  GKSession *_session;
  UITextField *_textField;
  UILabel *_label;
  NSMutableArray *_connectingPeers;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  _session = [[GKSession alloc] initWithSessionID:@"session id" displayName:nil sessionMode:GKSessionModePeer];
  _session.delegate = self;
  _session.available = YES;
  [_session setAvailable:YES];
  [_session setDataReceiveHandler:self withContext:nil];
  
  _connectingPeers = [NSMutableArray array];
  
  _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 60, 320-20, 44)];
  _textField.borderStyle = UITextBorderStyleRoundedRect;
  _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  _textField.textAlignment = NSTextAlignmentLeft;
  _textField.delegate = self;
  [self.view addSubview:_textField];
  
  _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 300, 44)];
  _label.backgroundColor = [UIColor greenColor];
  _label.textColor = [UIColor redColor];
  _label.minimumScaleFactor = 1;
  _label.adjustsFontSizeToFitWidth = YES;
  _label.adjustsLetterSpacingToFitWidth = YES;
  [self.view addSubview:_label];
  
  UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                        target:self
                                                                        action:@selector(tapLeftBarItem)];
  self.navigationItem.leftBarButtonItem = item;
}

-(void)session:(GKSession *)session didFailWithError:(NSError *)error{
  NSLog(@"fail:%@",error);
}

-(void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error{
  NSLog(@"fail:%@",error);
}

-(void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID{
  NSLog(@"%@からリクエスト来た",peerID);
  NSError *error = nil;
  [session acceptConnectionFromPeer:peerID error:&error];
  NSLog(@"accepterror:%@",error);
}

-(void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state{
//  NSLog(@"didChangeState:%@:%@:%d",session,peerID,state);
  NSLog(@"stateCange:%d",state);
  if (state == GKPeerStateAvailable) {
    NSLog(@"%@と接続できます",peerID);
    [session connectToPeer:peerID withTimeout:30];
  }
  if (state == GKPeerStateConnected) {
    NSLog(@"%@と接続した",peerID);
    [_connectingPeers addObject:peerID];
  }
  if (state == GKPeerStateConnecting) {
    NSLog(@"%@と接続中",peerID);
  }
  if (state == GKPeerStateDisconnected) {
    NSLog(@"%@とは切断した",peerID);
  }
}

-(void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession:(GKSession *)session context:(void*)context{
  NSLog(@"%@からデータ取得",peer);
  NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
  NSString *byPeer = [NSString stringWithFormat:@" by %@",peer];
  _label.text = [str stringByAppendingString:byPeer];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
  NSData *sendData = [textField.text dataUsingEncoding:NSUTF8StringEncoding];
  NSError *error = nil;
  BOOL ret = [_session sendDataToAllPeers:sendData withDataMode:GKSendDataReliable error:&error];
  NSLog(@"送信:%d",ret);
  NSLog(@"send error:%@",error);
  return YES;
}

-(void)tapLeftBarItem{
  [_session disconnectFromAllPeers];
  _session.delegate = nil;
  [_session setAvailable:NO];
  [_session setDataReceiveHandler:nil withContext:nil];
  _textField.delegate = nil;
  [self dismissViewControllerAnimated:NO completion:^{
 }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
