//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Nicole Zhu on 4/21/14.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"


@implementation SetCardDeck

- (instancetype)init{
    self = [super init];
    /*Content format is rank:shape:color:shade*/

    if (self) {
        for (NSString *shape in [SetCard validShapes]){
            for (NSString *color in [SetCard validColors]){
                for (NSString *shade in [SetCard validShades]){
                    for (NSUInteger rank =1; rank <= [SetCard maxRank]; rank++){
                        SetCard *card = [[SetCard alloc] init];
                        card.rank = rank;
                        card.shape = shape;
                        card.color = color;
                        card.shade = shade;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    return self;
}

@end
