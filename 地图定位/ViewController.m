//
//  ViewController.m
//  地图定位
//
//  Created by 陈高健 on 15/11/28.
//  Copyright © 2015年 陈高健. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>
@property (nonatomic,strong)CLLocationManager *locationManager;
@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化locationManger管理器对象
    CLLocationManager *locationManager=[[CLLocationManager alloc]init];
    self.locationManager=locationManager;
    
    //判断当前设备定位服务是否打开
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"设备尚未打开定位服务");
    }

    //判断当前设备版本大于iOS8以后的话执行里面的方法
    if ([UIDevice currentDevice].systemVersion.floatValue >=8.0) {
        //持续授权
        [locationManager requestAlwaysAuthorization];
        //当用户使用的时候授权
        [locationManager requestWhenInUseAuthorization];
    }
    
    //或者使用这种方式,判断是否存在这个方法,如果存在就执行,没有的话就忽略
    //if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
    //   [locationManager requestWhenInUseAuthorization];
    //}
    
    //设置代理
    locationManager.delegate=self;
    //设置定位的精度
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    //设置定位的频率,这里我们设置精度为10,也就是10米定位一次
    CLLocationDistance distance=10;
    //给精度赋值
    locationManager.distanceFilter=distance;
    //开始启动定位
    [locationManager startUpdatingLocation];

}
//当位置发生改变的时候调用(上面我们设置的是10米,也就是当位置发生>10米的时候该代理方法就会调用)
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    //取出第一个位置
    CLLocation *location=[locations firstObject];
    NSLog(@"%@",location.timestamp);
    //位置坐标
    CLLocationCoordinate2D coordinate=location.coordinate;
    NSLog(@"您的当前位置:经度：%f,纬度：%f,海拔：%f,航向：%f,速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    //如果不需要实时定位，使用完即使关闭定位服务
    //[_locationManager stopUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
