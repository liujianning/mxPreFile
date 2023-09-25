

#import "SRPeriodView.h"
#import "SRPrimaryConst.h"

@implementation SRPeriodView
@synthesize verySize = _verySize;
@synthesize coverImageView = _coverImageView;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self addSubview:self.coverImageView];
    }
    return self;
}

- (void)setPeriodView:(UIView *)periodView {
    if (_periodView) {
        [_periodView removeFromSuperview];
        self.verySize = CGSizeZero;
    }
    _periodView = periodView;
    if (periodView != nil) {
        [self addSubview:periodView];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat min_x = 0;
    CGFloat min_y = 0;
    CGFloat min_w = 0;
    CGFloat min_h = 0;
    CGFloat min_view_w = self.bounds.size.width;
    CGFloat min_view_h = self.bounds.size.height;
    
    CGSize viewSize = CGSizeZero;
    CGFloat verticalWidth = self.verySize.width;
    CGFloat verticalHeight = self.verySize.height;
    if (verticalHeight == 0) return;
    CGFloat screenScale = min_view_w/min_view_h;
    CGFloat verticalScale = verticalWidth/verticalHeight;
    if (screenScale > verticalScale) {
        CGFloat height = min_view_h;
        CGFloat width = height * verticalScale;
        viewSize = CGSizeMake(width, height);
    } else {
        CGFloat width = min_view_w;
        CGFloat height = width / verticalScale;
        viewSize = CGSizeMake(width, height);
    }
    
    if (self.scalingMode == SRPrimaryStageScalingModeNone || self.scalingMode == SRPrimaryStageScalingModeAspectFit) {
        min_w = viewSize.width;
        min_h = viewSize.height;
        min_x = (min_view_w - min_w) / 2.0;
        min_y = (min_view_h - min_h) / 2.0;
        self.periodView.frame = CGRectMake(min_x, min_y, min_w, min_h);
    } else if (self.scalingMode == SRPrimaryStageScalingModeAspectFill || self.scalingMode == SRPrimaryStageScalingModeFill) {
        self.periodView.frame = self.bounds;
    }
    self.coverImageView.frame = self.periodView.frame;
}

- (CGSize)verySize {
    if (CGSizeEqualToSize(_verySize, CGSizeZero)) {
        _verySize = self.frame.size;
    }
    return _verySize;
}

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.userInteractionEnabled = YES;
        _coverImageView.clipsToBounds = YES;
        _coverImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _coverImageView;
}

- (void)setScalingMode:(SRPrimaryStageScalingMode)scalingMode {
    _scalingMode = scalingMode;
     if (scalingMode == SRPrimaryStageScalingModeNone || scalingMode == SRPrimaryStageScalingModeAspectFit) {
         self.coverImageView.contentMode = UIViewContentModeScaleAspectFit;
    } else if (scalingMode == SRPrimaryStageScalingModeAspectFill) {
        self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    } else if (scalingMode == SRPrimaryStageScalingModeFill) {
        self.coverImageView.contentMode = UIViewContentModeScaleToFill;
    }
    [self layoutIfNeeded];
}

- (void)setVerySize:(CGSize)verySize {
    _verySize = verySize;
    if (CGSizeEqualToSize(CGSizeZero, verySize)) return;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

@end
