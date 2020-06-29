//
//  ViewController.m
//  RainbowText
//
//  Created by edz on 2020/6/29.
//  Copyright © 2020 李畅. All rights reserved.
//

#import "ViewController.h"
#define kMColor(r,g,b,a) [UIColor colorWithRed: r /255.0 green: g /255.0 blue: b /255.0 alpha: a]
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString * str = [NSString new];
    str = _textView.text;
    _textView.attributedText = [self rainbowString:str Colors:[self rainBow]];
}

- (UIColor *)gridientColor:(UIColor *)startColor endColor:(UIColor *)endColor jump:(CGFloat)ju{
    CGFloat R,G,B,A;
    CGFloat startR,startG,startB,startA,endR,endG,endB,endA;

    [startColor getRed:&startR green:&startG blue:&startB alpha:&startA];
    [endColor getRed:&endR green:&endG blue:&endB alpha:&endA];
    R = startR + (endR - startR) * ju;
    G = startG + (endG - startG) * ju;
    B = startB + (endB - startB) * ju;
    A = startA + (endA - startA) * ju;
//    NSLog(@"R:%0.lf G:%0.lf B:%0.lf JU:%lf",R * 255.0,G * 255.0,B *255.0, ju);
    return [UIColor colorWithRed:R green:G blue:B alpha:A];
}
//颜色配置
- (NSArray * )rainBow{
    return @[kMColor(233, 29, 32, 1.0),kMColor(249, 166, 24, 1.0),kMColor(110, 190, 69, 1.0),kMColor(1, 184, 242, 1.0),kMColor(0, 109, 184, 1.0)];
//    return @[kMColor(30,144,255, 1.0),kMColor(240, 123, 143, 1.0),kMColor(234, 84, 85, 1.0),kMColor(0, 64, 189, 1.0)];
}

#pragma mark - TextView Delegate
- (void)textViewDidChange:(UITextView *)textView{
    NSString * str = [NSString new];
    str = textView.text;
    textView.attributedText = [self rainbowString:str Colors:[self rainBow]];
}
#pragma mark - Data
- (NSMutableAttributedString * )rainbowString:(NSString *)editstr Colors:(NSArray *)colors{
 
    NSMutableAttributedString * rastr = [[NSMutableAttributedString alloc]initWithString:editstr];
    
    NSInteger space = editstr.length/(colors.count - 1);
    if(editstr.length % colors.count != 0)
        space += 1;
    for (int i  = 0; i < editstr.length; i++) {
        NSInteger spaceIndex = i % colors.count;
        NSInteger colorIdx = i/space;
        if(colorIdx + 1 == colors.count){
            break;
        }
        NSRange range = NSMakeRange(i, 1);
//        NSLog(@"ColorIndex:%ld,spaceIndex:%ld,number:%d \n",colorIdx,spaceIndex,i);
//        NSLog(@"字:%@",[editstr substringWithRange:range]);
        UIColor * startColor = colors[colorIdx];
        UIColor * endColor = colors[colorIdx + 1];
        CGFloat jump = (i%space *1.0)/(space * 1.0);
        [rastr setAttributes:@{NSForegroundColorAttributeName:[self gridientColor:startColor endColor:endColor jump:jump],NSFontAttributeName:[UIFont systemFontOfSize:18.0 weight:UIFontWeightMedium]} range:range];
    }
        
    return rastr;
    
}

@end
