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
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property(strong, nonatomic) Deck *deck;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (nonatomic) uint matchCount;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc]initWithCount:[self.cardButtons count]
                                             usingDeck:self.deck];
    }
    return _game;
}

- (Deck *)deck
{
    if(!_deck) _deck = [self createDeck];
    return _deck;
}

- (Deck *)createDeck
{
    return [[PlayCardDeck alloc]init];
}
- (uint)matchCount
{
    if (!_matchCount) {
        self.matchCount = 2;
    }
    return _matchCount;
}

- (IBAction)touchMatchCountButton:(id)sender {
    if (self.matchCount == 2) {
        self.matchCount = 3;
    } else {
        self.matchCount = 2;
    }
    [self.game setMatchCount:self.matchCount];
    NSString *title = [[NSString alloc]initWithFormat:@"MatchCount:%d",self.matchCount];
    [sender setTitle:title forState:UIControlStateNormal];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    int index = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:index];
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int index = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardIndex:index];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage: [self backgroundForCard:card]forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [[NSString alloc]initWithFormat:@"Score:%d", self.game.score];
    self.tipLabel.text = [self.game tipForUser];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}
@end
