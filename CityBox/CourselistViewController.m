//
//  CourselistViewController.m
//  CityHelper
//
//  Created by MrLoong on 15/10/10.
//  Copyright © 2015年 MrLoong. All rights reserved.
//




static float const kControllerHeaderViewHeight                = 90.f;
static float const kControllerHeaderToCollectionViewMargin    = 0;
static float const kCollectionViewCellsHorizonMargin          = 12;
static float const kCollectionViewCellHeight                  = 30;
static float const kCollectionViewItemButtonImageToTextMargin = 5;

static float const kCollectionViewToLeftMargin                = 16;
static float const kCollectionViewToTopMargin                 = 12;
static float const kCollectionViewToRightMargin               = 16;
static float const kCollectionViewToBottomtMargin             = 10;

static float const kCellBtnCenterToBorderMargin               = 19;

#import "CourselistViewController.h"
#import "CYLFilterHeaderView.h"
#import "CollectionViewCell.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "CYLDBManager.h"
#import "FoodViewController.h"
#import "ViewController.h"


static NSString * const kCellIdentifier           = @"CellIdentifier";
static NSString * const kHeaderViewCellIdentifier = @"HeaderViewCellIdentifier";
typedef void(^ISLimitWidth)(BOOL yesORNo,id data);

@interface CourselistViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, FilterHeaderViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray          *dataSource;
@property (nonatomic, assign) float            priorCellY;
@property (nonatomic, strong) NSMutableArray   *collectionHeaderMoreBtnHideBoolArray;
@property (nonatomic, strong) NSMutableArray   *firstRowCellCountArray;
@property (nonatomic, strong) NSMutableArray   *expandSectionArray;
@property (nonatomic, strong) UIScrollView     *backgroundView;
@property (nonatomic, strong) UILabel          *titleLabel;
@property (nonatomic, strong) UISwitch         *rowsCountBydefaultSwitch;
@property (nonatomic, strong) NSArray          *rowsCountPerSection;
@property (nonatomic, strong) NSArray          *cellsCountArrayPerRowInSections;



@property NSString *text;
@property NSString *idString;  //食堂id
@property NSString *Canteen;   //食堂编号
@property NSString *Stalls;     //档口

@end

@implementation CourselistViewController



#pragma mark - 💤 LazyLoad Method

- (NSMutableArray *)collectionHeaderMoreBtnHideBoolArray
{
    
    if (_collectionHeaderMoreBtnHideBoolArray == nil) {
        _collectionHeaderMoreBtnHideBoolArray = [[NSMutableArray alloc] init];
        __weak __typeof(self) weakSelf = self;
        [self.dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            __strong typeof(self) strongSelf = weakSelf;
            [strongSelf->_collectionHeaderMoreBtnHideBoolArray addObject:@YES];
        }];
    }
    return _collectionHeaderMoreBtnHideBoolArray;
}

- (NSMutableArray *)firstRowCellCountArray
{
    
    if (_firstRowCellCountArray == nil) {
        _firstRowCellCountArray = [NSMutableArray arrayWithCapacity:self.dataSource.count];
        __weak __typeof(self) weakSelf = self;
        [self.dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            __strong typeof(self) strongSelf = weakSelf;
            @autoreleasepool {
                NSMutableArray *symptoms = [[NSMutableArray alloc] initWithArray:[obj objectForKey:kDataSourceSectionKey]];
                NSUInteger secondRowCellCount = [self firstRowCellCountWithArray:symptoms];
                [strongSelf.firstRowCellCountArray addObject:@(secondRowCellCount)];
            }
        }];
    }
    return _firstRowCellCountArray;
}

- (NSMutableArray *)expandSectionArray
{
    
    if (_expandSectionArray == nil) {
        _expandSectionArray = [[NSMutableArray alloc] init];
    }
    return _expandSectionArray;
}

/**
 *  lazy load _rowsCountPerSection
 *
 *  @return NSArray
 */
- (NSArray *)rowsCountPerSection
{
    
    if (_rowsCountPerSection == nil) {
        _rowsCountPerSection = [[NSArray alloc] init];
        NSMutableArray *rowsCountPerSection = [NSMutableArray array];
        [self.dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            @autoreleasepool {
                NSMutableArray *symptoms = [[NSMutableArray alloc] initWithArray:[obj objectForKey:kDataSourceSectionKey]];
                NSUInteger secondRowCellCount = [[self cellsInPerRowWhenLayoutWithArray:symptoms] count];
                [rowsCountPerSection addObject:@(secondRowCellCount)];
            }
        }];
        _rowsCountPerSection = (NSArray *)rowsCountPerSection;
    }
    
    
    
    return _rowsCountPerSection;
}



/**
 *  lazy load _cellsCountArrayPerRowInSections
 *
 *  @return NSArray
 */
- (NSArray *)cellsCountArrayPerRowInSections
{
    
    if (_cellsCountArrayPerRowInSections == nil) {
        _cellsCountArrayPerRowInSections = [[NSArray alloc] init];
        NSMutableArray *cellsCountArrayPerRowInSections = [NSMutableArray array];
        [self.dataSource enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            @autoreleasepool {
                NSMutableArray *symptoms = [[NSMutableArray alloc] initWithArray:[obj objectForKey:kDataSourceSectionKey]];
                NSArray *cellsInPerRowWhenLayoutWithArray = [self cellsInPerRowWhenLayoutWithArray:symptoms];
                [cellsCountArrayPerRowInSections addObject:cellsInPerRowWhenLayoutWithArray];
            }
        }];
        _cellsCountArrayPerRowInSections = (NSArray *)cellsCountArrayPerRowInSections;
    }
    return _cellsCountArrayPerRowInSections;
}

#pragma mark - ♻️ LifeCycle Method

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"食堂";
    self.backgroundView = [[UIScrollView alloc] initWithFrame:
                           CGRectMake(0, 0,
                                      [UIScreen mainScreen].bounds.size.width,
                                      [UIScreen mainScreen].bounds.size.height)
                           ];
    self.backgroundView.showsVerticalScrollIndicator = NO;
    self.backgroundView.alwaysBounceVertical = YES;
    self.backgroundView.backgroundColor = [UIColor colorWithRed:252.0f/255.f green:252.0f/255.f blue:252.0f/255.f alpha:2.f];
    [self.view addSubview:self.backgroundView];
    
    [self initData];
    [self addCollectionView];
    [self judgeMoreButtonShowWhenDefaultRowsCount:1];
    [self addTableHeaderView];
    [self.backgroundView addSubview:[self addTableHeaderView]];
    self.view.backgroundColor = [UIColor blueColor];
    
    //如果想显示两行，请打开下面两行代码,(这两行代码必须在“[self addTableHeaderView]”之后)
    self.rowsCountBydefaultSwitch.on = YES;
    [self rowsCountBydefaultSwitchClicked:self.rowsCountBydefaultSwitch];
    
  //    self.collectionView.backgroundColor = [UIColor clearColor];
  //  self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"classBack"]];

    
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    self.backgroundView.scrollEnabled = YES;
    [self updateViewHeight];
}

#pragma mark - 🆑 CYL Custom Method

- (void)initData {
    
    self.firstRowCellCountArray = nil;
    self.collectionHeaderMoreBtnHideBoolArray = nil;
    self.dataSource = [NSArray arrayWithArray:[CYLDBManager dataSource]];
}

- (float)cellLimitWidth:(float)cellWidth
            limitMargin:(CGFloat)limitMargin
           isLimitWidth:(ISLimitWidth)isLimitWidth {
    
    float limitWidth = (CGRectGetWidth(self.collectionView.frame) - kCollectionViewToLeftMargin - kCollectionViewToRightMargin - limitMargin);
    if (cellWidth >= limitWidth) {
        cellWidth = limitWidth;
        isLimitWidth?isLimitWidth(YES,@(cellWidth)):nil;
        return cellWidth;
    }
    isLimitWidth?isLimitWidth(NO,@(cellWidth)):nil;
    return cellWidth;
}

/*
 分行规则：cell与cell之间必须有大小为kCollectionViewCellsHorizonMargin的间距，左右可以没有间距。
 ＝》》一旦cell+kCollectionViewCellsHorizonMargin超过contentViewWidth，则肯定要分行。cell超过contentViewWidth也会分行。两者的区别在于cell的宽度，前者还是自身宽度，但后者已经变成了contentViewWidth的宽度。
 */
- (float)textImageWidthAndRightMargin:(NSString *)text
                              content:(id)obj
                                array:(NSArray *)array {
    
    CGFloat contentViewWidth = CGRectGetWidth(self.collectionView.frame) - kCollectionViewToLeftMargin - kCollectionViewToRightMargin;
    __block float cellWidth = [self collectionCellWidthText:text content:obj];
    __block float cellWidthAndRightMargin;
    
    if(cellWidth == contentViewWidth) {
        cellWidthAndRightMargin = contentViewWidth;
    } else {
        if (obj == [array lastObject]) {
            cellWidthAndRightMargin = cellWidth;
        } else {
            [self cellLimitWidth:cellWidth
                     limitMargin:kCollectionViewCellsHorizonMargin
                    isLimitWidth:^(BOOL isLimitWidth, NSNumber *data) {
                        if (isLimitWidth) {
                            //当cell和kCollectionViewCellsHorizonMargin总和大于contentViewWidth，
                            //但是cell却小于contentViewWidth时，还是占一行。
                            cellWidthAndRightMargin = contentViewWidth;
                        } else {
                            //这个地方只是大概的估计下，他不能判断出当加上下一个cell的cellWidthAndRightMargin大于contentViewWidth时，
                            //cellWidthAndRightMargin右侧剩余的部分
                            //所以必须在后续判断与下个一cell的cellWidthAndRightMargin的和超出contentViewWidth时的情况
                            cellWidthAndRightMargin = cellWidth + kCollectionViewCellsHorizonMargin;
                        }
                    }];
        }
    }
    return cellWidthAndRightMargin;
}

- (void)judgeMoreButtonShowWhenDefaultRowsCount:(NSUInteger)defaultRowsCount {
    
    [self.rowsCountPerSection enumerateObjectsUsingBlock:^(id  __nonnull obj, NSUInteger idx, BOOL * __nonnull stop) {
        if ([obj integerValue] > defaultRowsCount) {
            [self.collectionHeaderMoreBtnHideBoolArray replaceObjectAtIndex:idx withObject:@NO];
        } else {
            [self.collectionHeaderMoreBtnHideBoolArray replaceObjectAtIndex:idx withObject:@YES];
        }
    }];
    
    [self.cellsCountArrayPerRowInSections enumerateObjectsUsingBlock:^(id  __nonnull cellsCountArrayPerRow, NSUInteger idx, BOOL * __nonnull stop) {
        NSUInteger __block sum = 0;
        [cellsCountArrayPerRow enumerateObjectsUsingBlock:^(NSNumber  * __nonnull cellsCount, NSUInteger cellsCountArrayPerRowIdx, BOOL * __nonnull stop) {
            if (cellsCountArrayPerRowIdx < defaultRowsCount) {
                sum += [cellsCount integerValue];
            } else {
                //|break;| Stop enumerating ;if wanna continue use |return| to Skip this object
                //http://t.cn/RAsfoAi
                *stop = YES;
                return;
            }
        }];
        [self.firstRowCellCountArray replaceObjectAtIndex:idx withObject:@(sum)];
        
    }];
}

- (NSUInteger)firstRowCellCountWithArray:(NSArray *)array {
    
    CGFloat contentViewWidth = CGRectGetWidth(self.collectionView.frame) - kCollectionViewToLeftMargin - kCollectionViewToRightMargin;
    __block NSUInteger firstRowCellCount = 0;
    NSMutableArray *widthArray = [NSMutableArray array];
    __weak __typeof(array) weakArray = array;
    
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        @autoreleasepool {
            NSString *text = [obj objectForKey:kDataSourceCellTextKey];
            
            
            float cellWidthAndRightMargin = [self textImageWidthAndRightMargin:text
                                                                       content:obj
                                                                         array:weakArray];
            [widthArray  addObject:@(cellWidthAndRightMargin)];
            NSArray *sumArray = [NSArray arrayWithArray:widthArray];
            NSNumber *sum = [sumArray valueForKeyPath:@"@sum.self"];
            //之所以要减去kCollectionViewToRightMargin，是为防止这种情况发生：
            //⓵https://i.imgur.com/6yFPQ8U.gif ⓶https://i.imgur.com/XzfNVda.png
            CGFloat firstRowWidth = [sum floatValue] - kCollectionViewToRightMargin;
            if ((firstRowWidth <= contentViewWidth)) {
                firstRowCellCount++;
            }
        }
    }];
    return firstRowCellCount;
}

- (NSMutableArray *)cellsInPerRowWhenLayoutWithArray:(NSMutableArray *)array
{
    
    __block NSUInteger secondRowCellCount = 0;
    NSMutableArray *symptoms = [NSMutableArray arrayWithArray:array];
    NSUInteger firstRowCount = [self firstRowCellCountWithArray:symptoms];
    NSMutableArray *cellCount = [NSMutableArray arrayWithObject:@(firstRowCount)];
    for (NSUInteger index = 0; index < [array count]; index++) {
        NSUInteger firstRowCount = [self firstRowCellCountWithArray:symptoms];
        if (symptoms.count != firstRowCount) {
            NSRange range = NSMakeRange(0, firstRowCount);
            [symptoms removeObjectsInRange:range];
            NSUInteger secondRowCount = [self firstRowCellCountWithArray:symptoms];
            secondRowCellCount = secondRowCount;
            [cellCount addObject:@(secondRowCount)];
        } else {
          //  return [self deepCopyWithArray:cellCount];
            return cellCount;
        }
    }
    return  cellCount;
    //return [self deepCopyWithArray:cellCount];
}

-(void)allertinitTitle:(NSString *)title meeeage:(NSString *)message{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                            message:message
                                           delegate:self
                                  cancelButtonTitle:@"确定"
                                  otherButtonTitles:nil];

    [alert show];
}

- (IBAction)submit:(id)sender {
    if ([ViewController getOrder].menuArry.count == 0) {
        
        
        [self allertinitTitle:@"提示" meeeage:@"请先进入档口进行选购"];
    }else{
        [self performSegueWithIdentifier:@"Submit" sender:self];

    }
}

- (float)collectionCellWidthText:(NSString *)text content:(NSDictionary *)content{
    
    float cellWidth;
    CGSize size = [text sizeWithAttributes:
                   @{NSFontAttributeName:
                         [UIFont systemFontOfSize:16]}];
    NSString *picture = [content objectForKey:kDataSourceCellPictureKey];
    BOOL shouldShowPic = [@(picture.length) boolValue];
    if(shouldShowPic) {
        cellWidth = ceilf(size.width) + kCellBtnCenterToBorderMargin * 2;
    } else {
        cellWidth = ceilf(size.width) + kCellBtnCenterToBorderMargin;
    }
    cellWidth = [self cellLimitWidth:cellWidth
                         limitMargin:0
                        isLimitWidth:nil];
    return cellWidth;
}

- (UIView *)addTableHeaderView
{
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kControllerHeaderViewHeight)];
    tableHeaderView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 35, CGRectGetWidth(tableHeaderView.frame), 20)];
    self.titleLabel = titleLabel;
    titleLabel.font = [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor colorWithRed:0 green:150.0/255.0 blue:136.0/255.0 alpha:1.0];
    // NSString *title = @"默认显示一行时的效果如下所示:";
    //        NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:title];
    //        [text addAttribute:NSForegroundColorAttributeName
    //                     value:[UIColor redColor]
    //                     range:NSMakeRange(4, 2)];
    //        titleLabel.attributedText = text;
    //        [tableHeaderView addSubview:titleLabel];
    //        CGSize size = [title sizeWithAttributes:
    //                       @{NSFontAttributeName:
    //                             titleLabel.font}];
    //        float cellWidth = ceilf(size.width);
    //   仅修改titleLabel的宽度,xyh值不变
    //        titleLabel.frame = CGRectMake(CGRectGetMinX(titleLabel.frame),
    //                                      CGRectGetMidY(titleLabel.frame),
    //                                      cellWidth,
    //                                      CGRectGetHeight(titleLabel.frame)
    //                                      );
    UISwitch *rowsCountBydefaultSwitch = [[UISwitch alloc] init];
    rowsCountBydefaultSwitch.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame) + 10,
                                                25, 30, 20);
    [tableHeaderView addSubview:rowsCountBydefaultSwitch];
    [rowsCountBydefaultSwitch addTarget:self action:@selector(rowsCountBydefaultSwitchClicked:) forControlEvents:UIControlEventAllEvents];
    self.rowsCountBydefaultSwitch = rowsCountBydefaultSwitch;
    UILabel *subtitleLabel = [[UILabel alloc] init];
    subtitleLabel.frame = CGRectMake(CGRectGetMinX(titleLabel.frame),
                                     CGRectGetMaxY(titleLabel.frame) ,
                                     [UIScreen mainScreen].bounds.size.width,
                                     14
                                     );
    subtitleLabel.font = [UIFont systemFontOfSize:13];
    subtitleLabel.textColor = [UIColor grayColor];
    subtitleLabel.text = @"选择额更多，查看更多的食堂档口";
    [tableHeaderView addSubview:subtitleLabel];
    return tableHeaderView;
    //return  nil;
}

- (void)addCollectionView {
    
    CGRect collectionViewFrame = CGRectMake(0, kControllerHeaderViewHeight + kControllerHeaderToCollectionViewMargin, [UIScreen mainScreen].bounds.size.width,
                                            [UIScreen mainScreen].bounds.size.height-40);
    UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame
                                             collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[CollectionViewCell class]
            forCellWithReuseIdentifier:kCellIdentifier];
    self.collectionView.allowsMultipleSelection = YES;
    [self.collectionView registerClass:[CYLFilterHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeaderViewCellIdentifier];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);
    self.collectionView.scrollsToTop = NO;
    self.collectionView.scrollEnabled = NO;
    [self.backgroundView addSubview:self.collectionView];
}

- (void)updateViewHeight {
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView.collectionViewLayout prepareLayout];
    //仅修改self.collectionView的高度,xyw值不变
    self.collectionView.frame = CGRectMake(CGRectGetMinX(self.collectionView.frame),
                                           CGRectGetMinY(self.collectionView.frame),
                                           CGRectGetWidth(self.collectionView.frame),
                                           self.collectionView.contentSize.height +
                                           kCollectionViewToTopMargin +
                                           kCollectionViewToBottomtMargin);
    self.backgroundView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width,
                                                 self.collectionView.contentSize.height +
                                                 kControllerHeaderViewHeight +
                                                 kCollectionViewToTopMargin +
                                                 kCollectionViewToBottomtMargin +
                                                 64);
}

#pragma mark - 🔌 UICollectionViewDataSource Method

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return [self.dataSource count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    
    NSArray *symptoms = [NSArray arrayWithArray:[self.dataSource[section] objectForKey:kDataSourceSectionKey]];
    for (NSNumber *i in self.expandSectionArray) {
        if (section == [i integerValue]) {
            return [symptoms count];
        }
    }
    return [self.firstRowCellCountArray[section] integerValue];
}

- (BOOL)shouldCollectionCellPictureShowWithIndex:(NSIndexPath *)indexPath {
    
    NSMutableArray *symptoms = [NSMutableArray arrayWithArray:[self.dataSource[indexPath.section] objectForKey:kDataSourceSectionKey]];
    NSString *picture = [symptoms[indexPath.row] objectForKey:kDataSourceCellPictureKey];
    NSUInteger pictureLength = [@(picture.length) integerValue];
    if(pictureLength > 0) {
        return YES;
    }
    return NO;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell =
    (CollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier
                                                                    forIndexPath:indexPath];
    cell.button.frame = CGRectMake(0, 0, CGRectGetWidth(cell.frame), CGRectGetHeight(cell.frame));
    NSMutableArray *symptoms = [NSMutableArray arrayWithArray:[self.dataSource[indexPath.section]
                                                               objectForKey:kDataSourceSectionKey]];
    NSString *text = [symptoms[indexPath.row] objectForKey:kDataSourceCellTextKey];
    BOOL shouldShowPic = [self shouldCollectionCellPictureShowWithIndex:indexPath];
    if(shouldShowPic) {
        [cell.button setImage:[UIImage imageNamed:@"home_btn_shrink"]
                     forState:UIControlStateNormal];
        CGFloat spacing = kCollectionViewItemButtonImageToTextMargin;
        cell.button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, spacing);
        cell.button.titleEdgeInsets = UIEdgeInsetsMake(0, spacing, 0, 0);
    } else {
        [cell.button setImage:nil forState:UIControlStateNormal];
        cell.button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        cell.button.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    [cell.button setTitle:text forState:UIControlStateNormal];
    [cell.button setTitle:text forState:UIControlStateSelected];
    [cell.button addTarget:self action:@selector(itemButtonClicked:)
          forControlEvents:UIControlEventTouchUpInside];
    cell.button.section = indexPath.section;
    cell.button.row = indexPath.row;
    return cell;
}

#pragma mark - 🎬 Actions Method

- (void)rowsCountBydefaultSwitchClicked:(UISwitch *)sender {
    
    [self initData];
    [self judgeMoreButtonShowWhenDefaultRowsCount:1];
    
    NSString *title;
    if(sender.isOn) {
        title = @" ";
        [self judgeMoreButtonShowWhenDefaultRowsCount:2];
    } else {
        title = @" ";
    }

    [self.collectionView reloadData];
    __weak __typeof(self) weakSelf = self;
    [self.collectionView performBatchUpdates:^{
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.collectionView reloadData];
    } completion:^(BOOL finished) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf updateViewHeight];
    }];
}

- (void)itemButtonClicked:(CYLIndexPathButton *)button {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:button.row inSection:button.section];
    [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
}

#pragma mark - 🔌 UICollectionViewDelegate Method

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //二级菜单数组
    NSArray *symptoms = [NSArray arrayWithArray:[self.dataSource[indexPath.section]
                                                    objectForKey:kDataSourceSectionKey]];
    NSString *cellTitle = [symptoms[indexPath.row] objectForKey:@"id"];
    _idString = cellTitle;
    _Stalls = [symptoms[indexPath.row] objectForKey:@"name"];
    _Canteen = [symptoms[indexPath.row] objectForKey:@"location"];
    [self performSegueWithIdentifier:@"showFood" sender:self];
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    
    if ([kind isEqual:UICollectionElementKindSectionHeader]) {
        CYLFilterHeaderView *filterHeaderView =
        [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                           withReuseIdentifier:kHeaderViewCellIdentifier
                                                  forIndexPath:indexPath];
        filterHeaderView.moreButton.hidden =
        [self.collectionHeaderMoreBtnHideBoolArray[indexPath.section] boolValue];
        filterHeaderView.delegate = self;
        NSString *sectionTitle = [self.dataSource[indexPath.section] objectForKey:@"type"];
        filterHeaderView.titleButton.tag = indexPath.section;
        filterHeaderView.moreButton.tag = indexPath.section;
        filterHeaderView.moreButton.selected = NO;
        [filterHeaderView.titleButton setTitle:sectionTitle forState:UIControlStateNormal];
        [filterHeaderView.titleButton setTitle:sectionTitle forState:UIControlStateSelected];
        for (NSNumber *i in self.expandSectionArray) {
            if (indexPath.section == [i integerValue]) {
                filterHeaderView.moreButton.selected = YES;
            }
        }
        return (UICollectionReusableView *)filterHeaderView;
    }
    return nil;
}

#pragma mark - 🔌 FilterHeaderViewDelegateMethod Method

- (void)filterHeaderViewMoreBtnClicked:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.expandSectionArray addObject:@(sender.tag)];
    } else {
        [self.expandSectionArray removeObject:@(sender.tag)];
    }
    __weak __typeof(self) weakSelf = self;
    [self.collectionView performBatchUpdates:^{
        __strong typeof(self) strongSelf = weakSelf;
        NSIndexSet *section = [NSIndexSet indexSetWithIndex:sender.tag];
        [strongSelf.collectionView reloadSections:section];
    } completion:^(BOOL finished) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf updateViewHeight];
    }];
}

#pragma mark - 🔌 UICollectionViewDelegateLeftAlignedLayout Method

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *symptoms = [NSArray arrayWithArray:[self.dataSource[indexPath.section] objectForKey:kDataSourceSectionKey]];
    NSString *text = [symptoms[indexPath.row] objectForKey:kDataSourceCellTextKey];
    float cellWidth = [self collectionCellWidthText:text content:symptoms[indexPath.row]];
    return CGSizeMake(cellWidth, kCollectionViewCellHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return kCollectionViewCellsHorizonMargin;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width - 50, 38);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(kCollectionViewToTopMargin, kCollectionViewToLeftMargin, kCollectionViewToBottomtMargin, kCollectionViewToRightMargin);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier  isEqual: @"showFood"]) {
        FoodViewController *food = segue.destinationViewController;
        NSString *str = @"http://csxyxzs.sinaapp.com/stall.php?id=";
        food.URl = [str stringByAppendingString:_idString] ;
        food.Canteen = _Canteen;
        food.Stalls = _Stalls;
    }
}



@end
