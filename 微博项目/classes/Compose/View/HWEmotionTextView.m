//
//  HWEmotionTextView.m
//  微博项目
//
//  Created by Youngfev on 15/12/15.
//  Copyright © 2015年 Youngfev. All rights reserved.
//

#import "HWEmotionTextView.h"
#import "HWEmotion.h"
#import "HWEmotionAttachment.h"


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
        HWEmotionAttachment *attch = [[HWEmotionAttachment alloc] init];
        attch.emotion = emotion;
        CGFloat attchWH = self.font.lineHeight;
        attch.bounds = CGRectMake(0, -4, attchWH, attchWH);
//        attch.image = [UIImage imageNamed:emotion.png];
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];
        
        //拼接新的图片
        //        [attributedText appendAttributedString:imageStr];
        //获得光标的位置
        NSUInteger loc = self.selectedRange.location;
//        [attributedText insertAttributedString:imageStr atIndex:loc];
        [attributedText replaceCharactersInRange:self.selectedRange withAttributedString:imageStr];
        
        [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];
        self.attributedText = attributedText;
        
        self.selectedRange = NSMakeRange(loc + 1, 0);
    }
}

-(NSString *)fullText
{
    NSMutableString *fullText = [NSMutableString string];
    
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        
//        HWLog(@"%@",attrs);
        HWEmotionAttachment *attach = attrs[@"NSAttachment"];
        
        if (attach) {
            [fullText appendString:attach.emotion.chs];
        }else{
            NSAttributedString *str = [self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:str.string];
        }
    }];
    return fullText;
}

@end
