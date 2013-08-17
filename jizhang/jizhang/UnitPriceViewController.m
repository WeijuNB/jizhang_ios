//
//  UnitPriceViewController.m
//  jizhang
//
//  Created by Wei Ju on 13-7-26.
//  Copyright (c) 2013年 Wei Ju. All rights reserved.
//

#import "UnitPriceViewController.h"

@interface UnitPriceViewController ()


@end

@implementation UnitPriceViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSLog(@"in init of unitPrice %@",self.display.text);
        
    }
    

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

        NSLog(@"in init of unitPrice %@",self.display.text);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setDisplay:nil];
    [super viewDidUnload];
}
@end
