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

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDictionary<NSAttributedStringKey, id> *attrs = @{NSFontAttributeName: [UIFont systemFontOfSize:30],
                                                       NSForegroundColorAttributeName: [UIColor redColor],
                                                       NSStrokeWidthAttributeName: @2,
                                                       NSStrokeColorAttributeName: [UIColor blueColor]};
    
    NSString *string = @"iabc, abc, abc, uuu, nnn, http://www.baidu.com/path abc, abcdfg, iiii, abcdabci, http://www.baidu.com/path/iii 000888";
    NSAttributedString *attrString = [string addAttributes:attrs regex:@"http://([\\w-]+\\.)+[\\w-]+(/[\\w-./?%&=]*)?" matchType:PDAttributedStringMatchTypeUnmatchAll];
//    attrString = [attrString addAttributes:attrs string:@"path" matchType:PDAttributedStringMatchTypeUnmatchAll];
    self.label.attributedText = attrString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
