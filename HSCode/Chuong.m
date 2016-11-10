//
//  Chuong.m
//  HSCode
//
//  Created by Do Van Tuong on 11/9/16.
//  Copyright © 2016 Do Van Tuong. All rights reserved.
//

#import "Chuong.h"
#import "HangHoa.h"

@interface Chuong ()
    
@end

@implementation Chuong
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    ckNgonNgu = [prefs stringForKey:@"NgonNgu"].boolValue;
    self.title = [NSString stringWithFormat:@"%@",self.chiTietChuDe[1]];
    @try {
        tenChuDe = [NSString stringWithFormat:@"%@", self.chiTietChuDe[2]];
    } @catch (NSException *exception) {
        tenChuDe = @"Chưa có nội dung.";
    }
    @try {
        motaChuDe = [NSString stringWithFormat:@"%@", self.chiTietChuDe[3]];
    } @catch (NSException *exception) {
        motaChuDe = tenChuDe;
    }
    idChuDe = [self.chiTietChuDe[0] intValue];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.textMoTaChuDe.text = motaChuDe;
    
    self.tableChuong.delegate = self;
    self.tableChuong.dataSource = self;
    dbManager = [[DbManager alloc] initWithDatabaseFilename:@"data.db"];
    [self loadData];
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
    /*
     #pragma mark - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    
-(void) loadData{
    NSString *sqlQuery;
    if(ckNgonNgu){//tieng viet
        sqlQuery = [NSString stringWithFormat:@"SELECT id, chapter_vn, name_vn, des_vn FROM chapter WHERE section_id=%d ORDER BY ID ASC", idChuDe];
    }else{//tieng anh
        sqlQuery = [NSString stringWithFormat:@"SELECT id, chapter_en, name_en, des_en FROM chapter WHERE section_id=%d ORDER BY ID ASC", idChuDe];
    }
    
    
    if (arrChuong != nil) {
        arrChuong = nil;
    }
    arrChuong = [[NSArray alloc] initWithArray:[dbManager loadDataFromDB:sqlQuery]];
    // Reload the table view.
    [self.tableChuong reloadData];
    
    
}
    
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableChuong indexPathForSelectedRow];
    HangHoa *hanghoa = segue.destinationViewController;
    hanghoa.chiTietHangHoa = [arrChuong objectAtIndex:indexPath.row];
}
    
#pragma mark - Table view data source
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return arrChuong.count;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellChuong" forIndexPath:indexPath];
    NSInteger indexOfChapter;
    NSInteger indexOfTen;
    if(ckNgonNgu){//tieng viet
        indexOfChapter = [dbManager.columnNamesArray indexOfObject:@"chapter_vn"];
        indexOfTen = [dbManager.columnNamesArray indexOfObject:@"name_vn"];
    }else{//tieng anh
        indexOfChapter = [dbManager.columnNamesArray indexOfObject:@"chapter_en"];
        indexOfTen = [dbManager.columnNamesArray indexOfObject:@"name_en"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[arrChuong objectAtIndex:indexPath.row] objectAtIndex:indexOfChapter]];
    
    cell.detailTextLabel.numberOfLines = 3;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [[arrChuong objectAtIndex:indexPath.row] objectAtIndex:indexOfTen]];
    
    return cell;
}
    
    
    @end
