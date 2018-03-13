//
//  ViewController.m
//  PDBaseLib
//
//  Created by liang on 2018/2/28.
//  Copyright © 2018年 PipeDog. All rights reserved.
//

#import "ViewController.h"
#import "NSString+PDAttributedString.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *bottom1Label;
@property (weak, nonatomic) IBOutlet UILabel *bottom2Label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDictionary<NSAttributedStringKey, id> *attrDict = @{NSFontAttributeName: [UIFont systemFontOfSize:40],
                                                          NSForegroundColorAttributeName: [UIColor redColor],
                                                          NSStrokeColorAttributeName: [UIColor blueColor],
                                                          NSStrokeWidthAttributeName: @2};
    NSString *text = @"Do any additional setup after loading the view, typically from a nib.";
    NSAttributedString *attrString = [text addAttributes:attrDict range:NSMakeRange(0, 10) matchType:PDAttributedStringMatchTypeMatchOnce];
    attrString = [attrString addAttributes:attrDict range:NSMakeRange(15, 10) matchType:PDAttributedStringMatchTypeMatchOnce];
    self.bottom1Label.attributedText = attrString;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
