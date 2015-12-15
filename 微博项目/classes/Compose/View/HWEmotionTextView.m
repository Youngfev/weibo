//
//  HWEmotionTextView.m
//  微博项目
//
//  Created by Youngfev on 15/12/15.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWEmotionTextView.h"
#import "HWEmotion.h"

@implementation HWEmotionTextView

-(void)insertEmotion:(HWEmotion *)emotion
{
    if (emotion.code) {
        [self insertText:emotion.code.emoji];
    }else{
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
        
        //拼接原有的textView里面的内容k
        [attributedText appendAttributedString:self.attributedText];
        
        //加载图片
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
        CGFloat attchWH = self.font.lineHeight;
        attch.bounds = CGRectMake(0, -4, attchWH, attchWH);
        attch.image = [UIImage imageNamed:emotion.png];
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];
        
        //拼接新的图片
        //        [attributedText appendAttributedString:imageStr];
        //获得光标的位置
        NSUInteger loc = self.selectedRange.location;
        [attributedText insertAttributedString:imageStr atIndex:loc];
        
        self.selectedRange = NSMakeRange(loc + 1, 0);
        [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        self.attributedText = attributedText;
    }
}

@end
