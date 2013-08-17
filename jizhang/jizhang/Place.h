//
//  Place.h
//  jizhang
//
//  Created by Wei Ju on 13-8-13.
//  Copyright (c) 2013年 Wei Ju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class RowData;

@interface Place : NSManagedObject

@property (nonatomic, retain) NSString * placename;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * totalConsume;
@property (nonatomic, retain) NSSet *rows;
@end

@interface Place (CoreDataGeneratedAccessors)

- (void)addRowsObject:(RowData *)value;
- (void)removeRowsObject:(RowData *)value;
- (void)addRows:(NSSet *)values;
- (void)removeRows:(NSSet *)values;

@end
