//
//  HalfPieChartViewController.m
//  SwiftCharts
//
//  Created by yp on 2017/1/18.
//  Copyright © 2017年 shinow. All rights reserved.
//

#import "HalfPieChartViewController.h"
#import <Charts/Charts-Swift.h>

@interface HalfPieChartViewController ()<ChartViewDelegate>
@property (weak, nonatomic) IBOutlet PieChartView *chartView;

@end

@implementation HalfPieChartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Half Pie Bar Chart";
    
    
    _chartView.delegate = self;
    
    _chartView.holeColor = UIColor.whiteColor;
    _chartView.transparentCircleColor = [UIColor.whiteColor colorWithAlphaComponent:0.43];
    _chartView.holeRadiusPercent = 0.58;
    _chartView.rotationEnabled = NO;
    _chartView.highlightPerTapEnabled = YES;
    
    _chartView.maxAngle = 180.0; // Half chart
    _chartView.rotationAngle = 180.0; // Rotate to make the half on the upper side
    _chartView.centerTextOffset = CGPointMake(0.0, -20.0);
    
    ChartLegend *l = _chartView.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentCenter;
    l.verticalAlignment = ChartLegendVerticalAlignmentTop;
    l.orientation = ChartLegendOrientationHorizontal;
    l.drawInside = NO;
    l.xEntrySpace = 7.0;
    l.yEntrySpace = 0.0;
    l.yOffset = 0.0;
    
    // entry label styling
    _chartView.entryLabelColor = UIColor.whiteColor;
    _chartView.entryLabelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.f];
    
    
    [_chartView animateWithXAxisDuration:1.4 easingOption:ChartEasingOptionEaseOutBack];
    
    [self setDataCount:4 range:100];

}



- (void)setDataCount:(int)count range:(double)range
{
    double mult = range;
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    
    // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
    for (int i = 0; i < count; i++)
    {
        [values addObject:[[PieChartDataEntry alloc] initWithValue:(arc4random_uniform(mult) + mult / 5) label:[NSString stringWithFormat:@"第%d个", i]]];
    }
    
    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:values label:@"Election Results"];
    dataSet.sliceSpace = 3.0;
    dataSet.selectionShift = 5.0;
    
    dataSet.colors = ChartColorTemplates.material;
    
    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
    
    NSNumberFormatter *pFormatter = [[NSNumberFormatter alloc] init];
    pFormatter.numberStyle = NSNumberFormatterPercentStyle;
    pFormatter.maximumFractionDigits = 1;
    pFormatter.multiplier = @1.f;
    pFormatter.percentSymbol = @" %";
    [data setValueFormatter:[[ChartDefaultValueFormatter alloc] initWithFormatter:pFormatter]];
    
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:11.f]];
    [data setValueTextColor:UIColor.whiteColor];
    
    _chartView.data = data;
    
    [_chartView setNeedsDisplay];
}

#pragma mark - Action

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
