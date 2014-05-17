//
//  CardGameViewController.m
//  Matchismo
//
//  Created by zhangjifeng on 14-5-12.
//  Copyright (c) 2014年 abc. All rights reserved.
//

#import "CardGameViewController.h"
#import "Card.h"
#import "PlayCardDeck.h"

@interface CardGameViewController ()


@property (weak, nonatomic) IBOutlet UILabel *filpCountLabel;
@property(nonatomic) int flipCount;
@property(strong, nonatomic) Deck *deck;
@end

@implementation CardGameViewController

- (Deck *)deck
{
    if(!_deck) _deck = [self createDeck];
    return _deck;
}

- (Deck *)createDeck
{
    return [[PlayCardDeck alloc]init];
}
- (void)setFlipCount:(int)count
{
    _flipCount = count;
    [self.filpCountLabel setText:[NSString stringWithFormat:@"Flip:%d",self.flipCount]];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    if (self.deck == nil) {
        self.deck = [[PlayCardDeck alloc]init];
    }
    if ([sender.currentTitle length]) {
        UIImage *image = [UIImage imageNamed:@"cardback"];
        [sender setBackgroundImage:image forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
        self.flipCount ++;
    } else {
        Card *card = [self.deck drawRandomCard];
        if(card) {
            UIImage *image = [UIImage imageNamed:@"cardfront"];
            [sender setBackgroundImage:image forState:UIControlStateNormal];
            [sender setTitle:card.contents forState:UIControlStateNormal];
            self.flipCount ++;
        }
    }
    
}

@end
