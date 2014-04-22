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



- (void) updateMatchLabel:(Card*)card with:(Card*)card1 and:(Card*)card2{

//    NSLog(@"checking for match");
    NSString *cardContent = card.contents;
    NSString *card1Content = super.game.card1.contents;
    if (!card1.isChosen) {
        card1.chosen = YES;
        card1Content = self.game.card1.contents;
        card1.chosen = NO;
    }
    if (!card1Content) {   //one card flipped
        self.resultsLabel.text = [NSString stringWithFormat:@"%@", cardContent];
    } else if (card.matched){
//        NSLog(@"here");
        self.resultsLabel.text = [NSString stringWithFormat:@"Matched %@ %@ for %d points", cardContent, card1Content, self.game.pointDifference];
    } else {
//        NSLog(@"here");
        self.resultsLabel.text = [NSString stringWithFormat:@"%@ %@ don't match! %d point penalty!", cardContent, card1Content, self.game.pointDifference];
    }

}

- (void)updateUI {
    [super updateUI];
    
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        PlayingCard *card = (PlayingCard *)[self.game cardAtIndex:cardButtonIndex];
        
        //check if is heart or diamond
        if ([card.suit isEqualToString:@"♥︎"] || [card.suit isEqualToString:@"♦︎"]){
            if (card.isChosen) {
                NSDictionary *titleAttributes = @{NSForegroundColorAttributeName:   [UIColor redColor]};
                NSMutableAttributedString *title = [[NSMutableAttributedString alloc]  initWithString:[card contents]];
                [title setAttributes:titleAttributes range: [[title string] rangeOfString:[title string]]];
                [cardButton setAttributedTitle:title forState:UIControlStateNormal];
            } else {
                NSMutableAttributedString *title = [[NSMutableAttributedString alloc]  initWithString:@""];
                [cardButton setAttributedTitle:title forState:UIControlStateNormal];
            }
        }
        
    }
    
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
