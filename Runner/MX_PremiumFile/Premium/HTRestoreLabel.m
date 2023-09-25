//
//  HTRestoreLabel.m
 
//
//  Created by 李雪健 on 2023/7/11.
//

#import "HTRestoreLabel.h"
#import "IAPManager.h"

@implementation HTRestoreLabel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self lgjeropj_addSubViews];
    }
    return self;
}

- (void)lgjeropj_addSubViews {

    NSString *restoreStr = LocalString(@"tap Restore.", nil);
    NSMutableAttributedString *mstr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",LocalString(@"If the ad still appears after purchase,", nil),restoreStr]];
    mstr.yy_color = [UIColor ht_colorWithHexString:@"#CCCCCC"];
    mstr.yy_font = [UIFont systemFontOfSize:12];
    [mstr yy_setFont:[UIFont systemFontOfSize:12] range:[mstr.string rangeOfString:restoreStr]];
    [mstr yy_setColor:[UIColor ht_colorWithHexString:@"#FFFFFF"] range:[mstr.string rangeOfString:restoreStr]];
    [mstr yy_setUnderlineStyle:NSUnderlineStyleSingle range:[mstr.string rangeOfString:restoreStr]];
    [mstr yy_setTextHighlightRange:[mstr.string rangeOfString:restoreStr] color:[UIColor ht_colorWithHexString:@"#FFFFFF"] backgroundColor:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        [[IAPManager sharedInstance] ht_restorePurchaseCompleteHandle:^(id  _Nullable data) {
            if (data) {
                [HTManage.sharedInstance ht_updateVipWithBlock:^(PayModel * _Nullable var_payModel) {} source:@"2"];
            }
        }];
    }];
    mstr.yy_alignment = NSTextAlignmentCenter;
    self.attributedText = mstr;
}

@end
