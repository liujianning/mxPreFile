//
//  UIButton+ImagePosition.m
 
//  Created by admin on 2019/8/21.
//  Copyright © 2019年 admin. All rights reserved.
//

#import "UIButton+ImagePosition.h"
#import "YYWebImage.h"

@implementation UIButton (ImagePosition)
/*** 知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的， 如果只有title，那它上下左右都是相对于button的，image也是一样；如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。*/
- (void)ht_layoutButtonWithImagePositionStyle:(ENUM_HTButtonImagePositionStyle)style andImageTitleSpace:(CGFloat)space{
    
    [self setTitle:self.currentTitle forState:UIControlStateNormal];
    [self setImage:self.currentImage forState:UIControlStateNormal];

    CGFloat imageWidth = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    CGFloat labelWidth = [self.titleLabel.text sizeWithFont:self.titleLabel.font].width;
    CGFloat labelHeight = [self.titleLabel.text sizeWithFont:self.titleLabel.font].height;
#pragma clang diagnostic pop
    // image中心移动的x距离
    CGFloat imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2;
    // image中心移动的y距离
    CGFloat imageOffsetY = imageHeight / 2 + space / 2;
    // label中心移动的x距离
    CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2;
    // label中心移动的y距离
    CGFloat labelOffsetY = labelHeight / 2 + space / 2;
    if (labelWidth+space+imageWidth > self.frame.size.width && self.frame.size.width > 0) {
        labelWidth = self.frame.size.width - space - imageWidth;
    }
    CGFloat tempWidth = MAX(labelWidth, imageWidth);
    CGFloat changedWidth = labelWidth + imageWidth - tempWidth;
    CGFloat tempHeight = MAX(labelHeight, imageHeight);
    CGFloat changedHeight = labelHeight + imageHeight + space - tempHeight;
    
    switch (style) {
        case ENUM_HTButtonImagePositionStyleLeft:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -space/2, 0, space/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, space/2, 0, -space/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, space/2, 0, space/2);
            break;
        case ENUM_HTButtonImagePositionStyleRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + space/2, 0, -(labelWidth + space/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -(imageWidth + space/2), 0, imageWidth + space/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, space/2, 0, space/2);
            break;
        case ENUM_HTButtonImagePositionStyleTop:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(imageOffsetY, -changedWidth/2, changedHeight-imageOffsetY, -changedWidth/2);
            break;
        case ENUM_HTButtonImagePositionStyleBottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(changedHeight-imageOffsetY, -changedWidth/2, imageOffsetY, -changedWidth/2);
            break;
        default:
            break;
    }
}

- (void)ht_setImageWithURL:(NSURL *)url forState:(UIControlState)state
{
    [self yy_setImageWithURL:url forState:state placeholder:nil];
}

- (void)ht_setImageWithURL:(NSURL *)url forState:(UIControlState)state andComplete:(void (^)(UIImage * _Nullable))completed
{
    [self yy_setImageWithURL:url forState:state placeholder:nil options:0 completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (completed) completed(image);
    }];
}

- (void)ht_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state
{
    [self yy_setBackgroundImageWithURL:url forState:state placeholder:nil];
}

- (void)ht_setBackgroundImageWithURL:(NSURL *)url forState:(UIControlState)state andComplete:(void (^)(UIImage * _Nullable))completed
{
    [self yy_setBackgroundImageWithURL:url forState:state placeholder:nil options:0 completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        if (completed) completed(image);
    }];
}

@end
