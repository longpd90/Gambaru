//
//  GBHomePageViewController.h
//  Ganbare
//
//  Created by Phung Long on 9/3/15.
//  Copyright (c) 2015 Phung Long. All rights reserved.
//

#import "GBBaseTableViewController.h"
#import "GBGanbareSearchViewBar.h"

typedef enum {
    GBTypeModeSort = 0,
    GBTypeModeFilter,
} GBTypeMode;

typedef enum  {
    GBGetGanbareModeNormal = 0,
    GBGetGanbareModeFavorite,
    GBGetGanbareModePin,
    
} GBGetGanbareMode;


@interface GBHomePageViewController : GBBaseTableViewController
@property (nonatomic) GBGetGanbareMode getGanbareMode;
@property (weak, nonatomic) IBOutlet GBGanbareSearchViewBar *ganbarTopMenuView;

@end
