//
//  PlayCardDeck.m
//  Matchismo
//
//  Created by zhangjifeng on 14-5-12.
//  Copyright (c) 2014年 abc. All rights reserved.
//

#import "PlayCardDeck.h"
#import "PlayCard.h"

@implementation PlayCardDeck

-(instancetype)init
{
    self = [super init];
    if(self) {
        for (NSString *suit in [PlayCard validSuit]) {
            for (NSUInteger rank = 1; rank <= [PlayCard maxRank]; rank++) {
                PlayCard *card = [[PlayCard alloc]init];
                card.suit = suit;
                card.rank = rank;
                [self addCard:card];
            }
        }
    }
    return self;
}
@end
