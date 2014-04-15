//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Nicole Zhu on 4/14/14.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "CardMatchingGame.h"


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
    return self;
}


- (Card *) cardAtIndex:(NSUInteger)index {
    return (index<[self.cards count])? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;   //same as define
static const int MATCH_BONUS = 4;   //same as define
static const int COST_TO_CHOOSE = 1;

- (void) chooseCardAtIndex:(NSUInteger)index{
    
    Card *card = [self cardAtIndex:index];
    if(!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        }else {
            //match against other chosen cards
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard]];   //creating an array with just otherCard
                    if (matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                    }
                    break; //since we only allow 2 cards for now
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
    
    
    
    
    
    
    
}


@end
