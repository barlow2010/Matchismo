//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by zhangjifeng on 14-5-17.
//  Copyright (c) 2014年 abc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSUInteger matchCount;
- (instancetype)initWithCount:(NSUInteger)count
                   usingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardIndex:(NSUInteger)index;
@end
