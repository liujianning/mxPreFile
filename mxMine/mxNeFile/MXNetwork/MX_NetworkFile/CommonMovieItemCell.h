//
//  CommonMovieItemCell.h
//  Movie
//
//  Created by wmz on 2023/2/12.
//

#import "BaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommonMovieItemCell : BaseCollectionViewCell
///专题id
@property (nonatomic,copy) NSString *var_movielist_id;
@property (nonatomic,copy) NSString *list_type;
@property (nonatomic,copy) NSString *var_source;
@property (nonatomic,assign) BOOL var_like;

@end

NS_ASSUME_NONNULL_END
