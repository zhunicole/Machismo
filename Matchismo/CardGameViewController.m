//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Nicole Zhu on 4/7/14.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "CardGameViewController.h"
#import "HistoryControllerViewController.h"
#import "Deck.h"
#import "CardMatchingGame.h"


@interface CardGameViewController ()


@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (nonatomic, retain) NSMutableArray *labelHistory;



@end

@implementation CardGameViewController

- (CardMatchingGame *) game{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
        self.labelHistory = [[NSMutableArray alloc] init];
        self.matchHistoryAttributedStrings = [[NSMutableArray alloc] init];
    }
    return _game;
}

-(Deck *)createDeck {                   //over written by subclasses
    return [[Deck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];            //TODO fix still calling playing card for set card
    [self updateResultsLabel:chosenButtonIndex];
    [self updateSlider];
    [self updateUI];
    
}

/*set slider to right end whenever new move is made*/
-(void) updateSlider {
    [self.slider setValue:10 animated:YES];
    [self.resultsLabel setAlpha:1.0 ];
    
}

-(void) updateResultsLabel:(NSInteger)index {
    Card *card = [self.game cardAtIndex:index];
    
    Card *card1 = self.game.card1;
    Card *card2 = self.game.card2;
    
    [self updateMatchLabel:card with:card1 and:card2];
    
    NSString *current_label = [self.resultsLabel text];
    [self.labelHistory addObject:current_label];
    
}


- (void) updateMatchLabel:(Card*)card with:(Card*)card1 and:(Card*)card2{
    
}

- (IBAction)toggleLabelHistory:(id)sender {
    int sliderVal = self.slider.value;
    double index = sliderVal / 10.0;
    index *= [self.labelHistory count];
    int indexInt = index;
    NSString *labelAtIndex;
    if ([self.labelHistory count] == 0){
        self.resultsLabel.text =  @"";
        [self.resultsLabel setAlpha:0.5 ];
    }else if(indexInt == [self.labelHistory count]) {
        labelAtIndex = [self.labelHistory objectAtIndex:(indexInt-1)];
        self.resultsLabel.text = [NSString stringWithFormat:@"%@", labelAtIndex];
        [self.resultsLabel setAlpha: 1.0 ];
        
    } else {
        labelAtIndex = [self.labelHistory objectAtIndex:indexInt];
        self.resultsLabel.text = [NSString stringWithFormat:@"%@", labelAtIndex];
        [self.resultsLabel setAlpha:0.5 ];
    }
    
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCards:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}


//TODO refactor updateUI stuff to in here?
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
    self.resultsLabel.text = [NSString stringWithFormat:@"Let's Play!"];
    
}


#pragma mark - View life cycle

- (void)awakeFromNib {
    [self setup];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        // setup code
        [self setup];
    }
    return self;
}

- (void)setup {

}


// view setup that needs to be done once
- (void)viewDidLoad {

}

// does every single time
- (void)viewWillAppear:(BOOL)animated {
    
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"HistoryView"]) {
        HistoryControllerViewController *hvc = (HistoryControllerViewController *)segue.destinationViewController;
        hvc.historyText = self.matchHistoryAttributedStrings;
        
    }
}




@end
