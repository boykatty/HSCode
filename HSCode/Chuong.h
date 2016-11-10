//
//  Chuong.h
//  HSCode
//
//  Created by Do Van Tuong on 11/9/16.
//  Copyright © 2016 Do Van Tuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbManager.h"

@interface Chuong : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    DbManager *dbManager;
    NSArray *arrChuong;
    int idChuDe;
    NSString *tenChuDe;
    NSString *motaChuDe;
    bool ckNgonNgu;
}
@property (weak, nonatomic) IBOutlet UITextView *textMoTaChuDe;
@property (weak, nonatomic) IBOutlet UITableView *tableChuong;

@property(strong) NSArray *chiTietChuDe;
@end
