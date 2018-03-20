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

@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDictionary<NSAttributedStringKey, id> *topAttrs = @{NSFontAttributeName: [UIFont systemFontOfSize:30],
                                                       NSStrokeWidthAttributeName: @2,
                                                       NSStrokeColorAttributeName: [UIColor blueColor]};
    NSString *topString = @"http://www.baidu.com, Do any additional setup after loading the view, typically from a nib. http://www.baidu.com.";
    NSAttributedString *topAttrString = [topString addAttributes:topAttrs regex:@"http://([\\w-]+\\.)+[\\w-]+(/[\\w-./?%&=]*)?" matchType:PDAttributedStringMatchTypeMatchAll];
    topAttrString = [topAttrString addAttributes:topAttrs regex:@"setup after" matchType:PDAttributedStringMatchTypeMatchAll];
    self.topLabel.attributedText = topAttrString;
    
    NSDictionary<NSAttributedStringKey, id> *bottomAttrs = @{NSFontAttributeName: [UIFont systemFontOfSize:15],
                                                          NSForegroundColorAttributeName: [UIColor redColor]};
    NSString *bottomString = [topString copy];
    NSAttributedString *bottomAttrString = [bottomString addAttributes:bottomAttrs regex:@"Do any additional setup aft" matchType:PDAttributedStringMatchTypeUnmatchOnce];
    self.bottomLabel.attributedText = bottomAttrString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
