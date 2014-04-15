//
//  PlayingCard.m
//  Matchismo
//
//  Created by Nicole Zhu on 4/7/14.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; //bc we provide both setter AND getter
+ (NSArray *)validSuits {
    return @[@"♥︎",@"♦︎",@"♠︎",@"♣︎"];
}
- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}
- (NSString *)suit {
    return _suit ? _suit : @"?";
}
+ (NSArray *)rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}
+ (NSUInteger)maxRank {
    return [[self rankStrings] count] -1;
}
- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}


- (int)match:(NSArray *)otherCards {
    int ismatch = 0;
    for (PlayingCard *card in otherCards) {
        NSLog(@"ranks: %d %d", card.rank, self.rank);
        NSLog(@"suits: %@ %@",card.suit, self.suit);

        if ([card.suit isEqualToString:self.suit]){
            ismatch = 1;
        }
        if (card.rank == self.rank){
            ismatch = 2;

        }
    }
    NSLog(@"Match result is  %d", ismatch);
    return ismatch;

}


@end
