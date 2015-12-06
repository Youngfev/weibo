//
//  HWSearchBar.m
//  微博项目
//
//  Created by Youngfev on 15/12/5.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWSearchBar.h"

@implementation HWSearchBar

-(id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入搜索条件";
        
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        self.width = [UIScreen mainScreen].bounds.size.width;
        self.height = 40;
        
        UIImageView *searchIcon = [[UIImageView alloc]init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.width = 30;
        searchIcon.height = 30;
        searchIcon.contentMode = UIViewContentModeCenter;
        
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

+(instancetype)searchBar
{
    return [[self alloc] init];
}

@end
