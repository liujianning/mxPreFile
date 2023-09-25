

#import <UIKit/UIKit.h>
#import "SRPrimaryConst.h"

@interface SRPeriodView : UIView

@property (nonatomic, strong) UIView *periodView;

@property (nonatomic, assign) SRPrimaryStageScalingMode scalingMode;

@property (nonatomic, assign) CGSize verySize;

@property (nonatomic, strong, readonly) UIImageView *coverImageView;

@end
