//
//  PlayingGameViewController.m
//  Matchismo
//
//  Created by Nicole Zhu on 4/21/14.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "PlayingGameViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface PlayingGameViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;


@end

@implementation PlayingGameViewController

- (CardMatchingGame *) game{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
        //        self.game.numCardMatchMode = 2; //initialized to 2
        self.labelHistory = [[NSMutableArray alloc] init];
    }
    return _game;
}


-(Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}


- (IBAction)touchCardButton:(UIButton *)sender {
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
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
    //    if(self.game.numCardMatchMode == 2){
    [self updateTwoCardMatchLabel:card];
    //    } else {        //if matching three cards
    //        [self updateThreeCardMatchLabel: card];
    //    }
    NSString *current_label = [self.resultsLabel text];
    [self.labelHistory addObject:current_label];
}

- (void) updateTwoCardMatchLabel:(Card*)card {
    NSString *cardContent = card.contents;
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
}

//
//- (void) updateThreeCardMatchLabel:(Card*)card {
//    NSString *cardContent = card.contents;
//    //if all three are flipped
//    if(self.game.card2) {
//        //if one and two match
//        if (card.matched || self.game.card1.matched || self.game.card2.matched){
//            self.resultsLabel.text = [NSString stringWithFormat:@"Matched %@ %@ %@ for %d points", cardContent, self.game.card1.contents , self.game.card2.contents,self.game.pointDifference];
//        } else {
//            self.resultsLabel.text = [NSString stringWithFormat:@"%@ %@ %@ don't match! %d point penalty!", cardContent, self.game.card1.contents, self.game.card2.contents, self.game.pointDifference];
//        }
//    } else {    //when less than three cards are flipped
//        if(self.game.card1){ //two cards are flipped
//            NSString *card1Content = self.game.card1.contents;
//            self.resultsLabel.text = [NSString stringWithFormat:@"%@ %@", cardContent, card1Content];
//        } else { //only card is flipped
//            self.resultsLabel.text = [NSString stringWithFormat:@"%@", cardContent];
//        }
//    }
//}

- (IBAction)toggleLabelHistory:(id)sender {
    int sliderVal = self.slider.value;
    double index = sliderVal / 10.0;
    index *= [self.labelHistory count];
    int indexInt = index;
    NSString *labelAtIndex;
    if (indexInt == [self.labelHistory count]) {
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
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
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
    
    //TODO delete this since it's not required?
    //    [self updateCardMatchMode];
    //    cardMatchModeControl.userInteractionEnabled = YES;
    self.resultsLabel.text = [NSString stringWithFormat:@"Let's Play!"];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
