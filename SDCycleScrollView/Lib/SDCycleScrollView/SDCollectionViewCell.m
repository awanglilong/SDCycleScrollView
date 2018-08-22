//
//  SDCollectionViewCell.m
//  SDCycleScrollView
//
//  Created by aier on 15-3-22.
//  Copyright (c) 2015年 GSD. All rights reserved.
//


/*
 
 *********************************************************************************
 *
 * 🌟🌟🌟 新建SDCycleScrollView交流QQ群：185534916 🌟🌟🌟
 *
 * 在您使用此自动轮播库的过程中如果出现bug请及时以以下任意一种方式联系我们，我们会及时修复bug并
 * 帮您解决问题。
 * 新浪微博:GSD_iOS
 * Email : gsdios@126.com
 * GitHub: https://github.com/gsdios
 *
 * 另（我的自动布局库SDAutoLayout）：
 *  一行代码搞定自动布局！支持Cell和Tableview高度自适应，Label和ScrollView内容自适应，致力于
 *  做最简单易用的AutoLayout库。
 * 视频教程：http://www.letv.com/ptv/vplay/24038772.html
 * 用法示例：https://github.com/gsdios/SDAutoLayout/blob/master/README.md
 * GitHub：https://github.com/gsdios/SDAutoLayout
 *********************************************************************************
 
 */


#import "SDCollectionViewCell.h"
#import "UIView+SDExtension.h"

@interface SDCollectionViewCell ()<UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *imageScrollView;
@property (strong, nonatomic) UIImageView *scaleImg;
@end

@implementation SDCollectionViewCell
{
    __weak UILabel *_titleLabel;
    CGFloat offset;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupImageView];
        [self.contentView addSubview:self.imageScrollView];
        [self setupTitleLabel];
    }
    
    return self;
}

- (void)setTitleLabelBackgroundColor:(UIColor *)titleLabelBackgroundColor
{
    _titleLabelBackgroundColor = titleLabelBackgroundColor;
    _titleLabel.backgroundColor = titleLabelBackgroundColor;
}

- (void)setTitleLabelTextColor:(UIColor *)titleLabelTextColor
{
    _titleLabelTextColor = titleLabelTextColor;
    _titleLabel.textColor = titleLabelTextColor;
}

- (void)setTitleLabelTextFont:(UIFont *)titleLabelTextFont
{
    _titleLabelTextFont = titleLabelTextFont;
    _titleLabel.font = titleLabelTextFont;
}

- (void)setupImageView
{
    UIImageView *imageView = [[UIImageView alloc] init];
    _imageView = imageView;
    [self.contentView addSubview:imageView];
}

- (void)setupTitleLabel
{
    UILabel *titleLabel = [[UILabel alloc] init];
    _titleLabel = titleLabel;
    _titleLabel.hidden = YES;
    [self.contentView addSubview:titleLabel];
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    _titleLabel.text = [NSString stringWithFormat:@"   %@", title];
    if (_titleLabel.hidden) {
        _titleLabel.hidden = NO;
    }
}

-(void)setTitleLabelTextAlignment:(NSTextAlignment)titleLabelTextAlignment
{
    _titleLabelTextAlignment = titleLabelTextAlignment;
    _titleLabel.textAlignment = titleLabelTextAlignment;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.onlyDisplayText) {
        _titleLabel.frame = self.bounds;
    } else {
        [_imageScrollView setFrame: self.bounds];
        _imageScrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        self.scaleImg.frame = self.bounds;
        _imageView.frame = self.bounds;
        CGFloat titleLabelW = self.sd_width;
        CGFloat titleLabelH = _titleLabelHeight;
        CGFloat titleLabelX = 0;
        CGFloat titleLabelY = self.sd_height - titleLabelH;
        _titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    }
}

#pragma mark  ------------------缩放--------------------------
#pragma mark -set与get
-(void)setIsCanScale:(BOOL)isCanScale
{
    _isCanScale = isCanScale;
    _imageScrollView.hidden = !isCanScale;
    
    if (_isCanScale) {
        _imageScrollView.maximumZoomScale = 2.0;
    }else{
        _imageScrollView.maximumZoomScale = 1.0;
    }
    
}

- (void)setImage:(UIImage *)image{
    _image = image;
    self.imageView.image = image;
    self.scaleImg.image = image;
}

-(UIScrollView *)imageScrollView
{
    if (!_imageScrollView) {
        UITapGestureRecognizer *doubleTap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        [doubleTap setNumberOfTapsRequired:2];
        
        _imageScrollView = [[UIScrollView alloc] init];
        _imageScrollView.backgroundColor = [UIColor clearColor];
        _imageScrollView.delegate = self;
        _imageScrollView.minimumZoomScale = 1.0;
        _imageScrollView.maximumZoomScale = 2.0;
        [_imageScrollView setZoomScale:1.0];
        [self.scaleImg addGestureRecognizer:doubleTap];
        [_imageScrollView addSubview:self.scaleImg];
        _imageScrollView.hidden = YES;
    }
    return _imageScrollView;
}

- (UIImageView *)scaleImg{
    if (!_scaleImg) {
        _scaleImg = [[UIImageView alloc]init];
    }
    return _scaleImg;
}

#pragma mark - 缩放

-(void)handleDoubleTap:(UIGestureRecognizer *)gesture{
    
    float newScale = [(UIScrollView*)gesture.view.superview zoomScale] * 1.5;
    CGRect zoomRect = [self zoomRectForScale:newScale  inView:(UIScrollView*)gesture.view.superview withCenter:[gesture locationInView:gesture.view]];
    [(UIScrollView*)gesture.view.superview zoomToRect:zoomRect animated:YES];
}

- (CGRect)zoomRectForScale:(float)scale inView:(UIScrollView*)scrollView withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    zoomRect.size.height = [scrollView frame].size.height / scale;
    zoomRect.size.width  = [scrollView frame].size.width  / scale;
    
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}


#pragma mark - ScrollView delegate

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    for (UIView *v in scrollView.subviews){
        return v;
    }
    return nil;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == self.imageScrollView){
        CGFloat x = scrollView.contentOffset.x;
        if (x==offset){
            
        }else {
            offset = x;
            for (UIScrollView *s in scrollView.subviews){
                if ([s isKindOfClass:[UIScrollView class]]){
                    [s setZoomScale:1.0];
                }
            }
        }
    }
}

@end
