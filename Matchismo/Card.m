//
//  Card.m
//  Matchismo
//
//  Created by zhangjifeang on 14-5-12.
//  Copyright (c) 2014年 abc. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    for (Card *card in otherCards) {
        if([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}
@end
