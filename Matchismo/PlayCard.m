//
//  PlayCard.m
//  Matchismo
//
//  Created by zhangjifeng on 14-5-12.
//  Copyright (c) 2014年 abc. All rights reserved.
//

#import "PlayCard.h"

@implementation PlayCard

- (NSString *)contents
{
    NSArray * rankStrings = [PlayCard rankArray];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}
@synthesize suit = _suit;
+ (NSArray *)validSuit
{
    return @[@"♠", @"♥",@"♦",@"♣"];
}
- (void)setSuit:(NSString *)suit
{
    //♠♥♦♣
    NSArray *arraySuit = [PlayCard validSuit];
    if ([arraySuit containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankArray
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return [[PlayCard rankArray]count] - 1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayCard maxRank]) {
        _rank = rank;
    }
    
}
@end
