//
//  HangHoa.h
//  HSCode
//
//  Created by Do Van Tuong on 11/9/16.
//  Copyright © 2016 Do Van Tuong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DbManager.h"

@interface HangHoa : UIViewController<UITableViewDataSource, UITableViewDelegate>{
    DbManager *dbManager;
    NSArray *arrHangHoa;
    int idChuong;
    NSString *tenChuong;
    NSString *motaChuong;
    bool ckNgonNgu;
}
    @property (weak, nonatomic) IBOutlet UITextView *textHangHoa;
    @property (weak, nonatomic) IBOutlet UITableView *tableHangHoa;
    
    @property(strong) NSArray *chiTietHangHoa;

@end
