//
//  MultipleBarChartViewController.m
//  SwiftCharts
//
//  Created by yp on 2017/1/18.
//  Copyright © 2017年 shinow. All rights reserved.
//

#import "MultipleBarChartViewController.h"
#import <Charts/Charts-Swift.h>
//#import "IntAxisValueFormatter.h"

@interface MultipleBarChartViewController ()<ChartViewDelegate>
@property (weak, nonatomic) IBOutlet BarChartView *chartView;

@end

@implementation MultipleBarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Multiple Bar Chart";
    _chartView.delegate = self;
    
    _chartView.chartDescription.enabled = NO;
    
    _chartView.pinchZoomEnabled = NO;
    _chartView.drawBarShadowEnabled = NO;
    _chartView.drawGridBackgroundEnabled = NO;
    
//    BalloonMarker *marker = [[BalloonMarker alloc]
//                             initWithColor: [UIColor colorWithWhite:180/255. alpha:1.0]
//                             font: [UIFont systemFontOfSize:12.0]
//                             textColor: UIColor.whiteColor
//                             insets: UIEdgeInsetsMake(8.0, 8.0, 20.0, 8.0)];
//    marker.chartView = _chartView;
//    marker.minimumSize = CGSizeMake(80.f, 40.f);
//    _chartView.marker = marker;
    
    ChartLegend *legend = _chartView.legend;
    legend.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
    legend.verticalAlignment = ChartLegendVerticalAlignmentTop;
    legend.orientation = ChartLegendOrientationVertical;
    legend.drawInside = YES;
    legend.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:8.f];
    legend.yOffset = 10.0;
    legend.xOffset = 10.0;
    legend.yEntrySpace = 0.0;
    
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
    xAxis.granularity = 1.f;
    xAxis.centerAxisLabelsEnabled = YES;
//    xAxis.valueFormatter = [[IntAxisValueFormatter alloc] init];
    
    NSNumberFormatter *leftAxisFormatter = [[NSNumberFormatter alloc] init];
    leftAxisFormatter.maximumFractionDigits = 1;
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
//    leftAxis.valueFormatter = [[LargeValueFormatter alloc] init];
    leftAxis.drawGridLinesEnabled = NO;
    leftAxis.spaceTop = 0.35;
    leftAxis.axisMinimum = 0;
    
    _chartView.rightAxis.enabled = NO;
    
    [self setDataCount:10 range:100];


}

- (void)setDataCount:(int)count range:(double)range
{
    float groupSpace = 0.08f;
    float barSpace = 0.03f;
    float barWidth = 0.2f;
    // (0.2 + 0.03) * 4 + 0.08 = 1.00 -> interval per "group"
    
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals3 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals4 = [[NSMutableArray alloc] init];
    
    double randomMultiplier = range * 100000.f;
    
    int groupCount = count + 1;
    int startYear = 1980;
    int endYear = startYear + groupCount;
    
    for (int i = startYear; i < endYear; i++)
    {
        [yVals1 addObject:[[BarChartDataEntry alloc]
                           initWithX:i
                           y:(double) (arc4random_uniform(randomMultiplier))]];
        
        [yVals2 addObject:[[BarChartDataEntry alloc]
                           initWithX:i
                           y:(double) (arc4random_uniform(randomMultiplier))]];
        
        [yVals3 addObject:[[BarChartDataEntry alloc]
                           initWithX:i
                           y:(double) (arc4random_uniform(randomMultiplier))]];
        
        [yVals4 addObject:[[BarChartDataEntry alloc]
                           initWithX:i
                           y:(double) (arc4random_uniform(randomMultiplier))]];
    }
    
    BarChartDataSet *set1 = nil, *set2 = nil, *set3 = nil, *set4 = nil;
    if (_chartView.data.dataSetCount > 0)
    {
        set1 = (BarChartDataSet *)_chartView.data.dataSets[0];
        set2 = (BarChartDataSet *)_chartView.data.dataSets[1];
        set3 = (BarChartDataSet *)_chartView.data.dataSets[2];
        set4 = (BarChartDataSet *)_chartView.data.dataSets[3];
        set1.values = yVals1;
        set2.values = yVals2;
        set3.values = yVals3;
        set4.values = yVals4;
        
        BarChartData *data = _chartView.barData;
        
        _chartView.xAxis.axisMinimum = startYear;
        _chartView.xAxis.axisMaximum = [data groupWidthWithGroupSpace:groupSpace barSpace: barSpace] *10 + startYear;
        [data groupBarsFromX: startYear groupSpace: groupSpace barSpace: barSpace];
        
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }
    else
    {
        set1 = [[BarChartDataSet alloc] initWithValues:yVals1 label:@"Company A"];
        [set1 setColor:[UIColor colorWithRed:104/255.f green:241/255.f blue:175/255.f alpha:1.f]];
        
        set2 = [[BarChartDataSet alloc] initWithValues:yVals2 label:@"Company B"];
        [set2 setColor:[UIColor colorWithRed:164/255.f green:228/255.f blue:251/255.f alpha:1.f]];
        
        set3 = [[BarChartDataSet alloc] initWithValues:yVals3 label:@"Company C"];
        [set3 setColor:[UIColor colorWithRed:242/255.f green:247/255.f blue:158/255.f alpha:1.f]];
        
        set4 = [[BarChartDataSet alloc] initWithValues:yVals4 label:@"Company D"];
        [set4 setColor:[UIColor colorWithRed:255/255.f green:102/255.f blue:0/255.f alpha:1.f]];
        
        NSMutableArray *dataSets = [[NSMutableArray alloc] init];
        [dataSets addObject:set1];
        [dataSets addObject:set2];
        [dataSets addObject:set3];
        [dataSets addObject:set4];
        
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
//        [data setValueFormatter:[[LargeValueFormatter alloc] init]];
        
        // specify the width each bar should have
        data.barWidth = barWidth;
        
        // restrict the x-axis range
        _chartView.xAxis.axisMinimum = startYear;
        
        // groupWidthWithGroupSpace(...) is a helper that calculates the width each group needs based on the provided parameters
        _chartView.xAxis.axisMaximum = startYear + [data groupWidthWithGroupSpace:groupSpace barSpace: barSpace] * groupCount;
        
        [data groupBarsFromX: startYear groupSpace: groupSpace barSpace: barSpace];
        
        _chartView.data = data;
    }
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
