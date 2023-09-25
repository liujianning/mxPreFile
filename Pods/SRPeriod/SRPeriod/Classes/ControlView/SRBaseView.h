//
//  SRAdView.h
//  SRPeriod
//
//  Created by admin on 2023/5/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SRBaseView : UIView

@property (nonatomic, copy) void (^block) (id data);

@end

NS_ASSUME_NONNULL_END
