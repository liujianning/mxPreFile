//
//  PayModel.h
//  Movie
//
//  Created by wmz on 2023/3/17.
//

#import <Foundation/Foundation.h>
#import "PayLocalModel.h"
#import "PayServerModel.h"
#import "PayDeviceModel.h"
#import "PayFamilyModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PayModel : HTBaseModel

@property(nonatomic,strong) PayLocalModel *var_local;
@property(nonatomic,strong) PayServerModel *var_server;
@property(nonatomic,strong) PayDeviceModel *var_device;
@property(nonatomic,strong) PayFamilyModel *var_family;

@end

NS_ASSUME_NONNULL_END
