//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Nicole Zhu on 4/7/14.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController

@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;

-(Deck *)createDeck;
- (void) updateMatchLabel:(Card*)card;

@end
