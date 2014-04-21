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

@interface SetGameViewController ()

@end

@implementation SetGameViewController



-(Deck *)createDeck {
    return [[SetCardDeck alloc] init];
}

-(void)updateMatchLabel:(Card *)card {
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
