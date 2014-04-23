//
//  PlayingGameViewController.m
//  Matchismo
//
//  Created by Nicole Zhu on 4/21/14.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "PlayingGameViewController.h"
#import "Deck.h"
#import "PlayingCard.h"
#import "PlayingCardDeck.h"


@interface PlayingGameViewController ()

@end

@implementation PlayingGameViewController


-(Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}




- (void) updateMatchLabel:(PlayingCard*)card with:(PlayingCard*)card1 and:(PlayingCard*)card2{
    NSString *card1Content = card1.contents;
    
    if (!card1.isChosen) {
        card1.chosen = YES;
        card1Content = card1.contents;
        card1.chosen = NO;
    }
    
    NSMutableAttributedString* cardTitle = [self makeCardAttrSymbol:card];
    NSMutableAttributedString* card1Title;
    if (card1Content) {
        card1Title = [self makeCardAttrSymbol:card1];
        [cardTitle appendAttributedString:card1Title];
    }
    
    if (!card1Content) {   //one card flipped
        [self.resultsLabel setAttributedText:cardTitle];
    } else{
        NSString *regularStringLabel;
        if (card.matched){
            regularStringLabel = [NSString stringWithFormat:@" matched for %d points", self.game.pointDifference];
        } else {
            regularStringLabel = [NSString stringWithFormat:@" don't match! %d point penalty!", self.game.pointDifference];
        }
        NSMutableAttributedString* cardAttrContent = [[NSMutableAttributedString alloc]  initWithString:regularStringLabel];
        [cardTitle appendAttributedString:cardAttrContent];
        [self.resultsLabel setAttributedText:cardTitle];
        
        //adding to history view here
        [self.matchHistoryAttributedStrings addObject:cardTitle];
    }
        
    
}

- (void)updateUI {
    [super updateUI];
    
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        PlayingCard *card = (PlayingCard *)[self.game cardAtIndex:cardButtonIndex];
        NSMutableAttributedString *title = [self makeCardAttrSymbol:card];
        if (card.isChosen) {
            [cardButton setAttributedTitle:title forState:UIControlStateNormal];
        } else {
            title = [[NSMutableAttributedString alloc]  initWithString:@""];
            [cardButton setAttributedTitle:title forState:UIControlStateNormal];
        }
    }
}



-(NSMutableAttributedString *)makeCardAttrSymbol:(PlayingCard*) card {
    NSDictionary *redAttributes = @{NSForegroundColorAttributeName:   [UIColor redColor] };
    NSDictionary *blackAttributes = @{NSForegroundColorAttributeName:   [UIColor blackColor]};

    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]  initWithString:[card contents]];
    
    if ([card.suit isEqualToString:@"♥︎"] || [card.suit isEqualToString:@"♦︎"]){
        NSInteger endingIndex = [title length] -1;
        NSInteger startingIndex = 1;
        
        [title setAttributes:redAttributes range:NSMakeRange(startingIndex,endingIndex)];
        [title setAttributes:blackAttributes range:NSMakeRange(0,startingIndex)];
        if([card rank] == 10){
            [title setAttributes:blackAttributes range:NSMakeRange(0,startingIndex+1)];
        }

    } else {
        [title setAttributes:blackAttributes range:[[title string] rangeOfString:[title string]]];
    }
    
    return title;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setup];
        // Custom initialization
    }
    return self;
}

- (void)awakeFromNib {
    [self setup];
}


- (void)setup {
    self.tabBarItem.title = @"Playing Card";
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
