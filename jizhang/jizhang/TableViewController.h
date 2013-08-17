//
//  tableViewController.h
//  jizhang
//
//  Created by Wei Ju on 13-7-20.
//  Copyright (c) 2013年 Wei Ju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Place.h"
@interface TableViewController : UITableViewController <UITableViewDataSource>
@property (strong,nonatomic) UIManagedDocument* database;
@property (strong,nonatomic) NSString* test;

@property (strong,nonatomic) NSManagedObjectContext* userContext;
@property (strong,nonatomic) NSMutableArray* data;
@property (strong,nonatomic) UILabel* totalConsume;
@property (strong,nonatomic) Place* place;
-(void)saveDatabase;
-(void)loadDatabase;
@end
