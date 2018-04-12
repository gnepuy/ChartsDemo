//
//  BubbleChartViewController.m
//  SwiftCharts
//
//  Created by yp on 2017/1/18.
//  Copyright © 2017年 shinow. All rights reserved.
//

#import "BubbleChartViewController.h"
#import <Charts/Charts-Swift.h>

@interface BubbleChartViewController ()<ChartViewDelegate>


@property (weak, nonatomic) IBOutlet BubbleChartView *chartView;

@end

@implementation BubbleChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Bubble Chart";
    _chartView.delegate = self;
    
    _chartView.chartDescription.enabled = NO;
    
    _chartView.drawGridBackgroundEnabled = NO;
    _chartView.dragEnabled = YES;
    [_chartView setScaleEnabled:YES];
    _chartView.maxVisibleCount = 200;
    _chartView.pinchZoomEnabled = YES;
    
    ChartLegend *l = _chartView.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
    l.verticalAlignment = ChartLegendVerticalAlignmentTop;
    l.orientation = ChartLegendOrientationVertical;
    l.drawInside = NO;
    l.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
    
    ChartYAxis *yl = _chartView.leftAxis;
    yl.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
    yl.spaceTop = 0.3;
    yl.spaceBottom = 0.3;
    yl.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    _chartView.rightAxis.enabled = NO;
    
    ChartXAxis *xl = _chartView.xAxis;
    xl.labelPosition = XAxisLabelPositionBottom;
    xl.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
    
//    _sliderX.value = 10.0;
//    _sliderY.value = 50.0;
//    [self slidersValueChanged:nil];
    
    [self setDataCount:10 range:50];


}



- (void)setDataCount:(int)count range:(double)range
{
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals3 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double val = (double) (arc4random_uniform(range));
        double size = (double) (arc4random_uniform(range));
        [yVals1 addObject:[[BubbleChartDataEntry alloc] initWithX:i y:val size:size]];
        
        val = (double) (arc4random_uniform(range));
        size = (double) (arc4random_uniform(range));
        [yVals2 addObject:[[BubbleChartDataEntry alloc] initWithX:i y:val size:size]];
        
        val = (double) (arc4random_uniform(range));
        size = (double) (arc4random_uniform(range));
        [yVals3 addObject:[[BubbleChartDataEntry alloc] initWithX:i y:val size:size]];
    }
    
    BubbleChartDataSet *set1 = [[BubbleChartDataSet alloc] initWithValues:yVals1 label:@"DS 1"];
    [set1 setColor:ChartColorTemplates.colorful[0] alpha:0.50f];
    [set1 setDrawValuesEnabled:YES];
    BubbleChartDataSet *set2 = [[BubbleChartDataSet alloc] initWithValues:yVals2 label:@"DS 2"];
    [set2 setColor:ChartColorTemplates.colorful[1] alpha:0.50f];
    [set2 setDrawValuesEnabled:YES];
    BubbleChartDataSet *set3 = [[BubbleChartDataSet alloc] initWithValues:yVals3 label:@"DS 3"];
    [set3 setColor:ChartColorTemplates.colorful[2] alpha:0.50f];
    [set3 setDrawValuesEnabled:YES];
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    [dataSets addObject:set2];
    [dataSets addObject:set3];
    
    BubbleChartData *data = [[BubbleChartData alloc] initWithDataSets:dataSets];
    [data setDrawValues:NO];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:7.f]];
    [data setHighlightCircleWidth: 1.5];
    [data setValueTextColor:UIColor.whiteColor];
    
    _chartView.data = data;
}


#pragma mark - ChartViewDelegate

- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull )entry dataSetIndex:(NSInteger)dataSetIndex highlight:(ChartHighlight * __nonnull)highlight
{
    NSLog(@"chartValueSelected");
}

- (void)chartValueNothingSelected:(ChartViewBase * __nonnull)chartView
{
    NSLog(@"chartValueNothingSelected");
}

@end
