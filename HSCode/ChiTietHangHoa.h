//
//  ChiTietHangHoa.h
//  HSCode
//
//  Created by Do Van Tuong on 11/10/16.
//  Copyright © 2016 Do Van Tuong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChiTietHangHoa : UIViewController<UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *arrChiTietHangHoa;
    NSArray *arrayOriginal;
}
@property (weak, nonatomic) IBOutlet UITableView *tableChiTietHangHoa;

@end
