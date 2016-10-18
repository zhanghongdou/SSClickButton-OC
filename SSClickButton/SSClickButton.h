//
//  SSClickButton.h
//  SSClickButton
//
//  Created by haohao on 16/10/18.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TransferNumberBlock)(NSString *number);
@interface SSClickButton : UIView

@property (nonatomic, copy)TransferNumberBlock transferNumberblock;

//设置边框颜色
@property (nonatomic, strong) UIColor *bordColor;
//设置显示数字的字体大小
@property (nonatomic, assign) NSInteger fontSize;
//设置按钮的背景图片和title，字体大小
-(void)setSubtractClickButtonWithBackGroundImage:(UIImage *)subtractImage withSubtractTitle:(NSString *)subtractTitle  withAddButtonBackGroundImage:(UIImage *)addImage withAddTitle:(NSString *)addTitle withButtonFontSize:(NSInteger)fontSize;
//设置按钮的图片
-(void)setSubtractClickButtonWithForeImage:(UIImage *)subtractImage withAddButtonForeImage:(UIImage *)addImage;

+(instancetype)sharedClickButtonWithFrame:(CGRect)frame;
@end
