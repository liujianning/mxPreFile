//
//  HTFamilySectionView.m
 
//
//  Created by 李雪健 on 2023/7/12.
//

#import "HTFamilySectionView.h"

@implementation HTFamilySectionView

- (instancetype)initWithType:(NSInteger)type count:(NSInteger)count
{
    self = [super init];
    if (self) {
        UIButton *var_button = [UIButton buttonWithType:UIButtonTypeCustom];
        var_button.tag = type;
        var_button.backgroundColor = [UIColor whiteColor];
        [var_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        var_button.layer.masksToBounds = YES;
        var_button.layer.cornerRadius = 10.0;
        [self addSubview:var_button];
        [var_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(HTWidth *0.75);
        }];
        if (type == 0) {
            NSString *var_titleString = [NSString stringWithFormat:@"%@(%ld)",LocalString(@"Add family members", nil), count];
            [var_button setTitle:var_titleString forState:UIControlStateNormal];
        } else if (type == 1) {
            [var_button setTitle:LocalString(@"Quit Family Plan", nil) forState:UIControlStateNormal];
        } else {
            [var_button setTitle:LocalString(@"Buy Family Plan", nil) forState:UIControlStateNormal];
        }
        [var_button addTarget:self action:@selector(ht_buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)ht_buttonAction:(UIButton *)sender
{
    if (self.BLOCK_buttonActionBlock) {
        self.BLOCK_buttonActionBlock(sender.tag);
    }
}

@end
