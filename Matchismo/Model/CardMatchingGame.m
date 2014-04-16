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
//static const int TRIPLE_MATCH_BONUS = 3;


- (void) chooseCardAtIndex:(NSUInteger)index{
    
    //TODO some changes here
    NSLog(@"current mode: %d", _numCardMatchMode);
    _pointDifference = self.score;
    Card *card = [self cardAtIndex:index];
    _card1 = nil;
    _card2 = nil;
    if(!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;//just flips same card over
        }else {
            if (self.numCardMatchMode == 2){
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        //as soon as we find other card, we save it
                        _card1 = otherCard;
                        int matchScore = [card match:@[otherCard]];
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            otherCard.matched = YES;
                            card.matched = YES;
                        } else {

                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                        }
                        NSLog(@"here");
                        
                        break; //since we only allow 2 cards for now
                    }
                }
            } else if (self.numCardMatchMode == 3 ) {

                //TODO: just have them as local vars?
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
                    NSLog(@"have three cards!");
                    int score1 = [self computeMatchScore:card with:_card1];
                    int score2 = [self computeMatchScore:card with:_card2];
                    int score3 = [self computeMatchScore:_card1 with:_card2];
                    
                    if (score1 > 0) {
                        NSLog(@"card matched card 1");
                        card.matched = YES;
                        _card1.matched = YES;
                    }
                    if (score2 > 0){
                        NSLog(@"card matched card 2");
                        card.matched = YES;
                        _card2.matched = YES;
                    }
                    if (score3 > 0){
                        NSLog(@"card1 matched card 2");
                        _card1.matched = YES;
                        _card2.matched = YES;
                    }
                    
                    //double score if there is a a triple match!
                    if (score1 > 0 && score2 > 0 && score3 > 0) {
                        score1 *=2;
                        score2 *=2;
                        score3 *=2;
                    };
                    
                    if (!card.matched) card.chosen = NO;
                    if (!_card1.matched) _card1.chosen = NO;
                    if (!_card2.matched) _card2.chosen = NO;
                    
                    self.score += score1 + score2 +score3;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
    self.pointDifference = self.score - self.pointDifference;
}

//both cards are chosen (faceup, and cards haven't been matched)
-(NSInteger) computeMatchScore:(Card *)card with:(Card *)otherCard {
    int tempScore = 0;
    int matchScore = [card match:@[otherCard]];
    if (matchScore) {
        tempScore += matchScore * MATCH_BONUS;
    } else {
        tempScore -= MISMATCH_PENALTY;   //might need to fix when this is updated
    }

    return tempScore;
}

@end
