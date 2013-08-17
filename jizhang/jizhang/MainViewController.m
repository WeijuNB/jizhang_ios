//
//  MainViewController.m
//  jizhang
//
//  Created by Wei Ju on 13-8-1.
//  Copyright (c) 2013年 Wei Ju. All rights reserved.
//

#import "MainViewController.h"
#import "NewPlaceViewController.h"
#import "ContextManager.h"
#import "Place.h"
@interface MainViewController ()
@property (nonatomic,strong) NSArray* allPlaces;
@property (nonatomic,strong) Place* place;
@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    NSLog(@"%@",segue.identifier);
    if([segue.identifier isEqualToString:@"newPlace"]){
        NewPlaceViewController* newplaceVC=segue.destinationViewController;

        NSFetchRequest* request=[NSFetchRequest fetchRequestWithEntityName:@"Place"];
        request.predicate=[NSPredicate predicateWithFormat:@"placename == %@", @"dd2"];
        NSArray* ret=[self.userContext executeFetchRequest:request error:nil];
        self.place=nil;
        if(ret){self.place=[ret lastObject];}
        newplaceVC.place=self.place;
        
    }
}
-(NSManagedObjectContext*)userContext{
    if(!_userContext){self.userContext=[ContextManager userContext];}
    return _userContext;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSFetchRequest* request=[NSFetchRequest fetchRequestWithEntityName:@"Place"];
    self.allPlaces=[self.userContext executeFetchRequest:request error:nil];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onCancelPressed:(id)sender {
    
}



@end
