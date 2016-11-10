//
//  ChuDe.h
//  HSCode
//
//  Created by Do Van Tuong on 11/9/16.
//  Copyright © 2016 Do Van Tuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbManager.h"

@interface ChuDe : UITableViewController{
    DbManager *dbManager;
    NSArray *arrChuDe;
    bool ckNgonNgu;
}

-(void)loadData;

@property (strong, nonatomic) IBOutlet UITableView *tableChuDe;

@end
