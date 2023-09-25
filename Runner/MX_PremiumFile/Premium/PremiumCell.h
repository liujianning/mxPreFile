//
//  PremiumCell.h
//  Movie
//
//  Created by wmz on 2023/2/21.
//

#import "BaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface PremiumCell : BaseCollectionViewCell
@property (nonatomic,strong) UIImageView *icoIV;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *monthLabel;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) CAGradientLayer *gradientLayer;
@end

NS_ASSUME_NONNULL_END
