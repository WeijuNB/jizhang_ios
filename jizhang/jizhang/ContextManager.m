//
//  ContextManager.m
//  jizhang
//
//  Created by Wei Ju on 13-8-13.
//  Copyright (c) 2013年 Wei Ju. All rights reserved.
//

#import "ContextManager.h"
#import <CoreData/CoreData.h>

@implementation ContextManager

+ (NSManagedObjectContext *)createContextWithURL:(NSURL *)dbURL modelName:(NSString *)modelName
{
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:modelName ofType:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:[NSURL fileURLWithPath:modelPath]];
    NSPersistentStoreCoordinator *storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    NSError *error;
    [storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                   configuration:nil
                                             URL:dbURL
                                         options:nil
                                           error:&error];
    if (error){
        NSLog(@"Error: %@", error);
    }
    
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] init];
    [context setPersistentStoreCoordinator:storeCoordinator];
    return context;
}

+ (NSManagedObjectContext *)userContext
{
    static NSManagedObjectContext *userContext = nil;
    if (!userContext) {
        /*NSURL* url=[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        url=[url URLByAppendingPathComponent:@"Database"];*/
        
        NSURL *docFolderURL = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                                     inDomains:NSUserDomainMask][0];
        NSURL *url = [docFolderURL URLByAppendingPathComponent:@"user.db"];
        userContext = [self createContextWithURL:url
                                       modelName:@"Model"];
        
        //        NSURL *cardsDBURL = [docFolderURL URLByAppendingPathComponent:@"cards.db"];
        //        [self createContextWithURL:cardsDBURL modelName:@"CardsModel"];
    }
    return userContext;
}

+ (NSManagedObjectContext *)cardsContext
{
    static NSManagedObjectContext *cardsContext = nil;
    if (!cardsContext) {
        NSURL *dbURL = [[NSBundle mainBundle] URLForResource:@"cards" withExtension:@"db"];
        cardsContext = [self createContextWithURL:dbURL modelName:@"CardsModel"];
    }
    return cardsContext;
}

+ (void)saveWithMinInterval:(NSTimeInterval)interval
{
    static NSTimeInterval lastSaveTime = 0;
    
    if (interval <= 0 || !lastSaveTime || [NSDate timeIntervalSinceReferenceDate] - lastSaveTime > interval) {
        NSTimeInterval t1 = [NSDate timeIntervalSinceReferenceDate];
        NSError *error;
        [[self userContext] save:&error];
        lastSaveTime = [NSDate timeIntervalSinceReferenceDate];
        if (error)
            NSLog(@"save error: %@", error.localizedDescription);
        NSLog(@"saved %f s", lastSaveTime - t1);
        //  context refreshobjects:withmerge: can break retain cycles between Card&Record, may save some memory
    }
}

@end