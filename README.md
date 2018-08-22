# SDCycleScrollView（新建QQ交流群：185534916、675995250）
## ☆☆☆ “iOS图片、文字轮播器” ☆☆☆

### 支持pod导入
pod 'SDCycleScrollView','~> 1.75'

 如果发现pod search SDCycleScrollView 搜索出来的不是最新版本，需要在终端执行cd转换文件路径命令退回到desktop，然后执行pod setup命令更新本地spec缓存（可能需要几分钟），然后再搜索就可以了


### 更改记录：

2018.8.22 -- 添加多图片预览和缩放功能


           
### 无限循环自动图片轮播器(一步设置即可使用)

     // 网络加载图片的轮播器
     SDCycleScrollView *cycleScrollView = [cycleScrollViewWithFrame:frame delegate:delegate placeholderImage:placeholderImage];
     cycleScrollView.imageURLStringsGroup = imagesURLStrings;
     
     // 本地加载图片的轮播器
     SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame: imagesGroup:图片数组];
    
    
 ---------------------------------------------------------------------------------------------------------------
 
## ??? 为什么我用这个轮播期会在顶部出现一块空白区域
以下是本库的使用者给出的一些解决方法放在这里供大家参考：
在iOS 7以后，controller 会对其中唯一的scrollView或其子类调整内边距，从而导致位置不准确。设置self.automaticallyAdjustsScrollViewInsets = NO;或者controller中放置不止一个scrollView或其子类时，就不会出现这种问题。以上原因是我的猜测，只要我设置了 self.automaticallyAdjustsScrollViewInsets = NO就没有那个问题了。
 
#PS:
 
 如需更详细的设置，参考如下：
 
 1. cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight; // 设置pageControl居右，默认居中
 
 2. cycleScrollView.titlesGroup =  标题数组（数组元素个数必须和图片数组元素个数保持一致）; // 如果设置title数组，则会在图片下面添加标题
 
 3. cycleScrollView.delegate = ; // 如需监听图片点击，请设置代理，实现代理方法
 
 4. cycleScrollView.autoScrollTimeInterval = ;// 自定义轮播时间间隔 

