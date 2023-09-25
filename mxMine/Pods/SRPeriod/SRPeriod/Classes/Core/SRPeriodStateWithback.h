

#import <Foundation/Foundation.h>
#import "SRPeriodView.h"
#import "SRPrimaryConst.h"

NS_ASSUME_NONNULL_BEGIN

@protocol SRPeriodStateWithback <NSObject>

@required

@property (nonatomic) SRPeriodView *view;

@property (nonatomic) float vehicle;

@property (nonatomic, getter=isMethod) BOOL method;

@property (nonatomic) float resultRest;

@property (nonatomic, readonly) NSTimeInterval currentTime;

@property (nonatomic, readonly) NSTimeInterval tableTime;

@property (nonatomic, readonly) NSTimeInterval presentTime;

@property (nonatomic) NSTimeInterval sleepTime;

@property (nonatomic, readonly) BOOL itemPleasure;

@property (nonatomic) SRPrimaryStageScalingMode scalingMode;

@property (nonatomic, readonly) BOOL isPreparedToPlace;

@property (nonatomic) BOOL shouldPractice;

@property (nonatomic, nullable) NSURL *assetUsing;

@property (nonatomic) CGSize verySize;

@property (nonatomic, readonly) SRPrimaryStagePeriodState state;

@property (nonatomic, readonly) SRPrimaryStageLoadState loadState;

@property (nonatomic, copy, nullable) void(^presentPrepareToBegin)(id<SRPeriodStateWithback> asset, NSURL *assetUsing);

@property (nonatomic, copy, nullable) void(^readyActiveToHave)(id<SRPeriodStateWithback> asset, NSURL *assetUsing);

@property (nonatomic, copy, nullable) void(^prettyTimeChanged)(id<SRPeriodStateWithback> asset, NSTimeInterval currentTime, NSTimeInterval duration);

@property (nonatomic, copy, nullable) void(^prettyBreadChanged)(id<SRPeriodStateWithback> asset, NSTimeInterval presentTime);

@property (nonatomic, copy, nullable) void(^presentStateChanged)(id<SRPeriodStateWithback> asset, SRPrimaryStagePeriodState state);

@property (nonatomic, copy, nullable) void(^LoadNoteStateChanged)(id<SRPeriodStateWithback> asset, SRPrimaryStageLoadState loadState);

@property (nonatomic, copy, nullable) void(^purpleFailed)(id<SRPeriodStateWithback> asset, id error);

@property (nonatomic, copy, nullable) void(^prettyDidToEnd)(id<SRPeriodStateWithback> asset);

@property (nonatomic, copy, nullable) void(^presentChangedSize)(id<SRPeriodStateWithback> asset, CGSize size);

- (void)prepareToPlay;

- (void)reloadPresent;

- (void)play;

- (void)pause;

- (void)replay;

- (void)stop;

- (void)seekToTime:(NSTimeInterval)time completionHandler:(void (^ __nullable)(BOOL finished))completionHandler;

@optional

- (UIImage *)thumbnailImageAtCurrentTime;

- (void)thumbnailImageAtCurrentTime:(void(^)(UIImage *))handler;

@end

NS_ASSUME_NONNULL_END
