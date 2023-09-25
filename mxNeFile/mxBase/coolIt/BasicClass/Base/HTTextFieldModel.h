//
//  HTTextFieldModel.h
 
//
//  Created by 李雪健 on 2023/7/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol HTTextFieldModelDelegate <NSObject>

@optional
- (void)lgjeropj_textFieldDidEndEditing:(UITextField *)textField;
- (BOOL)lgjeropj_textFieldShouldReturn:(UITextField *)textField;
- (void)lgjeropj_textFieldDidBeginEditing:(UITextField *)textField;
- (BOOL)lgjeropj_textFieldShouldClear:(UITextField *)textField;

@end

@interface HTTextFieldModel : NSObject <UITextFieldDelegate>

@property (nonatomic, weak) id <HTTextFieldModelDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
