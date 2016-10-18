//
//  SSClickButton.m
//  SSClickButton
//
//  Created by haohao on 16/10/18.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "SSClickButton.h"
@interface SSClickButton ()<UITextFieldDelegate>
{
    //累加的按钮
    UIButton *_addButton;
    //累减的按钮
    UIButton *_subtractButton;
    //长按的定时器
    NSTimer *_timer;
    //显示的输入框
    UITextField *_showTextField;
}
@end
@implementation SSClickButton
//MARK: -------init
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //创建界面的控件
        [self creatUI];
    }
    return self;
}

//MARK: ------- 兼容故事版xib搭建
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self creatUI];
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self creatUI];
    }
    return self;
}

//MARK: ------- 类方法创建
+(instancetype)sharedClickButtonWithFrame:(CGRect)frame
{
    return [[SSClickButton alloc]initWithFrame:frame];
}

-(void)creatUI
{
    self.backgroundColor = [UIColor whiteColor];
    _addButton = [self creatButtonWithTitle:@"+"];
    [self addSubview:_addButton];
    _subtractButton = [self creatButtonWithTitle:@"-"];
    [self addSubview:_subtractButton];
    [self creatShowTextField];
}

-(void)creatShowTextField
{
    _showTextField = [[UITextField alloc]init];
    _showTextField.text = @"1";
    _showTextField.delegate = self;
    _showTextField.font = [UIFont systemFontOfSize:15];
    _showTextField.keyboardType = UIKeyboardTypeNumberPad;
    _showTextField.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_showTextField];
}


-(UIButton *)creatButtonWithTitle:(NSString *)buttonTitle
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:buttonTitle forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
    [btn addTarget:self action:@selector(touchCancel:) forControlEvents:UIControlEventTouchUpOutside | UIControlEventTouchCancel | UIControlEventTouchUpInside];
    return btn;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _subtractButton.frame = CGRectMake(0, 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame));
    _addButton.frame = CGRectMake(CGRectGetWidth(self.frame) - CGRectGetHeight(self.frame), 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame));
    _showTextField.frame = CGRectMake(CGRectGetHeight(self.frame), 0, CGRectGetWidth(self.frame) - 2 * CGRectGetHeight(self.frame), CGRectGetHeight(self.frame));
}

//MARK: ------- 点击不送开的时候
-(void)touchDown:(UIButton *)sender
{
    [_showTextField resignFirstResponder];
    //创建定时器
    if (sender == _addButton) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.15f target:self selector:@selector(add) userInfo:nil repeats:YES];
    }else{
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.15f target:self selector:@selector(subtract) userInfo:nil repeats:YES];
    }
    if (_timer) {
        [_timer fire];
    }
}

//MARK: -------- 点击松开的时候
-(void)touchCancel:(UIButton *)sender
{
    //销毁定时器
    if (_timer.isValid) {
        [_timer invalidate];
        _timer = nil;
    }
}

//MARK: -------- UITextFieldDelegate
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSInteger number = [_showTextField.text integerValue];
    if (number <= 0) {
        textField.text = @"1";
    }
    if (self.transferNumberblock) {
        self.transferNumberblock(textField.text);
    }
    
}

//MARK: -------- 定时器的累加操作
- (void)add
{
    NSInteger number = [_showTextField.text integerValue] + 1;
    _showTextField.text = [NSString stringWithFormat:@"%ld",number];
    if (self.transferNumberblock) {
        self.transferNumberblock(_showTextField.text);
    }
}
//MARK: -------- 定时器的累减操作
- (void)subtract
{
    NSInteger number = [_showTextField.text integerValue] - 1;
    //这里控制显示的数量最小是1
    if (number > 0) {
        _showTextField.text = [NSString stringWithFormat:@"%ld",number];
    }else{
        //抖动动画
        [self shakeTheAnimation];
    }
    if (self.transferNumberblock) {
        self.transferNumberblock(_showTextField.text);
    }
}

-(void)shakeTheAnimation
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    CGFloat defaultPositonX = self.layer.position.x;
    animation.values = @[@(defaultPositonX - 10), @(defaultPositonX), @(defaultPositonX + 10)];
    animation.repeatCount = 3;
    animation.duration = 0.05;
    animation.autoreverses = YES;
    [self.layer addAnimation:animation forKey:@"shakeAnimation"];
}

//设置多种样式
//MARK: ------ 设置边框
-(void)setBordColor:(UIColor *)bordColor
{
    self.layer.borderColor = bordColor.CGColor;
    _addButton.layer.borderColor = bordColor.CGColor;
    _subtractButton.layer.borderColor = bordColor.CGColor;
    self.layer.borderWidth = 0.5;
    _addButton.layer.borderWidth = 0.5;
    _subtractButton.layer.borderWidth = 0.5;
}

//MARK: ------ 设置数字的大小
-(void)setFontSize:(NSInteger)fontSize
{
    _showTextField.font = [UIFont systemFontOfSize:fontSize];
}

-(void)setSubtractClickButtonWithBackGroundImage:(UIImage *)subtractImage withSubtractTitle:(NSString *)subtractTitle  withAddButtonBackGroundImage:(UIImage *)addImage withAddTitle:(NSString *)addTitle withButtonFontSize:(NSInteger)fontSize
{
    [_subtractButton setBackgroundImage:subtractImage forState:UIControlStateNormal];
    [_subtractButton setTitle:subtractTitle forState:UIControlStateNormal];
    _subtractButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    
    [_addButton setBackgroundImage:addImage forState:UIControlStateNormal];
    [_addButton setTitle:addTitle forState:UIControlStateNormal];
    _addButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
}

-(void)setSubtractClickButtonWithForeImage:(UIImage *)subtractImage withAddButtonForeImage:(UIImage *)addImage
{
    [_subtractButton setTitle:@"" forState:UIControlStateNormal];
    [_addButton setTitle:@"" forState:UIControlStateNormal];
    
    [_subtractButton setImage:subtractImage forState:UIControlStateNormal];
    [_addButton setImage:addImage forState:UIControlStateNormal];
}


-(void)dealloc
{
    if (_timer.isValid) {
        [_timer invalidate];
        _timer = nil;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
