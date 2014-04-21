//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Nicole Zhu on 4/7/14.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "CardGameViewController.h"



@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (nonatomic, retain) NSMutableArray *labelHistory;
@property (weak, nonatomic) IBOutlet UILabel *resultsLabel;


@end

@implementation CardGameViewController



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





@end
