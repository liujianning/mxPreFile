//
//  HTFamilyTableViewCell.m
//  Merriciya
//
//  Created by 昊天 on 2023/5/29.
//

#import "HTFamilyTableViewCell.h"

@interface HTFamilyTableViewCell ()
@property (nonatomic, assign) NSInteger var_curIndex;
@end
@implementation HTFamilyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self ht_setupUI];
    }
    return self;
}

- (void)ht_setupUI {
    self.var_headerImgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.var_headerImgView];
    [self.var_headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.width.height.mas_equalTo(50);
    }];
    self.var_headerImgView.layer.masksToBounds = YES;
    self.var_headerImgView.layer.cornerRadius = 25;
    
    self.var_nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.var_nameLabel];
    [self.var_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.var_headerImgView);
        make.bottom.mas_equalTo(self.var_headerImgView.mas_centerY);
        make.left.mas_equalTo(self.var_headerImgView.mas_right).offset(10);
    }];
    self.var_nameLabel.font = [UIFont systemFontOfSize:16];
    self.var_nameLabel.textColor = [UIColor whiteColor];
    
    self.var_titleLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.var_titleLabel];
    [self.var_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.var_headerImgView.mas_centerY);
        make.bottom.mas_equalTo(self.var_headerImgView);
        make.left.mas_equalTo(self.var_headerImgView.mas_right).offset(10);
    }];
    self.var_titleLabel.font = [UIFont systemFontOfSize:14];
    self.var_titleLabel.textColor = [UIColor lightGrayColor];
    
    self.var_diamondView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:self.var_diamondView];
    [self.var_diamondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.var_nameLabel);
        make.left.mas_equalTo(self.var_nameLabel.mas_right).offset(10);
        make.width.height.mas_equalTo(20);
    }];
    self.var_diamondView.hidden = YES;
    
    self.var_deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.var_deleteButton];
    [self.var_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).offset(-20);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.width.mas_equalTo(40);
    }];
    [self.var_deleteButton setImage:[UIImage imageNamed:@"icon_search_close"] forState:UIControlStateNormal];
    [self.var_deleteButton addTarget:self action:@selector(ht_deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.var_deleteButton.hidden = YES;
    
    self.var_lineView = [[UIView alloc] init];
    [self.contentView addSubview:self.var_lineView];
    [self.var_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.var_headerImgView.mas_right).offset(10);
        make.right.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(0.5);
    }];
    self.var_lineView.backgroundColor = [UIColor lightGrayColor];
}
- (void)lgjeropj_updateCellWithData:(ZQFamilyAccountModel*)model andIndex:(NSInteger)index{
    self.var_curIndex = index;
    UserModel *loginUser = HTManage.sharedInstance.model2;
    
    [self.var_headerImgView ht_setImageWithURL:[NSURL URLWithString:model.var_face]];
    
    if (model.var_uid.intValue == loginUser.var_uid.intValue) {
        self.var_nameLabel.text = [NSString stringWithFormat:@"%@(%@)", model.var_name,LocalString(@"ME", nil)];
        self.var_deleteButton.hidden = YES;
    } else {
        self.var_nameLabel.text = model.var_name;
        self.var_deleteButton.hidden = (model.var_master.intValue == 1) ?YES :NO;
    }
    
    if (model.var_master.intValue == 1) {
        self.var_diamondView.hidden = NO;
        if ([[HTManage sharedInstance] ht_checkSub]) {
            [self.var_diamondView ht_setImageWithURL:[LKFPrivateFunction htMethodImageUrlFromNumber:29]];
        } else {
            [self.var_diamondView ht_setImageWithURL:[LKFPrivateFunction htMethodImageUrlFromNumber:30]];
        }
        self.var_titleLabel.text = LocalString(@"Organizer", nil);
    } else {
        self.var_diamondView.hidden = YES;
        self.var_titleLabel.text = LocalString(@"Member", nil);
    }
}
- (void)ht_deleteButtonAction:(UIButton *)sender {
    if (self.delegate &&[self.delegate respondsToSelector:@selector(ht_familyMemberCellClick:)]) {
        [self.delegate ht_familyMemberCellClick:self.var_curIndex];
    }
}
@end
