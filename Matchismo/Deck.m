//
//  Deck.m
//  Matchismo
//
//  Created by zhangjifeng on 14-5-12.
//  Copyright (c) 2014年 abc. All rights reserved.
//

#import "Deck.h"

@interface Deck ()
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck

- (NSMutableArray *)cards
{
    if (_cards == nil) {
        _cards = [NSMutableArray new];
//        _cards = [[NSMutableArray alloc]init];
    }
    return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cards insertObject:card atIndex:0];
    } else {
        [self.cards addObject:card];
    }
}

- (void) addCard:(Card *)card
{
    [self addCard:card atTop:NO];
}

- (Card *)drawRandomCard
{
    Card *card = nil;
    if ([self.cards count]) {
        unsigned randIndex = arc4random()%[self.cards count];
        card = [self.cards objectAtIndex:randIndex];
        [self.cards removeObjectAtIndex:randIndex];
    }
    
    return card;
}

@end
