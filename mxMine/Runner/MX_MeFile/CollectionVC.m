//
//  CollectionVC.m
//  Movie
//
//  Created by wmz on 2023/2/13.
//

#import "CollectionVC.h"
#import "PostCommon_Config.h"
#import "HTMutilangManager.h"
#import "HTManage.h"

@interface CollectionVC ()

@end

@implementation CollectionVC
- (void)ht_setupViews{
    [super ht_setupViews];
    self.title = LocalString(@"Watch Later", nil);
}
- (void)ht_getWillData{
    self.dataArray = [NSMutableArray arrayWithArray:[HTManage.sharedInstance ht_getCollectDatasource]];
    [self.tableView ht_reloadData:NO];
}

- (void)ht_deleteAction{
    for (MovieModel *var_movieModel in self.dataArray) {
        if (var_movieModel.var_select && [HTManage.sharedInstance ht_checkCollect:var_movieModel.var_id]) {
            [HTManage.sharedInstance ht_saveCollectModel:var_movieModel andDele:YES];
        }
    }
    [self ht_getWillData];
    self.edit = !self.edit;
}
- (NSString *)source{
    return @"3";
}
@end
