

typedef NS_ENUM(NSUInteger, SRPrimaryStagePeriodState) {
    SRPrimaryStagePeriodStateUnknown,
    SRPrimaryStagePeriodStatePolite,
    SRPrimaryStagePeriodStatePattern,
    SRPrimaryStagePeriodStateFailed,
    SRPrimaryStagePeriodStateStopped
};

typedef NS_OPTIONS(NSUInteger, SRPrimaryStageLoadState) {
    SRPrimaryStageLoadStateUnknown        = 0,
    SRPrimaryStageLoadStatePrepare        = 1 << 0,
    SRPrimaryStageLoadStatePlayable       = 1 << 1,
    SRPrimaryStageLoadStatePlaythroughOK  = 1 << 2,
    SRPrimaryStageLoadStateStalled        = 1 << 3,
    SRPrimaryStageLoadStateTempPause       = 998,
    SRPrimaryStageLoadStateTempPlay       = 999,
};

typedef NS_ENUM(NSInteger, SRPrimaryStageScalingMode) {
    SRPrimaryStageScalingModeNone,
    SRPrimaryStageScalingModeAspectFit,
    SRPrimaryStageScalingModeAspectFill,
    SRPrimaryStageScalingModeFill
};

#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define zf_weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define zf_weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define zf_weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define zf_weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define zf_strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define zf_strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define zf_strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define zf_strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

// Screen width
#define SRPrimaryStageScreenWidth     [[UIScreen mainScreen] bounds].size.width
// Screen height
#define SRPrimaryStageScreenHeight    [[UIScreen mainScreen] bounds].size.height


// deprecated
#ifndef weakify
#if DEBUG
#if __has_feature(objc_arc)
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef strongify
#if DEBUG
#if __has_feature(objc_arc)
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

