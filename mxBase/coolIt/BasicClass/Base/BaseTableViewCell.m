//
//  BaseTableViewCell.m
//  Movie
//
//  Created by wmz on 2023/2/11.
//

#import "BaseTableViewCell.h"
@implementation BaseTableViewCell

+ (instancetype)ht_cellWithTableView:(UITableView *)tableView {
    return [self ht_cellWithTableView:tableView andIdentifier:nil];
}

+ (instancetype)ht_cellWithTableView:(UITableView *)tableView andIdentifier:(NSString *_Nullable)identifier {
    if (!identifier) {
        identifier = [NSString stringWithFormat:@"%@",NSStringFromClass(self)];
    }
    BaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor ht_colorWithHexString:@"#111219"];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self ht_addCellSubViews];
        [self setNeedsUpdateConstraints];
    }
    return self;
}

- (void)ht_addCellSubViews {
}

- (void)ht_updateCellWithData{
    
}

- (void)updateConstraints {
    [self lgjeropj_updateConstraints];
    [super updateConstraints];
}

- (void)lgjeropj_updateConstraints
{
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

@end
