//
//  tableViewController.m
//  jizhang
//
//  Created by Wei Ju on 13-7-20.
//  Copyright (c) 2013年 Wei Ju. All rights reserved.
//

#import "TableViewController.h"
#import "RowData.h"

#import "FPPopoverController.h"
#import "UnitPriceViewController.h"
#import "testTableViewController.h"
#import "ContextManager.h"

@interface TableViewController ()



@property (strong,nonatomic) NSArray* dataFromDatabase;
@property (strong,nonatomic) RowData* rowData;
@property (strong,nonatomic) UnitPriceViewController*unitPriceViewController;

@end

@implementation TableViewController
@synthesize userContext=_userContext;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization

    }


    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    
    /*
    self.data=[[NSMutableArray alloc]init];
    
    self.rowData=[[RowData alloc]init];
    self.rowData.name=@"张成龙";
    self.rowData.isnew=[NSNumber numberWithBool:NO];
    self.rowData.perprice=[NSNumber numberWithFloat:0.00];
    self.rowData.payprice=[NSNumber numberWithFloat:0.00];
    self.rowData.style=@"pay";
    self.rowData.enabled=[NSNumber numberWithBool:YES];
    [self.data addObject:self.rowData];
    
    
    self.rowData=[[RowData alloc]init];
    self.rowData.name=@"陆文进";
    self.rowData.isnew=[NSNumber numberWithBool:NO];
    self.rowData.perprice=[NSNumber numberWithFloat:0.00];
    self.rowData.payprice=[NSNumber numberWithFloat:0.00];
    self.rowData.style=@"pay";
    self.rowData.enabled=[NSNumber numberWithBool:YES];
    [self.data addObject:self.rowData];
     
     self.rowData=[[RowData alloc]init];
     self.rowData.name=@"新人名";
     self.rowData.sign=@"X";
     self.rowData.perprice=[NSNumber numberWithFloat:0.00];
     self.rowData.payprice=[NSNumber numberWithFloat:0.00];
     self.rowData.style=@"new";
     self.rowData.enabled=[NSNumber numberWithBool:NO];
     [self.data addObject:self.rowData];
    */

     //*/

    [self loadDatabase];

    
}
-(NSManagedObjectContext*)userContext{
    if(!_userContext){self.userContext=[ContextManager userContext];}
    return _userContext;

}
-(NSMutableArray* )Data{
    if(!_data){[self loadDatabase];}
    return _data;
}
    
-(void)setData:(NSMutableArray *)data{
    _data=data;
    [self.tableView reloadData];
    
}
-(void)loadDatabase{
                       

    //NSFetchRequest* request=[NSFetchRequest fetchRequestWithEntityName:@"RowData"];
    self.dataFromDatabase=[[self.place rows] allObjects];
    self.data=[NSMutableArray arrayWithArray:self.dataFromDatabase];
    [self.data addObject:[self makeNewData]];
    [self.tableView reloadData];
    
}
-(RowData*)makeNewData{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"RowData" inManagedObjectContext:self.userContext];
    RowData* rowData = [[RowData alloc] initWithEntity:entity insertIntoManagedObjectContext:nil];
    //RowData* rowData=[NSEntityDescription insertNewObjectForEntityForName:@"RowData" inManagedObjectContext:nil];
    // RowData* rowData=[NSEntityDescription entityForName:@"RowData" inManagedObjectContext:self.userContext];
    rowData.name=@"新人名";
    rowData.perprice=[NSNumber numberWithFloat:0.00];
    rowData.payprice=[NSNumber numberWithFloat:0.00];
    rowData.style=@"new";
    rowData.enabled=[NSNumber numberWithBool:NO];
    return rowData;
}
-(void)saveDatabase{
    //self.rowData=[self.data lastObject];
    //[self.data removeLastObject];
    
   /*
    for(RowData* rowData in self.dataFromDatabase){
        
        [self.userContext deleteObject:rowData];
    }
    for(int i=0;i< self.data.count-1;i++){
        self.rowData=self.data[i];
        //RowData* rowData=[NSEntityDescription entityForName:@"RowData" inManagedObjectContext:self.userContext];
        RowData* rowData=[NSEntityDescription insertNewObjectForEntityForName:@"RowData" inManagedObjectContext:self.userContext];
        rowData.name=self.rowData.name;
        rowData.payprice =self.rowData.payprice;
        rowData.perprice =self.rowData.perprice;
        rowData.isnew =self.rowData.isnew;
        rowData.style =self.rowData.style;
        rowData.enabled =self.rowData.enabled;

        [self.userContext insertObject:rowData];

    }
    */

    NSError* error;
    [self.userContext save:&error];


}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.test=@"zcl";
    
    UIStoryboard* storyboard=[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil];
    self.unitPriceViewController=[storyboard instantiateViewControllerWithIdentifier:@"UnitPay"];
    //self.unitPriceViewController=[[UnitPriceViewController alloc]init];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"row:%d,section:%d",indexPath.row,indexPath.section);
    UITableViewCell *cell;
 


    static NSString *CellIdentifier = @"cell";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    cell.tag=indexPath.row+10;
    [self loadDataWithIndexRow:indexPath.row FromCell:cell];

    return cell;
}
- (IBAction)onCheckBoxOfPayPressed:(UIButton *)sender {
    NSLog(@"%@",sender.titleLabel.text);
    
    UITableViewCell *cell;
    cell=(UITableViewCell*)sender.superview;
    int index=cell.superview.tag-10;
     UIButton* sign=(UIButton*)[cell viewWithTag:2];
    UILabel* payLabel=(UILabel*)[cell viewWithTag:7];
    UITextField* inputMoney=(UITextField*)[cell viewWithTag:8];
    
   // UIButton* sign=(UIButton*)[cell.contentView viewWithTag:2];
    NSLog(@"%@",sign.titleLabel.text);

    
    if ([sender.titleLabel.text isEqualToString:@"1"]) {
        [sender setTitle:@"0" forState:UIControlStateNormal];
        payLabel.hidden=NO;
        inputMoney.hidden=YES;
        self.rowData= self.data[index];
        self.rowData.payprice=[NSNumber numberWithInt:0];
        [self caculatePerPrice];
        [self reloadData];
    }
    else if ([sender.titleLabel.text isEqualToString:@"0"]) {  //未选中-》选中
        [sender setTitle:@"1" forState:UIControlStateNormal];
        payLabel.hidden=YES;
        inputMoney.hidden=NO;
    }
    
    NSLog(@"%@",sender.titleLabel.text);
    //self.checkBoxOfPay.titleLabel.text=@"0";
   
    
}

- (IBAction)onPressAddNew:(UIButton *)sender {
    self.rowData=[NSEntityDescription insertNewObjectForEntityForName:@"RowData" inManagedObjectContext:self.userContext ];
    /*
    self.rowData=[self.data lastObject];*/
    UITextField* inputname=(UITextField*)[sender.superview viewWithTag:1];

    self.rowData.name=  inputname.text;
    self.rowData.perprice=[NSNumber numberWithFloat:0.00];
    self.rowData.payprice=[NSNumber numberWithFloat:0.00];
    self.rowData.style=@"pay";
    self.rowData.enabled=[NSNumber numberWithBool:YES];
    self.rowData.isnew=[NSNumber numberWithBool:YES];
    /*
    self.rowData=[self makeNewData];

    [self.data addObject:self.rowData];
     */
    [self.place addRowsObject:self.rowData];
    [self loadDatabase];
    [self.tableView reloadData];
    
}
-(UITableViewCell*)cellWithIndexRow:(int)row{
     UITableViewCell *cell=(UITableViewCell*)[self.tableView viewWithTag:row+10];
    return cell;
}
- (BOOL)checkBoxStateWithIndexRow:(int) row{
    UITableViewCell* cell=[self cellWithIndexRow:row];
    UIButton* sender=(UIButton* )[cell viewWithTag:6];
    if ([sender.titleLabel.text isEqualToString:@"1"]) {
        return YES;
    }
    return NO;
}
- (float) caculatePerPrice{
    float total=0;
    int count=0;
    for(int i=0;i<self.data.count;i++){
        self.rowData=self.data[i];
        if ([self.rowData.enabled isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            count++;
            total+=[self.rowData.payprice floatValue];
        }

    }
    for(int i=0;i<self.data.count;i++){
        self.rowData=self.data[i];
        if ([self.rowData.enabled isEqualToNumber:[NSNumber numberWithBool:YES]]){
            self.rowData.perprice=[NSNumber numberWithFloat:total/count];
        }
    }
    return total;

}
-(void)loadDataWithIndexRow:(int) row FromCell:(UITableViewCell*)cell{
    self.rowData=self.data[row];
    if(!cell){cell=(UITableViewCell*)[self.tableView viewWithTag:row+10];};

    UITextField* inputName=(UITextField*)[cell viewWithTag:1];
    UIButton* sign=(UIButton*)[cell viewWithTag:2];
    UILabel* name=(UILabel*)[cell viewWithTag:3];
    UIButton* addnew=(UIButton*)[cell viewWithTag:4];
    UIButton* perprice=(UIButton*)[cell viewWithTag:5];
    UIButton* checkBox=(UIButton*)[cell viewWithTag:6];
    UILabel* paylabel=(UILabel*)[cell viewWithTag:7];
    UITextField* inputMoney=(UITextField*)[cell viewWithTag:8];
    
    //NSLog(@"labeltext:%@",name.text);
    //各种初使化
    if ([self.rowData.style isEqualToString:@"pay"]) {
        name.text=self.rowData.name;
        NSString* signText=@"-";
        if ([self.rowData.isnew isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            signText=@"X";
        }
        [sign setTitle:signText forState:UIControlStateNormal];
        [perprice setTitle:[@"-" stringByAppendingString:[self.rowData.perprice stringValue]] forState:UIControlStateNormal];
        inputMoney.text=[self.rowData.payprice stringValue];
        addnew.hidden=YES;inputName.hidden=YES;
        name.hidden=NO;sign.hidden=NO;perprice.hidden=NO;checkBox.hidden=NO;paylabel.hidden=NO;inputMoney.hidden=NO;
        BOOL hidden=NO;
        if([self checkBoxStateWithIndexRow:row]){   hidden=YES;   }
        paylabel.hidden=hidden;
        inputMoney.hidden=!hidden;
    }
    if ([self.rowData.style isEqualToString:@"new"]) {
        inputName.text=self.rowData.name;
        [addnew setTitle:@"加入" forState:UIControlStateNormal];
        addnew.hidden=NO;inputName.hidden=NO;
        name.hidden=YES;sign.hidden=YES;perprice.hidden=YES;checkBox.hidden=YES;paylabel.hidden=YES;inputMoney.hidden=YES;
    }
}
-(void)loadDataWithIndexRow:(int) row{
    [self loadDataWithIndexRow:row FromCell:nil];
}
-(void)reloadData{
    for(int i=0;i<self.data.count;i++){
        [self loadDataWithIndexRow:i];
    }
    
}
- (IBAction)onInputMoneyChanging:(UITextField*)sender {
    if(sender.text.length==0){sender.text=@"0";}
    if([[sender.text substringFromIndex:sender.text.length-1] isEqualToString:@"."]){return;} //如果是小数点 则返回
    NSLog(@"onInputMoneyChanging cell tag:%d",sender.superview.superview.tag);
    float money=[sender.text floatValue];
    NSLog(@"%f",money);
    int index=sender.superview.superview.tag-10;
    [self.data[index] setPayprice:[NSNumber numberWithFloat:money]];
 

    float total=[self caculatePerPrice];
    self.place.totalConsume=[NSNumber numberWithFloat:total];
    self.totalConsume.text=[self.place.totalConsume stringValue];
    [self reloadData];
}
- (IBAction)onInputMoneyEnd:(UITextField *)sender {
    [sender.window resignFirstResponder];
}

- (IBAction)onUnitPricePressed:(UIButton *)sender {
    
    NSLog(@"%@",self.unitPriceViewController.display.text);

    FPPopoverController* fController=[[FPPopoverController alloc]initWithViewController:self.unitPriceViewController];
    NSLog(@"%@",self.unitPriceViewController.display.text);
    fController.arrowDirection=FPPopoverNoArrow;
    self.unitPriceViewController.title=nil;
    fController.tint=FPPopoverLightGrayTint;
    fController.alpha=0.6;
    CGRect frame=fController.contentView.frame;
    frame.origin.y=50;
    frame.origin.x=self.tableView.frame.size.width/2-150;
    frame.size=CGSizeMake(300, 200);

    [fController presentPopoverFromView:sender];
      fController.contentView.frame=frame;
    

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
     DetailViewController *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    UITableViewCell* cell=(UITableViewCell*)[tableView viewWithTag:indexPath.row+10];
    UITextField* input=(UITextField*)[cell viewWithTag:8];
    [input endEditing:YES];
    NSLog(@"input:%@",input.text);
    NSLog(@"selected.section%d,row%d..",indexPath.section,indexPath.row);
    [self reloadData];

}

- (void)viewDidUnload {

    [super viewDidUnload];
}
@end
