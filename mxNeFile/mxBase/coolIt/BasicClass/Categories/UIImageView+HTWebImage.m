//
//  UIImageView+HTWebImage.m
 
//
//  Created by 李雪健 on 2023/7/6.
//

#import "UIImageView+HTWebImage.h"
#import "YYWebImage.h"

@implementation UIImageView (HTWebImage)

- (void)ht_setImageWithURL:(NSURL *)url
{
    [self yy_setImageWithURL:url placeholder:nil];
}

- (void)ht_setImageWithURL:(NSURL *)url placeholder:(UIImage *)image
{
    [self yy_setImageWithURL:url placeholder:image];
}

- (void)ht_setImageWithURL:(NSURL *)url andComplete:(void (^)(UIImage * _Nullable))completed
{
    [self yy_setImageWithURL:url placeholder:nil options:0 completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (completed) completed(image);
    }];
}

@end
