

#import <UIKit/UIKit.h>

typedef void (^SRDownLoadDataCallBack)(NSData *data, NSError *error);
typedef void (^SRDownloadProgressBlock)(unsigned long long total, unsigned long long current);

@interface SRImageDownloader : NSObject<NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDownloadTask *task;

@property (nonatomic, assign) unsigned long long totalLength;
@property (nonatomic, assign) unsigned long long currentLength;

@property (nonatomic, copy) SRDownloadProgressBlock progressBlock;
@property (nonatomic, copy) SRDownLoadDataCallBack callbackOnFinished;

- (void)startDownloadImageWithUrl:(NSString *)url
                         progress:(SRDownloadProgressBlock)progress
                         finished:(SRDownLoadDataCallBack)finished;

@end

typedef void (^SRImageBlock)(UIImage *image);

@interface UIImageView (SRCache)

@property (nonatomic, copy) SRImageBlock completion;

@property (nonatomic, strong) SRImageDownloader *imageDownloader;

@property (nonatomic, assign) NSUInteger attemptToReloadTimesForFailedURL;

@property (nonatomic, assign) BOOL shouldAutoClipImageToViewSize;

- (void)setImageWithURLString:(NSString *)url placeholderImageName:(NSString *)placeholderImageName;

- (void)setImageWithURLString:(NSString *)url placeholder:(UIImage *)placeholderImage;

- (void)setImageWithURLString:(NSString *)url
                  placeholder:(UIImage *)placeholderImage
                   completion:(void (^)(UIImage *image))completion;

- (void)setImageWithURLString:(NSString *)url
         placeholderImageName:(NSString *)placeholderImageName
                   completion:(void (^)(UIImage *image))completion;
@end
