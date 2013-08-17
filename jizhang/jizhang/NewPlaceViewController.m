//
//  ViewController.m
//  jizhang
//
//  Created by Wei Ju on 13-7-20.
//  Copyright (c) 2013年 Wei Ju. All rights reserved.
//

#import "NewPlaceViewController.h"
#import "TableViewController.h"
#import "ContextManager.h"

@interface NewPlaceViewController ()
@property (weak, nonatomic) IBOutlet UILabel *totalConsume;
@property (weak, nonatomic) IBOutlet UITextField *date;
@property (weak, nonatomic) IBOutlet UITextField *placeName;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
//@property (strong,nonatomic) UIManagedDocument* database;

@property (strong,nonatomic) TableViewController* vc;
@end

@implementation NewPlaceViewController



-(NSManagedObjectContext*)userContext{
    if(!_userContext){_userContext=[ContextManager userContext];}
    return _userContext;
    
}
- (IBAction)onPressSave:(UIButton *)sender {
    //Place* place=[NSEntityDescription insertNewObjectForEntityForName:@"Place" inManagedObjectContext:self.userContext];
    //[self.userContext insertObject:self.place];
    self.place.placename=self.placeName.text;
    
    self.place.date=[self.dateFormatter dateFromString:self.date.text];
    [self.vc saveDatabase];
}

-(void)reloadData{
    self.date.text=[self.dateFormatter stringFromDate:self.place.date];
    self.placeName.text=self.place.placename;
    self.totalConsume.text=[self.place.totalConsume stringValue];
}
-(Place*)makeNewData{
   // NSEntityDescription *entity = [NSEntityDescription entityForName:@"Place" inManagedObjectContext:self.userContext];
    //Place* place = [[Place alloc] initWithEntity:entity insertIntoManagedObjectContext:self.userContext];
    Place* place=[NSEntityDescription insertNewObjectForEntityForName:@"Place" inManagedObjectContext:self.userContext];
 
    place.placename=@"";
    place.totalConsume=[NSNumber numberWithFloat:0.00] ;
    place.date=[NSDate date];
    return place;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    /*
    self.vc=[[TableViewController alloc]initWithStyle:UITableViewStylePlain];
     
    self.vc.tableView=self.tableView;
    self.vc.view=self.tableView;
    self.vc.tableView.dataSource=self.vc;
    //self.container=self.vc.tableView;
     */

    self.dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"EEE, dd MMM y hh:mm a zzz"];
    //[dateFormatter dateFromString:@"Wed, 08 Jun 2011 11:58 pm EDT";
    [self.dateFormatter setDateFormat:@"yyyy.MM.dd"];
    
    for(TableViewController * viewController in self.childViewControllers)
    {
        if([viewController isKindOfClass:[TableViewController class]])
        {
            self.vc=viewController;
        }
    }
    if(!self.place){ self.place=[self makeNewData];}
    [self reloadData];
    self.vc.place=self.place;
    self.vc.totalConsume=self.totalConsume;
    /*
    UIStoryboard* storyboard=[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    self.vc=[storyboard instantiateViewControllerWithIdentifier:@"tableViewController"];
    NSMutableArray* vcs= [storyboard instantiateInitialViewController];
    NSLog(@"self.vc.test %@",self.vc.test);

     */
    /*
    self.userContext=[ContextManager userContext];
    self.vc.database=self.database;
     */
    //[self.vc loadDatabase];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTableView:nil];

    [self setTotalConsume:nil];
    [self setDate:nil];
    [self setPlaceName:nil];
    [super viewDidUnload];
}
- (IBAction)onCancelPressed:(id)sender {

}
/*
-(void) useDocument{
    NSLog(@"in useDocument init");
    if(![[NSFileManager defaultManager] fileExistsAtPath:[self.database.fileURL path]]){
        [self.database saveToURL:self.database.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            [self.vc loadDatabase];
            return;
        }];
    }else if(self.database.documentState==UIDocumentStateClosed){
        [self.database openWithCompletionHandler:^(BOOL success) {
            [self.vc loadDatabase];
            return;
        }];
    }else if (self.database.documentState==UIDocumentStateNormal){
        return;
    }
}

-(void) setDatabase:(UIManagedDocument *)database{
    NSLog(@"in setdatabase");
    if(_database!=database){
        _database=database;
        [self useDocument];
    }
    
}*/
@end