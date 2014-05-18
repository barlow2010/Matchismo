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
@property (nonatomic, strong) NSMutableArray *chooseCards;

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

- (NSMutableArray *)chooseCards
{
    if (!_chooseCards) _chooseCards = [[NSMutableArray alloc]init];
    return _chooseCards;
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
    if (self) {
        self.matchCount = 2;
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
            if ([self.chooseCards count]+1 == self.matchCount) {
                int matchScore = [card match:self.chooseCards];
                if (matchScore) {
                    card.matched = YES;
                    card.chosen = YES;
                    [self setCards:self.chooseCards withMatched:YES];
                    self.score += matchScore * CONST_MATCH * self.matchCount;
                    [self.chooseCards removeAllObjects];
                    return;
                } else {
                    [self setCards:self.chooseCards withChoosen:NO];
                    self.score -= CONST_NO_MATCH;
                    [self.chooseCards removeAllObjects];
                }
            }
            card.chosen = YES;
            [self.chooseCards addObject:card];
            self.score -= CONST_TO_CHOSE;
            
        } else {
            card.chosen = NO;
        }
    }
}

- (void)setCards:(NSMutableArray *)cards withMatched:(BOOL)match
{
    for (Card *card in cards) {
        card.matched = match;
    }
}
- (void)setCards:(NSMutableArray *)cards withChoosen:(BOOL)choose
{
    for (Card *card in cards) {
        card.chosen = choose;
    }
}
@end
