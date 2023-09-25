//
//  BaseView.m
//  Movie
//
//  Created by wmz on 2023/2/9.
//

#import "BaseView.h"

@implementation BaseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self ht_commonInit];
    }
    return self;
}

- (void)ht_bindViewModel {
}

- (void)ht_setupViews {
    
}

- (void)ht_getNewData{
    
}

- (BOOL)ht_getNewDataFirst{
    return YES;
}

- (void)ht_commonInit {
    [self ht_setupViews];
    [self ht_bindViewModel];
    if (self.ht_getNewDataFirst) {
        [self ht_getNewData];
    }
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [self lgjeropj_updateConstraints];
    [super updateConstraints];
}

- (void)lgjeropj_updateConstraints {}

@end
