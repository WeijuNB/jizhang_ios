//
//  ViewController.h
//  jizhang
//
//  Created by Wei Ju on 13-7-20.
//  Copyright (c) 2013年 Wei Ju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RowData.h"
#import "Place.h"
@interface NewPlaceViewController : UIViewController
@property (strong,nonatomic) UIManagedDocument* database;
@property (strong,nonatomic) NSManagedObjectContext* userContext;
@property (weak, nonatomic) Place *place;
@end
