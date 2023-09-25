//
//  HTTextFieldModelDelegate.m
 
//
//  Created by 李雪健 on 2023/7/17.
//

#import "HTTextFieldModel.h"

@implementation HTTextFieldModel

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(lgjeropj_textFieldDidBeginEditing:)]) {
        [self.delegate lgjeropj_textFieldDidBeginEditing:textField];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(lgjeropj_textFieldDidEndEditing:)]) {
        [self.delegate lgjeropj_textFieldDidEndEditing:textField];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(lgjeropj_textFieldShouldReturn:)]) {
        return [self.delegate lgjeropj_textFieldShouldReturn:textField];
    }
    return NO;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(lgjeropj_textFieldShouldClear:)]) {
        return [self.delegate lgjeropj_textFieldShouldClear:textField];
    }
    return NO;
}

@end
