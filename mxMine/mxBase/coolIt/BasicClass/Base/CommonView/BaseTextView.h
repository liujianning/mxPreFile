//
//  BaseTextView.h
//  Movie
//
//  Created by wmz on 2023/2/12.
//

#import "BaseView.h"
#import "PostCommon_Enum.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseTextView : BaseView
@property (nonatomic,copy)BLOCK_CustomViewBlock var_textChangeBlock;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,assign) CGFloat itemHeight;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *placeHolder;
@end

NS_ASSUME_NONNULL_END
