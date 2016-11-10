//
//  ChuDe.m
//  HSCode
//
//  Created by Do Van Tuong on 11/9/16.
//  Copyright © 2016 Do Van Tuong. All rights reserved.
//

#import "ChuDe.h"
#import "Chuong.h"

@interface ChuDe ()

@end

@implementation ChuDe

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    ckNgonNgu = [prefs stringForKey:@"NgonNgu"].boolValue;
    if(ckNgonNgu){
        self.title = @"Chủ Đề";
    }else{
        self.title = @"Section";
    }
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.tableChuDe.delegate = self;
    self.tableChuDe.dataSource = self;
    dbManager = [[DbManager alloc] initWithDatabaseFilename:@"data.db"];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadData{
    NSString *sqlQuery;
    if(ckNgonNgu){//tieng viet
        sqlQuery = @"SELECT id, section_vn, name_vn, des_vn FROM section ORDER BY ID ASC";
    }else{//tieng anh
        sqlQuery = @"SELECT id, section_en, name_en, des_en FROM section ORDER BY ID ASC";
    }
    
    if (arrChuDe != nil) {
        arrChuDe = nil;
    }
    arrChuDe = [[NSArray alloc] initWithArray:[dbManager loadDataFromDB:sqlQuery]];
    
    // Reload the table view.
    [self.tableChuDe reloadData];

    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"thongtinchude"]){
        NSIndexPath *indexPath = [self.tableChuDe indexPathForSelectedRow];
        Chuong *chuong = segue.destinationViewController;
        chuong.chiTietChuDe = [arrChuDe objectAtIndex:indexPath.row];
    }

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return arrChuDe.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellChuDe" forIndexPath:indexPath];
    NSInteger indexOfSection;
    NSInteger indexOfTen;
    if(ckNgonNgu){//tieng viet
        indexOfSection = [dbManager.columnNamesArray indexOfObject:@"section_vn"];
        indexOfTen = [dbManager.columnNamesArray indexOfObject:@"name_vn"];
    }else{//tieng anh
        indexOfSection = [dbManager.columnNamesArray indexOfObject:@"section_en"];
        indexOfTen = [dbManager.columnNamesArray indexOfObject:@"name_en"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [[arrChuDe objectAtIndex:indexPath.row] objectAtIndex:indexOfSection]];
    
    cell.detailTextLabel.numberOfLines = 5;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [[arrChuDe objectAtIndex:indexPath.row] objectAtIndex:indexOfTen]];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
