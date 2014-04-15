//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Nicole Zhu on 4/14/14.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void) chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;


@property (nonatomic, readonly) NSInteger score;


@end
