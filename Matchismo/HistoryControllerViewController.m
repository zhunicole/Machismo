//
//  HistoryControllerViewController.m
//  Matchismo
//
//  Created by Nicole Zhu on 4/22/14.
//  Copyright (c) 2014 CS193p. All rights reserved.
//

#import "HistoryControllerViewController.h"

@interface HistoryControllerViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTextField;

@end

@implementation HistoryControllerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
