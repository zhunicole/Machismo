//
//  SetCard.m
//  Matchismo
//
//  Created by Nicole Zhu on 4/21/14.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

/*Content format is rank:shape:color:shade
    e.g. 1▲purplesolid*/
- (NSString *)contents {
    NSArray *rankStrings = [SetCard rankStrings];
    NSLog(@"%d %@ %@ %@", self.rank, self.shape, self.color, self.shade);
    NSString *stringContent = rankStrings[self.rank];
    [stringContent stringByAppendingString:self.shape];
    [stringContent stringByAppendingString:self.color];
    [stringContent stringByAppendingString:self.shade];
    return stringContent;
}


/*Rank or Count of shapes in card*/
+ (NSArray *)rankStrings {
    return @[@"?",@"1",@"2",@"3"];
}
+ (NSUInteger)maxRank {
    return [[self rankStrings] count] -1;
}
- (void)setRank:(NSUInteger)rank {
    if (rank <= [SetCard maxRank]) {
        _rank = rank;
    }
}

/*Shape*/
@synthesize shape = _shape; //bc we provide both setter AND getter
+ (NSArray *)validShapes {
    return @[@"▲",@"⚪️",@"◻️"];
}
-(void)setShape:(NSString *)shape {
    if ([[SetCard validShapes] containsObject:shape]){
        _shape = shape;
    }
}
- (NSString *)shape {
    return _shape ? _shape : @"?";
}

/*Color*/
@synthesize color = _color;
+ (NSArray *)validColors {
    return @[@"red",@"green",@"purple"];
}
-(void)setColor:(NSString *)color {
    if ([[SetCard validColors] containsObject:color]){
        _color = color;
    }
}
-(NSString *) color {
    return _color ? _color : @"?";
}

/*Shade*/
@synthesize shade = _shade;
+ (NSArray *)validShades {
    return @[@"solid",@"striped",@"open"];
}
-(void)setShade:(NSString *)shade {
    if ([[SetCard validShades] containsObject:shade]){
        _shade = shade;
    }
}
-(NSString *) shade {
    return _shade ? _shade : @"?";
}

/*Match function
    0 is no match
    1 is SET!*/
- (int)match:(NSArray *)otherCards {
    SetCard *card1 = (SetCard *) otherCards[0];
    SetCard *card2 = (SetCard *) otherCards[1];
    
    //check rank
    if ((self.rank == card1.rank) &&
        (self.rank == card2.rank) &&
        (card1.rank == card2.rank)){
    } else if ((self.rank != card1.rank) &&
               (self.rank != card2.rank) &&
               (card1.rank != card2.rank)){
    } else {
        return 0;
    }
    
    //check shape
    if ([self.shape isEqualToString: card1.shape] &&
        [self.shape isEqualToString: card2.shape] &&
        [card1.shape isEqualToString: card2.shape]){
    } else if (![self.shape isEqualToString: card1.shape] &&
        ![self.shape isEqualToString: card2.shape] &&
        ![card1.shape isEqualToString: card2.shape]) {
    } else {
        return 0;
    }
    
    //check color
    if ([self.color isEqualToString: card1.color] &&
        [self.color isEqualToString: card2.color] &&
        [card1.color isEqualToString: card2.color]){
    } else if (![self.color isEqualToString: card1.color] &&
        ![self.color isEqualToString: card2.color] &&
        ![card1.color isEqualToString: card2.color]) {
    } else {
        return 0;
    }
    
    //check shade
    if ([self.shade isEqualToString: card1.shade] &&
        [self.shade isEqualToString: card2.shade] &&
        [card1.shade isEqualToString: card2.shade]){
    } else if (![self.shade isEqualToString: card1.shade] &&
        ![self.shade isEqualToString: card2.shade] &&
        ![card1.shade isEqualToString: card2.shade]) {
    } else {
        return 0;
    }
    
    //once pass all these conditions
    return 1;
}
@end
