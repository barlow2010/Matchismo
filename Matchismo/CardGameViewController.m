//
//  CardGameViewController.m
//  Matchismo
//
//  Created by zhangjifeng on 14-5-12.
//  Copyright (c) 2014年 abc. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayCard.h"
#import "PlayCardDeck.h"

@interface CardGameViewController ()


@property (weak, nonatomic) IBOutlet UILabel *filpCountLabel;
@property(nonatomic) int flipCount;
@property(strong, nonatomic) Deck *playDeck;
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
    if (self.playDeck == nil) {
        self.playDeck = [[PlayCardDeck alloc]init];
    }
    if ([sender.currentTitle length]) {
        UIImage *image = [UIImage imageNamed:@"cardback"];
        [sender setBackgroundImage:image forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        UIImage *image = [UIImage imageNamed:@"cardfront"];
        [sender setBackgroundImage:image forState:UIControlStateNormal];
        Card *card = [self.playDeck drawRandomCard];
        [sender setTitle:card.contents forState:UIControlStateNormal];
    }
    self.flipCount ++;
    
}

@end
