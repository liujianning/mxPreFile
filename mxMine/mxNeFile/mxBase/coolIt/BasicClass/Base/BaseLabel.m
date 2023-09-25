//
//  BaseLabel.m
//  Movie
//
//  Created by wmz on 2023/2/11.
//

#import "BaseLabel.h"

@implementation BaseLabel

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    UIEdgeInsets insets = self.ht_edgeInsets;
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, insets)
                    limitedToNumberOfLines:numberOfLines];

    rect.origin.x -= insets.left;
    rect.origin.y -= insets.top;
    rect.size.width += (insets.left + insets.right);
    rect.size.height += (insets.top + insets.bottom);
    return rect;
}

@end
