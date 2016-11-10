//
//  DbManager.h
//  HSCode
//
//  Created by Do Van Tuong on 11/8/16.
//  Copyright © 2016 Do Van Tuong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DbManager : NSObject

@property (nonatomic, strong) NSMutableArray *columnNamesArray;

@property (nonatomic) int affectedRows;

@property (nonatomic) long long lastInsertedRowID;
    
@property (nonatomic, strong) NSString *documentsDirectory;
    
@property (nonatomic, strong) NSString *databaseFilename;
    
@property (nonatomic, strong) NSMutableArray *resultsArray;

-(instancetype)initWithDatabaseFilename:(NSString *)dbFilename;

-(NSArray *)loadDataFromDB:(NSString *)query;

-(void)executeQuery:(NSString *)query;
    
-(void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable;

@end
