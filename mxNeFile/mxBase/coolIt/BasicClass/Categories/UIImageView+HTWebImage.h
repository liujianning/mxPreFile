//
//  UIImageView+HTWebImage.h
 
//
//  Created by 李雪健 on 2023/7/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (HTWebImage)

- (void)ht_setImageWithURL:(NSURL *)url;

- (void)ht_setImageWithURL:(NSURL *)url placeholder:(UIImage *)image;

- (void)ht_setImageWithURL:(NSURL *)url andComplete:(void(^)(UIImage  * _Nullable image))completed;

@end

NS_ASSUME_NONNULL_END
