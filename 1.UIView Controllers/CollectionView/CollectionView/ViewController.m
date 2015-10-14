//
//  ViewController.m
//  CollectionView
//
//  Created by JzChang on 13/11/9.
//  Copyright (c) 2013年 JzChang. All rights reserved.
//

#import "ViewController.h"
#import "PhotoCollectionViewCell.h"

static NSString *const kCellIdentifier = @"cellIdentifier";

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    UICollectionView *photoCollectionView;
    NSArray *recipeImages;
}

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	CGRect rect = self.view.bounds;
	photoCollectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:flowLayout];
	photoCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[flowLayout setSectionInset:UIEdgeInsetsMake(10.0, 0.0, 0.0, 0.0)];
	[photoCollectionView setBackgroundColor:[UIColor grayColor]];
	photoCollectionView.delegate = self;
	photoCollectionView.dataSource = self;
	[self.view addSubview:photoCollectionView];
    
    [photoCollectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier];
    
    recipeImages = [NSArray arrayWithObjects:@"angry_birds_cake.jpg", @"creme_brelee.jpg", @"egg_benedict.jpg", @"full_breakfast.jpg", @"green_tea.jpg", @"ham_and_cheese_panini.jpg", @"ham_and_egg_sandwich.jpg", @"hamburger.jpg", @"instant_noodle_with_egg.jpg", @"japanese_noodle_with_pork.jpg", @"mushroom_risotto.jpg", @"noodle_with_bbq_pork.jpg", @"starbucks_coffee.jpg", @"thai_shrimp_cake.jpg", @"vegetable_curry.jpg", @"white_chocolate_donut.jpg", nil];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return recipeImages.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    cell.photoImageView.image = [UIImage imageNamed:[recipeImages objectAtIndex:indexPath.row]];

    return cell;
}

#pragma mark- UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return CGSizeMake(100.f, 100.f);
}

@end
