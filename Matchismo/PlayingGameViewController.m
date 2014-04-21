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


@interface PlayingGameViewController ()

@end

@implementation PlayingGameViewController


-(Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

-(void)updateMatchLabel:(Card *)card {
//    NSLog(@"checking for match");
    NSString *cardContent = card.contents;
    NSString *card1Content = super.game.card1.contents;
    if (!self.game.card1.isChosen) {
        self.game.card1.chosen = YES;
        card1Content = self.game.card1.contents;
        self.game.card1.chosen = NO;
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
