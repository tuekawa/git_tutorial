#import "GTKawaTableViewController.h"
#import <QuartzCore/QuartzCore.h>

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@implementation GTKawaTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:style];
  if (self) {
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];


  CATransform3D perspectiveTransform = CATransform3DIdentity;
  perspectiveTransform.m34 = 1.0 / -1000;
  self.view.layer.sublayerTransform = perspectiveTransform;


}

#pragma mark -  UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 1000;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"KawaCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyle)UITableViewCellStyleSubtitle
                                    reuseIdentifier:CellIdentifier];
    cell.imageView.image = [UIImage imageNamed:@"kawa.jpeg"];
    cell.textLabel.text = @"kazumi haraguchi";
    cell.detailTextLabel.text = @"kazumi haraguchi";
  }
  cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1);
  cell.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(45), -1, -.5, 1);
  return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 64;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  cell.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1);
  cell.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(60), -1, -2, 1);
}

@end
