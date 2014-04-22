//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Nicole Zhu on 4/14/14.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "CardMatchingGame.h"
#import "PlayingCard.h"
#import "SetCard.h"


//private properties in area called Class Extension
@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;  //redeclaring
@property (nonatomic, strong) NSMutableArray *cards;



@end


@implementation CardMatchingGame

//lazy instantiation of cards
- (NSMutableArray *)cards{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

//alllowing superclass to initialize itself, and checking for failure return
- (instancetype) initWithCardCount:(NSUInteger)count
                         usingDeck:(Deck *)deck {
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i ++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            }else {
                self = nil;
                break;
            }
        }
    }
    _card1 = nil;
    _card2 = nil;
    return self;
}


- (Card *) cardAtIndex:(NSUInteger)index {
    return (index<[self.cards count])? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;
static const int SET_BONUS = 10;

- (void) chooseCardAtIndex:(NSUInteger)index{
    _pointDifference = self.score;
    Card *card = [self cardAtIndex:index];
    _card1 = nil;
    _card2 = nil;
    if(!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;//just flips same card over
        }else {
            if ([card isKindOfClass:[PlayingCard class]]){
                [self twoCardMatch:card];
            } else {
                [self threeCardMatch:card];
            }

            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
    self.pointDifference = self.score - self.pointDifference;
}


//TODO change this name
-(void) twoCardMatch: (Card *) card {
//    NSLog(@" twoCardMatch model");
    for (Card *otherCard in self.cards) {
        if (otherCard.isChosen && !otherCard.isMatched) {
            //as soon as we find other card, we save it
            _card1 = otherCard;
            int matchScore = [card match:@[otherCard]];         //over written for Set or Playing card
            if (matchScore) {
                self.score += matchScore * MATCH_BONUS;
                otherCard.matched = YES;
                card.matched = YES;
            } else {
                self.score -= MISMATCH_PENALTY;
                otherCard.chosen = NO;
            }
            break;
        }
    }
}


-(void) threeCardMatch:(Card *) card {
    for (Card *otherCard in self.cards) {
        if (otherCard.isChosen && !otherCard.isMatched) {
            if (_card1){ //if card 1 exists
                _card2 = otherCard;
            } else {
                _card1 = otherCard;
            }
        }
        if (_card2) break; //only finding 2 cards
    }
    if (_card2) {     //have three cards
        [self computeThreeCardMatchScore:card];
    }
}

- (void) computeThreeCardMatchScore:(Card *) card {
    NSMutableArray *setCards =[[NSMutableArray alloc] init];
    [setCards addObject:_card1];
    [setCards addObject:_card2];
    int isASet = [card match:setCards];

    if (isASet) {
        NSLog(@"This is a set %@ %@ %@", card.contents, _card1.contents, _card2.contents);
        card.matched = YES;
        _card1.matched = YES;
        _card2.matched = YES;
        self.score += SET_BONUS;

    } else {
        NSLog(@"NOT a set %@ %@ %@", card.contents, _card1.contents, _card2.contents);
        card.matched = NO;
        _card1.matched = NO;
        _card2.matched = NO;
    }
    card.chosen = NO;
    _card1.chosen = NO;
    _card2.chosen = NO;         //TODO implement chosen in view here, change card background
    
}

@end
