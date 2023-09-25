//
//  HTTableViewModel.m
 
//
//  Created by 李雪健 on 2023/7/13.
//

#import "HTTableViewModel.h"

@implementation HTTableViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(lgjeropj_numberOfSectionsInTableView:)]) {
        return [self.delegate lgjeropj_numberOfSectionsInTableView:tableView];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(lgjeropj_tableView:andNumberOfRowsInSection:)]) {
        return [self.delegate lgjeropj_tableView:tableView andNumberOfRowsInSection:section];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(lgjeropj_tableView:andCellForRowAtIndexPath:)]) {
        return [self.delegate lgjeropj_tableView:tableView andCellForRowAtIndexPath:indexPath];
    }
    return [[UITableViewCell alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(lgjeropj_tableView:andSelectRowAtIndexPath:)]) {
        [self.delegate lgjeropj_tableView:tableView andSelectRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(lgjeropj_tableView:andHeightForRowAtIndexPath:)]) {
        return [self.delegate lgjeropj_tableView:tableView andHeightForRowAtIndexPath:indexPath];
    }
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(lgjeropj_tableView:andHeightForHeaderInSection:)]) {
        return [self.delegate lgjeropj_tableView:tableView andHeightForHeaderInSection:section];
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(lgjeropj_tableView:andViewForHeaderInSection:)]) {
        return [self.delegate lgjeropj_tableView:tableView andViewForHeaderInSection:section];
    }
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(lgjeropj_tableView:andHeightForFooterInSection:)]) {
        return [self.delegate lgjeropj_tableView:tableView andHeightForFooterInSection:section];
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(lgjeropj_tableView:andViewForFooterInSection:)]) {
        return [self.delegate lgjeropj_tableView:tableView andViewForFooterInSection:section];
    }
    return [[UIView alloc] init];
}


@end
