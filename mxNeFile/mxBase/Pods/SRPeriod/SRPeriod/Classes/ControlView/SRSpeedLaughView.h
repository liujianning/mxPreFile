
#import <UIKit/UIKit.h>
#import "SRLoadingView.h"

@interface SRSpeedLaughView : UIView

@property (nonatomic, strong) SRLoadingView *loadingView;

@property (nonatomic, strong) UILabel *speedTextLabel;

- (void)startAnimating;

- (void)stopAnimating;

@end
