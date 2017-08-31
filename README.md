IQEngCarousel
=========================== 
轮播图、collectionview、无限滚动、定时滚动、Carousel、Autoscroll Banner. 无限循环图片、轮播器、支持横竖屏
****  
![image](https://raw.githubusercontent.com/HersonIQ/IQEngCarousel/master/images/carousel.gif)

### 使用方法
//导入下面四个文件或者libs文件夹到你的工程里面

* IQEngCollectionViewFlowLayout.h
* IQEngCollectionViewFlowLayout.m
* IQEngCarouselView.h
* IQEngCarouselView.m


```objective-c
        self.carouselView = [[IQEngCarouselView alloc] init];
//        self.carouselView.allowAutoNextPage = YES;
//        self.carouselView.allowInfiniteBanner = YES;
//        self.carouselView.timeInterval = 4;
        self.carouselView.delegate = self;
        [self.contentView addSubview:self.carouselView];
```
#### 并完成两个协议
```objective-c
  -(UICollectionViewCell *)iqCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
  
  -(NSInteger)iqCollectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
```
  最大的扩展在于此，根据上面的协议，你可以自定义你需要风格的轮播效果

展示代码
```objective-c

#define IQEngCarouselViewNumberOfSections 100 //限制
#define IQEngCarouselDefualtTimeInterval 4 //默认翻页时间间隙

//定义collectionview点击block
typedef void(^IQEngCarouselClickBlock)(NSIndexPath *indexPath);

@protocol IQEngCarouselViewDelegate <NSObject>//对轮播界面的扩展
@required
-(UICollectionViewCell *)iqCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
-(NSInteger)iqCollectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;

@optional
/**
 相应点击UICollectionViewCell事件，当点击cell时，协议方法和block whenClick 都会执行，协议方法优先级高于block

 @param collectionView UICollectionView
 @param indexPath      坐标
 */
-(void)iqCollectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 优先级高于collectionViewLayout.itemSize

 @param collectionView       UICollectionView
 @param collectionViewLayout flowLayer
 @param indexPath            indexPath

 @return size
 */
-(CGSize)iqCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 当collectionView 滚动是调用此方法（用于自定义轮播扩展）

 @param scrollView <#scrollView description#>
 */
-(void)iqCollectionViewDidEndScrolling:(UIScrollView *)scrollView;

@end

@interface IQEngCarouselView : UIView
<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic, readonly) UIPageControl *pageControl;
@property(nonatomic, readonly) UICollectionView *collectionView;
@property(nonatomic, readonly) NSIndexPath *currentIndexPath;//获取当前显示cell
@property(nonatomic, readonly) NSIndexPath *nextIndexPath;
@property(nonatomic, readonly) NSIndexPath *lastIndexPath;


//flowLayout 未设置时自动设置默认
@property(nonatomic, strong) UICollectionViewFlowLayout *collectionViewLayout;
//递用链传递
@property(nonatomic, assign) id <IQEngCarouselViewDelegate> delegate;
//选中block回调 协议方法优先级高于block
@property(nonatomic, strong) IQEngCarouselClickBlock whenClick;
//允许轮播，不允许时，左右滑到界限不允许滚动  defalut YES
@property(nonatomic, assign) BOOL allowInfiniteBanner;
//允许自动滚动    default YES
@property(nonatomic, assign) BOOL allowAutoNextPage;
//翻页时间间隔 default 4s
@property(nonatomic, assign) NSInteger timeInterval;
//是允许点击中间 cell default NO
@property(nonatomic, assign) BOOL allEqual;

/**
 *  标准初始化方法
 */
-(instancetype)init;
-(instancetype)initWithDelegate:(id <IQEngCarouselViewDelegate>) delegate;
/**
 根据当先cell，寻找合适尺寸

 @param animated <#animated description#>
 */
-(void)iqScrollToMostSuitableAnimated:(BOOL)animated;
/**
 滚动到指定indexPath，若想修改滚动时间和动画。最好的方法是重写此方法

 @param indexPath 目标indexPath
 @param animated  <#animated description#>
 */
-(void)iqScrollToIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;
/**
 cell尺寸  （修改方法：实现IQEngCarouselViewDelegate<collectionView:layout:sizeForItemAtIndexPath:>的代理方法 或者 设置collectionViewLayout.itemSize）
 */
@property(nonatomic, readonly) CGSize itemSize NS_DEPRECATED_IOS(2_0, 5_0, "Pretending to be very NB") __TVOS_PROHIBITED;
@end

```

  ------
  ### i'm here
  |#|·|·|
  |---|----|-----
  |1|`[简书]:http://www.jianshu.com/u/17fadb43646e`|[我的简书](http://www.jianshu.com/u/17fadb43646e)
  |2|`[知乎]:https://www.zhihu.com/people/EngCCC"我的知乎，欢迎关注"` |[我的知乎](https://www.zhihu.com/people/EngCCC)   



### 　　　　　　　　　　　Author:力王
### 　　　　　　　　 E-mail:13767141841@163.com
### 　　　　Q群:619951921 欢淫讨论学术问题 🙃，找到bug请@我
