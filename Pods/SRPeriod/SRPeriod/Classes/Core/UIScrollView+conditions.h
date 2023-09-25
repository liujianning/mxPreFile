

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, SRPrimaryStageScrollDirection) {
    SRPrimaryStageScrollDirectionNone,
    SRPrimaryStageScrollDirectionUp,         // Scroll up
    SRPrimaryStageScrollDirectionDown,       // Scroll Down
    SRPrimaryStageScrollDirectionLeft,       // Scroll left
    SRPrimaryStageScrollDirectionRight       // Scroll right
};

typedef NS_ENUM(NSInteger, SRPrimaryStageScrollViewDirection) {
    SRPrimaryStageScrollViewDirectionVertical,
    SRPrimaryStageScrollViewDirectionHorizontal
};

typedef NS_ENUM(NSInteger, SRPrimaryStageContainerType) {
    SRPrimaryStageContainerTypeView,
    SRPrimaryStageContainerTypeCell
};

typedef NS_ENUM(NSInteger , SRPrimaryStageScrollViewScrollPosition) {
    SRPrimaryStageScrollViewScrollPositionNone,
    SRPrimaryStageScrollViewScrollPositionTop,
    SRPrimaryStageScrollViewScrollPositionCenteredVertically,
    SRPrimaryStageScrollViewScrollPositionBottom,
    SRPrimaryStageScrollViewScrollPositionLeft,
    SRPrimaryStageScrollViewScrollPositionCenteredHorizontally,
    SRPrimaryStageScrollViewScrollPositionRight
};

@interface UIScrollView (conditions)

@property (nonatomic, readonly) CGFloat zf_lastOffsetY;

@property (nonatomic, readonly) CGFloat zf_lastOffsetX;

@property (nonatomic) SRPrimaryStageScrollViewDirection zf_scrollViewDirection;

@property (nonatomic, readonly) SRPrimaryStageScrollDirection zf_scrollDirection;

- (UIView *)zf_getCellForIndexPath:(NSIndexPath *)indexPath;

- (NSIndexPath *)zf_getIndexPathForCell:(UIView *)cell;

- (void)zf_scrollToRowAtIndexPath:(NSIndexPath *)indexPath
                 atScrollPosition:(SRPrimaryStageScrollViewScrollPosition)scrollPosition
                         animated:(BOOL)animated
                completionHandler:(void (^ __nullable)(void))completionHandler;

- (void)zf_scrollToRowAtIndexPath:(NSIndexPath *)indexPath
                 atScrollPosition:(SRPrimaryStageScrollViewScrollPosition)scrollPosition
                  animateDuration:(NSTimeInterval)duration
                completionHandler:(void (^ __nullable)(void))completionHandler;

- (void)zf_scrollViewDidEndDecelerating;

- (void)zf_scrollViewDidEndDraggingWillDecelerate:(BOOL)decelerate;

- (void)zf_scrollViewDidScrollToTop;

- (void)zf_scrollViewDidScroll;

- (void)zf_scrollViewWillBeginDragging;

@end

@interface UIScrollView (SRPrimaryStageCannotCalled)

@property (nonatomic, copy, nullable) void(^presentStateAppearingInScrollView)(NSIndexPath *indexPath, CGFloat playerApperaPercent);

@property (nonatomic, copy, nullable) void(^presentStateDisappearingInScrollView)(NSIndexPath *indexPath, CGFloat playerDisapperaPercent);

@property (nonatomic, copy, nullable) void(^presentStateWillAppearInScrollView)(NSIndexPath *indexPath);

@property (nonatomic, copy, nullable) void(^presentStateDidAppearInScrollView)(NSIndexPath *indexPath);

@property (nonatomic, copy, nullable) void(^presentStateWillDisappearInScrollView)(NSIndexPath *indexPath);

@property (nonatomic, copy, nullable) void(^presentStateDidDisappearInScrollView)(NSIndexPath *indexPath);

@property (nonatomic, copy, nullable) void(^zf_scrollViewDidEndScrollingCallback)(NSIndexPath *indexPath);

@property (nonatomic, copy, nullable) void(^zf_scrollViewDidScrollCallback)(NSIndexPath *indexPath);

@property (nonatomic, copy, nullable) void(^presentStateShouldPlayInScrollView)(NSIndexPath *indexPath);

@property (nonatomic) CGFloat presentStateDisapperaPercent;

@property (nonatomic) CGFloat presentStateApperaPercent;

@property (nonatomic) BOOL zf_viewControllerDisappear;

@property (nonatomic, assign) BOOL zf_stopPlay;

@property (nonatomic, assign) BOOL zf_stopWhileNotVisible;

@property (nonatomic, nullable) NSIndexPath *zf_playingIndexPath;

@property (nonatomic, nullable) NSIndexPath *zf_shouldPlayIndexPath;

@property (nonatomic, getter=zf_isWWANAutoPlay) BOOL zf_WWANAutoPlay;

@property (nonatomic) BOOL shouldPractice;

@property (nonatomic) NSInteger zf_containerViewTag;

@property (nonatomic, strong) UIView *zf_containerView;

@property (nonatomic, assign) SRPrimaryStageContainerType zf_containerType;

- (void)zf_filterShouldPlayCellWhileScrolled:(void (^ __nullable)(NSIndexPath *indexPath))handler;

- (void)zf_filterShouldPlayCellWhileScrolling:(void (^ __nullable)(NSIndexPath *indexPath))handler;

@end

@interface UIScrollView (SRPrimaryStageDeprecated)

@property (nonatomic, copy, nullable) void(^zf_scrollViewDidStopScrollCallback)(NSIndexPath *indexPath) __attribute__((deprecated("use `SRPeriodController.zf_scrollViewDidEndScrollingCallback` instead.")));

@property (nonatomic, copy, nullable) void(^zf_shouldPlayIndexPathCallback)(NSIndexPath *indexPath) __attribute__((deprecated("use `SRPeriodController.zf_playerShouldPlayInScrollView` instead.")));

- (void)zf_scrollToRowAtIndexPath:(NSIndexPath *)indexPath
                completionHandler:(void (^ __nullable)(void))completionHandler __attribute__((deprecated("use `zf_scrollToRowAtIndexPath:atScrollPosition:animated:completionHandler:` instead.")));

- (void)zf_scrollToRowAtIndexPath:(NSIndexPath *)indexPath
                         animated:(BOOL)animated
                completionHandler:(void (^ __nullable)(void))completionHandler __attribute__((deprecated("use `zf_scrollToRowAtIndexPath:atScrollPosition:animated:completionHandler:` instead.")));

- (void)zf_scrollToRowAtIndexPath:(NSIndexPath *)indexPath
              animateWithDuration:(NSTimeInterval)duration
                completionHandler:(void (^ __nullable)(void))completionHandler __attribute__((deprecated("use `zf_scrollToRowAtIndexPath:atScrollPosition:animateDuration:completionHandler:` instead.")));

@end

NS_ASSUME_NONNULL_END
