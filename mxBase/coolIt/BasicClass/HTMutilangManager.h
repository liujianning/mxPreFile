//
//  HTMutilangManager.h
//  Cubohue
//
//  Created by 昊天 on 2022/9/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HTMutilangManager : NSObject

+ (instancetype)sharedInstance;
- (void)lgjeropj_getLangWithNetwork;
- (void)lgjeropj_getLangfileData;
- (NSString *)lgjeropj_stringWithKid:(id)text;
@end

NS_ASSUME_NONNULL_END
