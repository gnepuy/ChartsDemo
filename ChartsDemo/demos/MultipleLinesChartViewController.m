//
//  MultipleLinesChartViewController.m
//  SwiftCharts
//
//  Created by yp on 2017/1/18.
//  Copyright © 2017年 shinow. All rights reserved.
//

#import "MultipleLinesChartViewController.h"
#import <Charts/Charts-Swift.h>

@interface MultipleLinesChartViewController ()<ChartViewDelegate>
@property (weak, nonatomic) IBOutlet LineChartView *chartView;

@end

@implementation MultipleLinesChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Multiple Lines Chart";

    _chartView.delegate = self;
    
    _chartView.chartDescription.enabled = NO;
    
    _chartView.leftAxis.enabled = NO;
    _chartView.rightAxis.drawAxisLineEnabled = NO;
    _chartView.rightAxis.drawGridLinesEnabled = NO;
    _chartView.xAxis.drawAxisLineEnabled = NO;
    _chartView.xAxis.drawGridLinesEnabled = NO;
    
    _chartView.drawGridBackgroundEnabled = NO;
    _chartView.drawBordersEnabled = NO;
    _chartView.dragEnabled = YES;
    [_chartView setScaleEnabled:YES];
    _chartView.pinchZoomEnabled = NO;
    
    ChartLegend *l = _chartView.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
    l.verticalAlignment = ChartLegendVerticalAlignmentTop;
    l.orientation = ChartLegendOrientationVertical;
    l.drawInside = NO;
    
    
    [self setDataCount:20 range:100];


}
- (void)setDataCount:(int)count range:(double)range
{
    NSArray *colors = @[ChartColorTemplates.vordiplom[0], ChartColorTemplates.vordiplom[1], ChartColorTemplates.vordiplom[2]];
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    
    for (int z = 0; z < 3; z++)
    {
        NSMutableArray *values = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < count; i++)
        {
            double val = (double) (arc4random_uniform(range) + 3);
            [values addObject:[[ChartDataEntry alloc] initWithX:i y:val]];
        }
        
        LineChartDataSet *d = [[LineChartDataSet alloc] initWithValues:values label:[NSString stringWithFormat:@"DataSet %d", z + 1]];
        d.lineWidth = 2.5;
        d.circleRadius = 4.0;
        d.circleHoleRadius = 2.0;
        
        UIColor *color = colors[z % colors.count];
        [d setColor:color];
        [d setCircleColor:color];
        [dataSets addObject:d];
    }
    
    ((LineChartDataSet *)dataSets[0]).lineDashLengths = @[@5.f, @5.f];
    ((LineChartDataSet *)dataSets[0]).colors = ChartColorTemplates.vordiplom;
    ((LineChartDataSet *)dataSets[0]).circleColors = ChartColorTemplates.vordiplom;
    
    LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:7.f]];
    _chartView.data = data;
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
