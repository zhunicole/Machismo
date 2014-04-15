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


@end

@implementation CardGameViewController

- (CardMatchingGame *) game{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];

    }
    
    return _game;
}


//need to put this somewhere
//_numCardMatchMode = 2; //by default match mode is 2 cards to match



-(Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}



- (IBAction)touchCardButton:(UIButton *)sender {
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];

}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCards:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];

        //TODO some changes here
        

    
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


}


@synthesize cardMatchModeControl;

- (IBAction)toggleCardMatchMode:(id)sender {
    [self updateCardMatchMode];
}

-(void)updateCardMatchMode {
    if (cardMatchModeControl.selectedSegmentIndex == 0) {
        NSLog(@"clicked for 2");
        self.game.numCardMatchMode = 2;
    } else {
        NSLog(@"clicked for 3");
        
        self.game.numCardMatchMode = 3;
    }
}


@end
