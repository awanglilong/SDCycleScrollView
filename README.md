# SDCycleScrollView
## 项目中使用
   
## 无限循环自动图片轮播器(一步设置即可使用)

     // 网络加载图片的轮播器
     SDCycleScrollView *cycleScrollView = [cycleScrollViewWithFrame:frame delegate:delegate placeholderImage:placeholderImage];
     cycleScrollView.imageURLStringsGroup = imagesURLStrings;
     
     // 本地加载图片的轮播器
     SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame: imagesGroup:图片数组]
