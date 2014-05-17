//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by zhangjifeng on 14-5-17.
//  Copyright (c) 2014年 abc. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

static const int CONST_TO_CHOSE = 1;
static const int CONST_NO_MATCH = 2;
static const int CONST_MATCH = 4;

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

- (instancetype)initWithCount:(NSUInteger)count
                   usingDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        if (count < 2) { // count is so small
            self = nil;
        }else {
            for (int i=0; i<count; i++) {
                Card * card = [deck drawRandomCard];
                if (card) {
                    [self.cards addObject:card];
                } else {
                    self = nil;
                    break;
                }
            }
        }
    }
    return self;
}

- (Card *)cardIndex:(NSUInteger)index
{
    return index < [self.cards count] ? self.cards[index] : nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card * card = [self cardIndex:index];
    if (card && !card.isMatched) {
        if (!card.isChosen) {
            for (Card * otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        card.matched = YES;
                        otherCard.matched = YES;
                        self.score += matchScore*CONST_MATCH;
                    } else {
                        card.chosen = NO;
                        otherCard.chosen = NO;
                        self.score -= CONST_NO_MATCH;
                    }
                    break;
                }
            }
            card.chosen = YES;
            self.score -= CONST_TO_CHOSE;
        } else {
            card.chosen = NO;
        }
    }
    NSLog(@"chooseCardAtIndex = %d", card.chosen);
}
@end
