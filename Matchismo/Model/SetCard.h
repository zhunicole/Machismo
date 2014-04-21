//
//  SetCard.h
//  Matchismo
//
//  Created by Nicole Zhu on 4/21/14.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *shape;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *shade;
@property (nonatomic) NSUInteger rank;     //times that shape appears

+ (NSArray *)validShapes;
+ (NSArray *)validColors;
+ (NSArray *)validShades;

+ (NSUInteger)maxRank;




@end




