
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SRLoadingType) {
    SRLoadingTypeKeep,
    SRLoadingTypeFadeOut,
};

@interface SRLoadingView : UIView

@property (nonatomic, assign) SRLoadingType animType;

@property (nonatomic, strong, null_resettable) UIColor *lineColor;

@property (nonatomic) CGFloat lineWidth;

@property (nonatomic) BOOL hidesWhenStopped;

@property (nonatomic, readwrite) NSTimeInterval duration;

@property (nonatomic, assign, readonly, getter=isAnimating) BOOL animating;

- (void)startAnimating;

- (void)stopAnimating;

@end

NS_ASSUME_NONNULL_END
