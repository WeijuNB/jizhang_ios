//
//  MainViewController.h
//  jizhang
//
//  Created by Wei Ju on 13-8-1.
//  Copyright (c) 2013年 Wei Ju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RowData.h"
@interface MainViewController : UIViewController
@property (strong,nonatomic) UIManagedDocument* database;
@property (strong,nonatomic) NSManagedObjectContext* userContext;

@end
