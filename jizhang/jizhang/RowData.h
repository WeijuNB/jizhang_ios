//
//  RowData.h
//  jizhang
//
//  Created by Wei Ju on 13-7-29.
//  Copyright (c) 2013年 Wei Ju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface RowData : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * payprice;
@property (nonatomic, retain) NSNumber * perprice;
@property (nonatomic, retain) NSNumber * isnew;
@property (nonatomic, retain) NSString * style;
@property (nonatomic, retain) NSNumber * enabled;

@end
