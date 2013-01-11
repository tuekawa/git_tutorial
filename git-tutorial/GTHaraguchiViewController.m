#import "GTHaraguchiViewController.h"
#import <GameKit/GameKit.h>

@interface GTHaraguchiViewController ()<GKSessionDelegate,UITextFieldDelegate>

@end

@implementation GTHaraguchiViewController{
  GKSession *_session;
  UITextField *_textField;
  UILabel *_label;
  NSMutableArray *_connectingPeers;
  UILabel *_peerInfoLabel;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(void)viewDidLoad
{
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];
  _session = [[GKSession alloc] initWithSessionID:@"session id" displayName:nil sessionMode:GKSessionModePeer];
  _session.delegate = self;
  [_session setAvailable:YES];
  [_session setDataReceiveHandler:self withContext:nil];
  
  _connectingPeers = [NSMutableArray array];
  
  _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 60, 320-20, 44)];
  _textField.borderStyle = UITextBorderStyleRoundedRect;
  _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
  _textField.textAlignment = NSTextAlignmentLeft;
  _textField.delegate = self;
  _textField.returnKeyType = UIReturnKeySend;
  _textField.keyboardAppearance = UIKeyboardAppearanceAlert;
  [self.view addSubview:_textField];
  
  _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 300, 44)];
  _label.backgroundColor = [UIColor greenColor];
  _label.textColor = [UIColor redColor];
  _label.minimumScaleFactor = 1;
  _label.adjustsFontSizeToFitWidth = YES;
  _label.adjustsLetterSpacingToFitWidth = YES;
  [self.view addSubview:_label];
  
  _peerInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 300, 200)];
  _peerInfoLabel.backgroundColor = [UIColor blueColor];
  _peerInfoLabel.textColor = [UIColor whiteColor];
  _peerInfoLabel.minimumScaleFactor = 1;
  _peerInfoLabel.adjustsFontSizeToFitWidth = YES;
  _peerInfoLabel.adjustsLetterSpacingToFitWidth = YES;
  _peerInfoLabel.numberOfLines = 0;
  [self.view addSubview:_peerInfoLabel];
  
  UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                        target:self
                                                                        action:@selector(tapLeftBarItem)];
  self.navigationItem.leftBarButtonItem = item;
  
  [self updatePeerInfo];
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
  [self updatePeerInfo];
}

-(void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession:(GKSession *)session context:(void*)context{
  NSLog(@"%@からデータ取得",peer);
  NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
  NSString *byPeer = [NSString stringWithFormat:@" by %@",[session displayNameForPeer:peer]];
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

-(void)updatePeerInfo{
  NSArray *connectedPeers = [_session peersWithConnectionState:GKPeerStateConnected];
  NSArray *connectingPeers = [_session peersWithConnectionState:GKPeerStateConnecting];
  NSArray *connectablePerrs = [_session peersWithConnectionState:GKPeerStateAvailable];
  if (connectablePerrs.count) {
    _peerInfoLabel.text = [NSString stringWithFormat:@"%@と接続できます",[connectablePerrs objectAtIndex:0]];
  }
  if (connectingPeers.count) {
    _peerInfoLabel.text = [NSString stringWithFormat:@"%@と接続中です",[connectingPeers objectAtIndex:0]];
  }
  if (connectedPeers.count == 0) {
    _peerInfoLabel.text = @"接続先を探しています";
    return;
  }
  NSString *infoStr = [NSString stringWithFormat:@"接続数:%d\n",connectedPeers.count];
  for (NSString *peer in connectedPeers) {
    NSString *displayName = [_session displayNameForPeer:peer];
    infoStr = [infoStr stringByAppendingString:[NSString stringWithFormat:@"ID:%@ Name:%@\n",peer,displayName]];
  }
  _peerInfoLabel.text = infoStr;
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
