//
//  HTFamilyBottomView.m
 
//
//  Created by 李雪健 on 2023/7/12.
//

#import "HTFamilyBottomView.h"

@implementation HTFamilyBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self lgjeropj_addSubViews];
    }
    return self;
}

- (void)lgjeropj_addSubViews
{
    UILabel *var_whatButton = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, HTWidth, 40)];
    [self addSubview:var_whatButton];
    var_whatButton.textColor = [UIColor grayColor];
    var_whatButton.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *whatAttString = [[NSMutableAttributedString alloc] initWithString:LocalString(@"What is a family package?", nil)];
    [whatAttString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, whatAttString.string.length)];
    var_whatButton.attributedText = whatAttString;
    
    UILabel *var_upgradeButton = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, HTWidth, 40)];
    [self addSubview:var_upgradeButton];
    var_upgradeButton.textColor = [UIColor grayColor];
    var_upgradeButton.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *upgradeAttString = [[NSMutableAttributedString alloc] initWithString:LocalString(@"Upgrade to family package?", nil)];
    [upgradeAttString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, upgradeAttString.string.length)];
    var_upgradeButton.attributedText = upgradeAttString;
}

@end
