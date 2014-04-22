//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Nicole Zhu on 4/21/14.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "SetGameViewController.h"
#import "Deck.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController



-(Deck *)createDeck {
    return [[SetCardDeck alloc] init];
}

- (UIImage *)backgroundImageForCard: (Card *) card {
    if (card.isChosen) {
        return [UIImage imageNamed:@"stanford-tree"]; //when chosen
    } else {
        return [UIImage imageNamed:@"cardfront"];
    }
}
- (void)updateUI {
    [super updateUI];
    
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        SetCard *card = (SetCard *)[self.game cardAtIndex:cardButtonIndex];
        
        if ([card rank] == 1) {
            [self drawOne: card in: cardButton];
        } else if ([card rank] == 2) {
            [self drawTwo: card in: cardButton];
        } else {
            [self drawThree: card in: cardButton];
        }
        
        [self setSymbolAttributes: card in:cardButton];
        
    }
    
}


- (void) setSymbolAttributes:(SetCard*)card in:(UIButton*) cardButton{
    
    NSMutableAttributedString *title = [[cardButton attributedTitleForState:UIControlStateNormal] mutableCopy];
    NSDictionary *titleAttributes;
    
    if ([card.color isEqualToString:@"red"]) {
        titleAttributes = @{NSForegroundColorAttributeName:   [UIColor redColor],
                            NSStrokeColorAttributeName: [UIColor redColor]};
    } else if ([card.color isEqualToString:@"green"]) {
        titleAttributes = @{NSForegroundColorAttributeName:   [UIColor greenColor],
                            NSStrokeColorAttributeName: [UIColor greenColor]};
    } else {
        titleAttributes = @{NSForegroundColorAttributeName:   [UIColor purpleColor],
                            NSStrokeColorAttributeName: [UIColor purpleColor]};

    }
    [title setAttributes:titleAttributes range: [[title string] rangeOfString:[title string]]];


    if ([card.shade isEqualToString: @"open"]) {
        [title addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:[[title string] rangeOfString:[title string]]];
    } else if ([card.shade isEqualToString: @"striped"]) {
        UIColor *color = [titleAttributes objectForKey:NSForegroundColorAttributeName];
        color = [color colorWithAlphaComponent:0.5];
        [title addAttribute:NSForegroundColorAttributeName value:color range:[[title string] rangeOfString:[title string]]];
    }
    
    [title addAttribute:NSStrokeWidthAttributeName value:[NSNumber numberWithFloat:-5.0] range: [[title string] rangeOfString:[title string]]];
    [cardButton setAttributedTitle:title forState:UIControlStateNormal];
}

- (void) drawOne:(SetCard *)card in:(UIButton*)cardButton {
    NSAttributedString *title;
    title = [[NSAttributedString alloc]  initWithString:[card shape]];
    [cardButton setAttributedTitle:title forState:UIControlStateNormal];
}


- (void) drawTwo:(SetCard *)card in:(UIButton*)cardButton {
    NSAttributedString *title;
    NSString *cardTitle = [[card shape] stringByAppendingString:[card shape]];
    title = [[NSAttributedString alloc]  initWithString:cardTitle];
    [cardButton setAttributedTitle:title forState:UIControlStateNormal];
}


- (void) drawThree:(SetCard *)card in:(UIButton*)cardButton {
    NSAttributedString *title;
    NSString *cardTitle = [[card shape] stringByAppendingString:[card shape]];
    cardTitle = [cardTitle stringByAppendingString:[card shape]];
    title = [[NSAttributedString alloc]  initWithString:cardTitle];
    [cardButton setAttributedTitle:title forState:UIControlStateNormal];
}

- (NSMutableAttributedString *)tempTitleForCards:(SetCard *)card {
    NSString *cardTitle;

    if ([card rank] == 1) {
        cardTitle =[card shape];
    } else if ([card rank] == 2) {
        cardTitle = [[card shape] stringByAppendingString:[card shape]];
    } else {
        cardTitle = [[card shape] stringByAppendingString:[card shape]];
        cardTitle = [cardTitle stringByAppendingString:[card shape]];
    }
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]  initWithString:cardTitle];

    
    NSDictionary *titleAttributes;
    if ([card.color isEqualToString:@"red"]) {
        titleAttributes = @{NSForegroundColorAttributeName:   [UIColor redColor],
                            NSStrokeColorAttributeName: [UIColor redColor]};
    } else if ([card.color isEqualToString:@"green"]) {
        titleAttributes = @{NSForegroundColorAttributeName:   [UIColor greenColor],
                            NSStrokeColorAttributeName: [UIColor greenColor]};
    } else {
        titleAttributes = @{NSForegroundColorAttributeName:   [UIColor purpleColor],
                            NSStrokeColorAttributeName: [UIColor purpleColor]};
        
    }
    [title setAttributes:titleAttributes range: [[title string] rangeOfString:[title string]]];
    
    
    if ([card.shade isEqualToString: @"open"]) {
        [title addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:[[title string] rangeOfString:[title string]]];
    } else if ([card.shade isEqualToString: @"striped"]) {
        UIColor *color = [titleAttributes objectForKey:NSForegroundColorAttributeName];
        color = [color colorWithAlphaComponent:0.5];
        [title addAttribute:NSForegroundColorAttributeName value:color range:[[title string] rangeOfString:[title string]]];
    }
    
    [title addAttribute:NSStrokeWidthAttributeName value:[NSNumber numberWithFloat:-5.0] range: [[title string] rangeOfString:[title string]]];
    return title;
}




- (void) updateMatchLabel:(SetCard*)card with:(SetCard*)card1 and:(SetCard*)card2{

    NSMutableAttributedString* cardTitle = [self tempTitleForCards:card];
    
    //if all three are flipped
    if(card2) {
        //if set
        NSMutableAttributedString* card1Title = [self tempTitleForCards:card1];
        NSMutableAttributedString* card2Title = [self tempTitleForCards:card2];

        [cardTitle appendAttributedString:card1Title];
        [cardTitle appendAttributedString:card2Title];
        NSString *regularStringLabel;
        if (card.matched){
            regularStringLabel = [NSString stringWithFormat:@" is a SET for %d points", self.game.pointDifference];
        } else {
            regularStringLabel = [NSString stringWithFormat:@" doesn't make a set! %d point penalty!", self.game.pointDifference];
        }
        NSMutableAttributedString* cardAttrContent = [[NSMutableAttributedString alloc]  initWithString:regularStringLabel];
        [cardTitle appendAttributedString:cardAttrContent];

    } else {    //when less than three cards are flipped
        if(card1){ //two cards are flipped
            NSMutableAttributedString* card1Title = [self tempTitleForCards:card1];

            [cardTitle appendAttributedString:card1Title];
        }
    }
    [self.resultsLabel setAttributedText:cardTitle];
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
    self.tabBarItem.title = @"Set Game";
    
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
