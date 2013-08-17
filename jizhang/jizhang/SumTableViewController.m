//
//  SumTableViewController.m
//  jizhang
//
//  Created by Wei Ju on 13-8-13.
//  Copyright (c) 2013年 Wei Ju. All rights reserved.
//

#import "SumTableViewController.h"
#import "Place.h"
#import "RowData.h"
@interface SumTableViewController ()

@end

@implementation SumTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UILabel* name=(UILabel*)[cell viewWithTag:1];
    UILabel* total=(UILabel*)[cell viewWithTag:2];
    name.text=self.data[indexPath.row];

    NSMutableSet* nameSet=[[NSMutableSet alloc] init];
    NSMutableArray* consumeArray=[[NSMutableArray alloc] init];
    for(int i=0;i<self.data.count;i++){
        Place* place=self.data[i];
        NSArray* rows=[place.rows allObjects];
         for(int j=0;j<rows.count;j++){
             RowData* rowData=rows[j] ;
             [nameSet addObject:rowData.name];
         }
        nameSet addObject:place.rows
        s+=[place.totalConsume floatValue];
    }
    
    NSDictionary* dict = [NSDictionary dictionaryWithObjects:(id *)valueArray
                                            forKeys:(id *)keyArray count:N_ENTRIES];
    
    float s=0;
    for(int i=0;i<self.data.count;i++){
        Place* place=self.data[i];
        s+=[place.totalConsume floatValue];
    }
  
    total.text=[NSString stringWithFormat:@"%f",s];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
