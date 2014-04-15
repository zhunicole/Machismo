//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Nicole Zhu on 4/7/14.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *matchLabel;
@property (nonatomic) int flipCount;
@property (nonatomic) NSString *matchString;

@property (strong, nonatomic) Deck *deck;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@property (strong, nonatomic) NSMutableArray *cards;
@property (strong, nonatomic) PlayingCard *leftCard;
@property (strong, nonatomic) PlayingCard *rightCard;


@end

@implementation CardGameViewController

- (Deck *)deck {
    if(!_deck) _deck = [self createDeck];
    return _deck;
}

-(Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (NSMutableArray *)cards {
    if (!_cards) _cards = [self createCards];
    return _cards;
}
-(NSMutableArray *)createCards {
    _cards = [[NSMutableArray alloc] init];
    [_cards addObject:_rightCard]; //only added right card into array
    return _cards;
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    if (self.flipCount >= 104) {
        self.flipsLabel.text = [NSString stringWithFormat:@"Deck is out of cards."];
    }
}

- (void)setMatchString:(NSString*)matchString {
    _matchString = matchString;
    //update cards with rightcard
    if (self.leftCard && self.rightCard) {
        int match =[self.leftCard match:(self.cards) ];
        if ( match == 1 ){
            self.matchLabel.text = @"Suits match!";
        } else if (match ==2){
            self.matchLabel.text = @"Ranks match!";
        } else {
            self.matchLabel.text = @"No match";
        }
    }
}


- (IBAction)touchCardButton:(UIButton *)sender {
    if ([sender.currentTitle length]) {
        [sender setBackgroundImage: [UIImage imageNamed:@"cardback"]
                          forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    } else {
        Card *randomCard = [self.deck drawRandomCard];
        if (randomCard){
            [sender setBackgroundImage: [UIImage imageNamed:@"cardfront"]
                              forState:UIControlStateNormal];
            [sender setTitle:randomCard.contents forState:UIControlStateNormal];
        }
        
        //check if there is any match
        if ([sender isEqual:(self.leftButton)]) {
            self.leftCard = (PlayingCard*)randomCard;
        } else { //button is right button
            self.rightCard = (PlayingCard*)randomCard;
            [_cards replaceObjectAtIndex:0 withObject:self.rightCard];
        }
    }
    self.flipCount++;
    self.matchString = @"";
}


@end
