//
//  ContextManager.h
//  jizhang
//
//  Created by Wei Ju on 13-8-13.
//  Copyright (c) 2013年 Wei Ju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ContextManager : NSObject

+ (NSManagedObjectContext *)userContext;

+ (void)saveWithMinInterval:(NSTimeInterval)interval;

@end