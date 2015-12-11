//
//  HWIconView.m
//  微博项目
//
//  Created by Youngfev on 15/12/11.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWIconView.h"
#import "HWUser.h"
#import "UIImageView+WebCache.h"

@interface HWIconView ()
@property (nonatomic,weak) UIImageView *verifIcon;

@end

@implementation HWIconView

-(UIImageView *)verifIcon
{
    if (!_verifIcon) {
        
        UIImageView *verifIcon = [[UIImageView alloc] init];
        [self addSubview:verifIcon];
        self.verifIcon = verifIcon;
    }
    return _verifIcon;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
    
}

-(void)setUser:(HWUser *)user
{
    _user = user;
    
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    switch (user.verified_type) {
        case HWUserVerifiedPersonal:
            self.verifIcon.hidden = YES;
            self.verifIcon.image = [UIImage imageNamed:@"avatar_vip"];
            break;
        case HWUserVerifiedOrgEnterprice:
        case HWUserVerifiedOrgMedia:
        case HWUserVerifiedOrgWebsite: // 官方认证
            self.verifIcon.hidden = NO;
            self.verifIcon.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
            
        case HWUserVerifiedDaren: // 微博达人
            self.verifIcon.hidden = NO;
            self.verifIcon.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
            
        default:
            self.verifIcon.hidden = YES; // 当做没有任何认证
            break;
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.verifIcon.size = self.verifIcon.image.size;
    CGFloat scale = 0.6;
    self.verifIcon.x = self.width - self.verifIcon.width * scale;
    self.verifIcon.y = self.height - self.verifIcon.height * scale;
}
@end
