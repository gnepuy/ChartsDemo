//
//  AnotherBarChartViewController.m
//  SwiftCharts
//
//  Created by yp on 2017/1/18.
//  Copyright © 2017年 shinow. All rights reserved.
//

#import "AnotherBarChartViewController.h"
#import <Charts/Charts-Swift.h>

@interface AnotherBarChartViewController ()<ChartViewDelegate>

@property (weak, nonatomic) IBOutlet BarChartView *barChartView;

@end

@implementation AnotherBarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Another Bar Chart";

    _barChartView.delegate = self;
    
    _barChartView.chartDescription.enabled = NO;
    
    _barChartView.maxVisibleCount = 60;
    _barChartView.pinchZoomEnabled = NO;
    _barChartView.drawBarShadowEnabled = NO;
    _barChartView.drawGridBackgroundEnabled = NO;
    
    ChartXAxis *xAxis = _barChartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.drawGridLinesEnabled = NO;
    
    _barChartView.leftAxis.drawGridLinesEnabled = NO;
    _barChartView.rightAxis.drawGridLinesEnabled = NO;
    
    _barChartView.legend.enabled = NO;
    
    
    [self setDataCount:10 range:100];


}
- (void)setDataCount:(int)count range:(double)range
{
    NSMutableArray *yVals = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double mult = (range + 1);
        double val = (double) (arc4random_uniform(mult)) + mult / 3.0;
        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:val]];
    }
    
    BarChartDataSet *set1 = nil;
    if (_barChartView.data.dataSetCount > 0)
    {
        set1 = (BarChartDataSet *)_barChartView.data.dataSets[0];
        set1.values = yVals;
        [_barChartView.data notifyDataChanged];
        [_barChartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@"DataSet"];
        set1.colors = ChartColorTemplates.vordiplom;
        set1.drawValuesEnabled = NO;
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        
        _barChartView.data = data;
        _barChartView.fitBars = YES;
    }
    
    [_barChartView setNeedsDisplay];
}

#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    NSLog(@"chartValueSelected");
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}
@end
