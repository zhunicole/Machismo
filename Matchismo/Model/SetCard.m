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
    NSString *stringContent = rankStrings[self.rank];
    [stringContent stringByAppendingString:self.shape];
    [stringContent stringByAppendingString:self.color];
    [stringContent stringByAppendingString:self.shade];
    return [rankStrings[self.rank] stringByAppendingString:self.shape];
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

/*Match function*/

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
//    if([otherCards count] == 1) {
//        SetCard *otherCard = [otherCards firstObject];
//        if (otherCard.rank == self.rank) {
//            score = 4;
//        } else if ([otherCard.shape isEqualToString:self.shape]) {
//            score = 1;
//        }
//    }
        //TODO implement this later. so far, default is no match
    return score;
}
@end
