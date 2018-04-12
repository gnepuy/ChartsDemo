//
//  ScatterChartViewController.m
//  SwiftCharts
//
//  Created by yp on 2017/1/18.
//  Copyright © 2017年 shinow. All rights reserved.
//

#import "ScatterChartViewController.h"
#import <Charts/Charts-Swift.h>

@interface ScatterChartViewController ()<ChartViewDelegate>
@property (weak, nonatomic) IBOutlet ScatterChartView *chartView;

@end

@implementation ScatterChartViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.title = @"Scatter Bar Chart";

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
    l.xOffset = 5.0;
    
    ChartYAxis *yl = _chartView.leftAxis;
    yl.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
    yl.axisMinimum = 0.0; // this replaces startAtZero = YES
    
    _chartView.rightAxis.enabled = NO;
    
    ChartXAxis *xl = _chartView.xAxis;
    xl.labelFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:10.f];
    xl.drawGridLinesEnabled = NO;

    [self setDataCount:45 range:100];

}

- (void)setDataCount:(int)count range:(double)range
{
    NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals2 = [[NSMutableArray alloc] init];
    NSMutableArray *yVals3 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < count; i++)
    {
        double val = (double) (arc4random_uniform(range)) + 3;
        [yVals1 addObject:[[ChartDataEntry alloc] initWithX:(double)i y:val]];
        
        val = (double) (arc4random_uniform(range)) + 3;
        [yVals2 addObject:[[ChartDataEntry alloc] initWithX:(double)i + 0.33 y:val]];
        
        val = (double) (arc4random_uniform(range)) + 3;
        [yVals3 addObject:[[ChartDataEntry alloc] initWithX:(double)i + 0.66 y:val]];
    }
    
    ScatterChartDataSet *set1 = [[ScatterChartDataSet alloc] initWithValues:yVals1 label:@"DS 1"];
    [set1 setScatterShape:ScatterShapeSquare];
    [set1 setColor:ChartColorTemplates.colorful[0]];
    ScatterChartDataSet *set2 = [[ScatterChartDataSet alloc] initWithValues:yVals2 label:@"DS 2"];
    [set2 setScatterShape:ScatterShapeCircle];
    set2.scatterShapeHoleColor = ChartColorTemplates.colorful[3];
    set2.scatterShapeHoleRadius = 3.5f;
    [set2 setColor:ChartColorTemplates.colorful[1]];
    ScatterChartDataSet *set3 = [[ScatterChartDataSet alloc] initWithValues:yVals3 label:@"DS 3"];
    [set3 setScatterShape:ScatterShapeCross];
    [set3 setColor:ChartColorTemplates.colorful[2]];
    
    set1.scatterShapeSize = 8.0;
    set2.scatterShapeSize = 8.0;
    set3.scatterShapeSize = 8.0;
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:set1];
    [dataSets addObject:set2];
    [dataSets addObject:set3];
    
    ScatterChartData *data = [[ScatterChartData alloc] initWithDataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:7.f]];
    
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
