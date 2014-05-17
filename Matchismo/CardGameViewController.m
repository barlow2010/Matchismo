//
//  CardGameViewController.m
//  Matchismo
//
//  Created by zhangjifeng on 14-5-12.
//  Copyright (c) 2014年 abc. All rights reserved.
//

#import "CardGameViewController.h"

@interface CardGameViewController ()


@property (weak, nonatomic) IBOutlet UILabel *filpCountLabel;
@property(nonatomic) int flipCount;
@end

@implementation CardGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setFlipCount:(int)count
{
    _flipCount = count;
    [self.filpCountLabel setText:[NSString stringWithFormat:@"Flip:%d",self.flipCount]];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    if ([[sender currentTitle]isEqualToString:@""]) {
        UIImage *image = [UIImage imageNamed:@"cardfront"];
        [sender setBackgroundImage:image forState:UIControlStateNormal];
        [sender setTitle:@"A♣︎" forState:UIControlStateNormal];
    } else {
        UIImage *image = [UIImage imageNamed:@"cardback"];
        [sender setBackgroundImage:image forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    }
    self.flipCount ++;
    
}

@end
