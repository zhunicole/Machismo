//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Nicole Zhu on 4/7/14.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"


@interface CardGameViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;

@end

@implementation CardGameViewController

- (CardMatchingGame *) game{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
        self.game.numCardMatchMode = 2; //initialized to 2
    }
    return _game;
}


-(Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}



- (IBAction)touchCardButton:(UIButton *)sender {
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    
    

    [self.game chooseCardAtIndex:chosenButtonIndex];       //resets _card1/2 to nil

    //set results label
    [self updateResultsLabel:chosenButtonIndex];

    [self updateUI];

}

-(void) updateResultsLabel:(NSInteger)index {
    Card *card = [self.game cardAtIndex:index];
    NSString *cardContent = card.contents;

    if(self.game.numCardMatchMode == 2){
        NSString *card1Content = self.game.card1.contents;

        if (!self.game.card1.isChosen) {
            self.game.card1.chosen = YES;
            card1Content = self.game.card1.contents;
            self.game.card1.chosen = NO;
        }
        
        if (!card1Content) {   //one card flipped
            self.resultsLabel.text = [NSString stringWithFormat:@"%@", cardContent];
        } else if (card.matched){
            self.resultsLabel.text = [NSString stringWithFormat:@"Matched %@ %@ for %d points", cardContent, card1Content, self.game.pointDifference];
        } else {
            self.resultsLabel.text = [NSString stringWithFormat:@"%@ %@ don't match! %d point penalty!", cardContent, card1Content, self.game.pointDifference];
        }
    } else {        //if matching three cards
        
        
        //if all three are flipped
        if(self.game.card2) {
            //if one and two match
            if (card.matched || self.game.card1.matched || self.game.card2.matched){
                self.resultsLabel.text = [NSString stringWithFormat:@"Matched %@ %@ %@ for %d points", cardContent, self.game.card1.contents , self.game.card2.contents,self.game.pointDifference];
            } else {
                self.resultsLabel.text = [NSString stringWithFormat:@"%@ %@ %@ don't match! %d point penalty!", cardContent, self.game.card1.contents, self.game.card2.contents, self.game.pointDifference];
            }

        } else {    //when less than three cards are flipped
            if(self.game.card1){ //two cards are flipped
                NSString *card1Content = self.game.card1.contents;
                self.resultsLabel.text = [NSString stringWithFormat:@"%@ %@", cardContent, card1Content];
            } else { //only card is flipped
                self.resultsLabel.text = [NSString stringWithFormat:@"%@", cardContent];
            }
        }

        
    }

    
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCards:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
    //if (game is in session)//disable button.
    if(_game){
        cardMatchModeControl.userInteractionEnabled = NO;
    } else {
        cardMatchModeControl.userInteractionEnabled = YES;
    }
}

- (NSString *)titleForCards:(Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard: (Card *) card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)redeal:(id)sender {
    self.game = nil;
    [self game];            //creates a new game object
    [self updateUI];
    [self updateCardMatchMode];
    cardMatchModeControl.userInteractionEnabled = YES;
    self.resultsLabel.text = [NSString stringWithFormat:@"Let's Play!"];

}


@synthesize cardMatchModeControl;

- (IBAction)toggleCardMatchMode:(id)sender {
    [self updateCardMatchMode];
}

-(void)updateCardMatchMode {
    if (cardMatchModeControl.selectedSegmentIndex == 0) {
        self.game.numCardMatchMode = 2;
    } else {
        self.game.numCardMatchMode = 3;
    }
}







@end
