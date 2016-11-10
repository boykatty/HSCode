//
//  ChonNgonNgu.m
//  HSCode
//
//  Created by Do Van Tuong on 11/9/16.
//  Copyright © 2016 Do Van Tuong. All rights reserved.
//

#import "ChonNgonNgu.h"

@interface ChonNgonNgu ()

@end

@implementation ChonNgonNgu

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self copyDatabaseIntoDocumentsDirectory];
}
    
#pragma mark - Private method implementation
    
-(void)copyDatabaseIntoDocumentsDirectory{
    NSString *filename = @"data.db";
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *destinationPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:filename];

    // If the database file does not exist in the documents directory
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath]) {
        
        // Copy it
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:filename];
        
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        
        // If any errors occurred, write log message
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
    
}
- (void) viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)chonTiengViet:(id)sender {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:YES forKey:@"NgonNgu"];
}

- (IBAction)chonTiengAnh:(id)sender {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setBool:NO forKey:@"NgonNgu"];
}
@end
