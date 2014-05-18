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
@property (nonatomic, strong) NSString *tip;
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
                    matchScore *= CONST_MATCH * self.matchCount;
                    self.score += matchScore;
                    [self.chooseCards removeAllObjects];
                    self.tip = [[NSString alloc]initWithFormat:@"恭喜你，匹配成功，奖励%d分！",matchScore];
                } else {
                    [self setCards:self.chooseCards withChoosen:NO];
                    self.score -= CONST_NO_MATCH;
                    [self.chooseCards removeAllObjects];
                    self.tip = [[NSString alloc]initWithFormat:@"很遗憾，匹配失败，减%d分！",CONST_NO_MATCH];
                    card.chosen = YES;
                    [self.chooseCards addObject:card];
                }
            }else {
                card.chosen = YES;
                [self.chooseCards addObject:card];
                self.score -= CONST_TO_CHOSE;
                self.tip = [[NSString alloc]initWithFormat:@"翻开一张扑克牌，花费%d分！",CONST_TO_CHOSE];
            }
            
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

- (NSString *)tipForUser
{
    return self.tip;
}
@end
