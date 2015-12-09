//
//  HWStatusCell.m
//  微博项目
//
//  Created by Youngfev on 15/12/9.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWStatusCell.h"

@implementation HWStatusCell


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *reuseId = @"reuseId";
    HWStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[HWStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId];
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //
    }
    return nil;
}

@end
