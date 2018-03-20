//
//  htmiViewController.m
//  HTMIFormEngine
//
//  Created by lovezhaozhiguo on 03/20/2018.
//  Copyright (c) 2018 lovezhaozhiguo. All rights reserved.
//

#import "htmiViewController.h"

#import "HTMIFormEngineView.h"

@interface htmiViewController ()

@end

@implementation htmiViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    HTMIFormEngineView *view = [[HTMIFormEngineView alloc] initWithFrame:self.view.bounds];
    
    [self.view addSubview:view];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
