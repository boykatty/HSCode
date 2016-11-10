//
//  HangHoa.m
//  HSCode
//
//  Created by Do Van Tuong on 11/9/16.
//  Copyright © 2016 Do Van Tuong. All rights reserved.
//

#import "HangHoa.h"

@interface HangHoa ()

@end

@implementation HangHoa

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    ckNgonNgu = [prefs stringForKey:@"NgonNgu"].boolValue;
    idChuong = [self.chiTietHangHoa[0] intValue];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = [NSString stringWithFormat:@"%@",self.chiTietHangHoa[1]];
    @try {
        tenChuong = [NSString stringWithFormat:@"%@", self.chiTietHangHoa[2]];
    } @catch (NSException *exception) {
        tenChuong = @"Chưa có nội dung.";
    }
    @try {
        motaChuong = [NSString stringWithFormat:@"%@", self.chiTietHangHoa[3]];
    } @catch (NSException *exception) {
        motaChuong = tenChuong;
    }
    
    self.textHangHoa.text = motaChuong;
    
    self.tableHangHoa.delegate = self;
    self.tableHangHoa.dataSource = self;
    dbManager = [[DbManager alloc] initWithDatabaseFilename:@"data.db"];
    [self loadData];
}
    
-(void) loadData{
    NSString *sqlQuery;
    if(ckNgonNgu){//tieng viet
        sqlQuery = [NSString stringWithFormat:@"SELECT id, code, des_vn FROM commodity WHERE chapter_id=%d AND parent_id=-1 ORDER BY id ASC", idChuong];
    }else{//tieng anh
        sqlQuery = [NSString stringWithFormat:@"SELECT id, code, des_en FROM commodity WHERE chapter_id=%d AND parent_id=-1 ORDER BY id ASC", idChuong];
    }
    
    
    if (arrHangHoa != nil) {
        arrHangHoa = nil;
    }
    arrHangHoa = [[NSArray alloc] initWithArray:[dbManager loadDataFromDB:sqlQuery]];
    // Reload the table view.
    [self.tableHangHoa reloadData];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
#pragma mark - Table view data source
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return arrHangHoa.count;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellHangHoa" forIndexPath:indexPath];
    NSInteger indexOfCommodity;
    NSInteger indexOfTen;
    if(ckNgonNgu){//tieng viet
        indexOfCommodity = [dbManager.columnNamesArray indexOfObject:@"code"];
        indexOfTen = [dbManager.columnNamesArray indexOfObject:@"des_vn"];
    }else{//tieng anh
        indexOfCommodity = [dbManager.columnNamesArray indexOfObject:@"code"];
        indexOfTen = [dbManager.columnNamesArray indexOfObject:@"des_en"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[arrHangHoa objectAtIndex:indexPath.row] objectAtIndex:indexOfCommodity]];
    
    cell.detailTextLabel.numberOfLines = 10;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [[arrHangHoa objectAtIndex:indexPath.row] objectAtIndex:indexOfTen]];
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
