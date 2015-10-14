//
//  TableViewController.h
//  Novel2
//
//  Created by EE Lab on 12/7/4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseHelper.h"

@interface TableViewController : UITableViewController {
    NSMutableArray *titles;         // 儲存所有書名
    NSMutableArray *searchResults;  // 儲存搜尋結果
}

@end
