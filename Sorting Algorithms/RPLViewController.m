//
//  RPLViewController.m
//  Sorting Algorithms
//
//  Created by Richard Lichkus, Chris Meehan, Spencer Fornaciari on 2/25/14.
//  Copyright (c) 2014 Richard Lichkus, Chris Meehan, Spencer Fornaciari. All rights reserved.
//

#import "RPLViewController.h"

BOOL TEST_HEAP_SORT = NO;
BOOL TEST_QUICK_SORT = YES;

@interface RPLViewController ()
{
    NSInteger _heapSize;
}

@end

@implementation RPLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(TEST_HEAP_SORT)
    {
        // Array Data
        NSMutableArray *array = [[NSMutableArray alloc]initWithArray:@[@1,@5,@8,@2,@7,@10,@6,@9,@4,@0]];
        _heapSize = array.count;
        [self printArray:array withDescription:@"Raw Data"];

        // Run Heap
        NSMutableArray *heapedArray = [[NSMutableArray alloc] initWithArray:[self heapArray:array]];
        [self printArray:heapedArray withDescription:@"Heaped Data"];
        
        // Sort Heap
        NSMutableArray *sortedArray = [[NSMutableArray alloc] initWithArray:[self heapSortArray:heapedArray]];
        [self printArray:sortedArray withDescription:@"Sorted Data"];
    }
    else if(TEST_QUICK_SORT){
        NSMutableArray *array = [[NSMutableArray alloc]initWithArray:@[@1,@5,@8,@2,@7,@10,@6,@9,@4,@0]];
        [self printArray:array withDescription:@"Raw Data"];
        
        NSMutableArray *sortedArray = [[NSMutableArray alloc] initWithArray:[self quickSortArray:array]];
        [self printArray:sortedArray withDescription:@"Sorted Data"];
    }

}

//*****************************************************
// Quick Sort Algorthm

-(NSMutableArray *)quickSortArray:(NSMutableArray*)unsortedArray
{
    if(unsortedArray.count <= 1)
    {
        return unsortedArray;
    }
    
    NSInteger pivotIndex;
    
    if(unsortedArray.count % 2)
    {
        pivotIndex = (unsortedArray.count+1)/2;
    } else {
        pivotIndex = unsortedArray.count/2;
    }
    
    NSNumber *pivotValue = unsortedArray[pivotIndex];
    
    [unsortedArray removeObjectAtIndex:pivotIndex];
    
    NSMutableArray *lessArray = [NSMutableArray new];
    NSMutableArray *greaterArray = [NSMutableArray new];
    
    for(NSNumber *num in unsortedArray)
    {
        if(pivotValue.integerValue > num.integerValue)
        {
            [lessArray addObject:num];
        } else
        {
            [greaterArray addObject:num];
        }
    }
    
    NSMutableArray *sortedArray = [[NSMutableArray alloc] init];
    sortedArray = [sortedArray arrayByAddingObjectsFromArray:[self quickSortArray:lessArray]];
    sortedArray = [sortedArray arrayByAddingObjectsFromArray:@[pivotValue]];
    sortedArray = [sortedArray arrayByAddingObjectsFromArray:[self quickSortArray:greaterArray]];
    
    return sortedArray;
}


//*****************************************************
// Heap Sort Algorthm

-(NSMutableArray *)heapArray:(NSMutableArray *)array
{
    for (int i= (array.count-1)/2; i>=0; i--)
    {
        [self maxHeapifyArray:array indexAt: i];
    }
    return array;
}

-(void)maxHeapifyArray:(NSMutableArray *)array indexAt:(NSInteger)indexAt
{
    int r = 2*indexAt+1;
    int l = 2*indexAt+2;
    
    NSNumber *currentParent = array[indexAt];
    
    // Determine left value is larger than parent
    if (l < _heapSize)
    {
        if([array[l] integerValue] > currentParent.integerValue)
        {
            currentParent = array[l];
        }
    }
    // Determine right value is larger than parent
    if(r < _heapSize)
    {
        if([array[r] integerValue] > currentParent.integerValue )
        {
            currentParent = array[r];
        }
    }
    
    // If largest nubmer has changed, run recusion until all parents are larger
    if(!(currentParent.integerValue == [array[indexAt] integerValue]))
    {
        // Get index of the max(right, left) child
        int currentParentIndex = [array indexOfObject: currentParent];
        
        // Exchange the parent and child
        [array exchangeObjectAtIndex:indexAt withObjectAtIndex:currentParentIndex];
        
        // Heapify
        [self maxHeapifyArray:array indexAt:currentParentIndex];
    }
}

-(NSMutableArray *)heapSortArray:(NSMutableArray *)array
{
    for(int i = array.count-1; i>0; i--)
    {
        [array exchangeObjectAtIndex:0 withObjectAtIndex:i];
        _heapSize--;
        [self maxHeapifyArray:array indexAt:0];
    }
    return array;
}

-(void) printArray:(NSMutableArray *)array withDescription:(NSString*)string
{
    NSLog(@"%@",string);
    for(NSNumber *num in array)
    {
        NSLog(@"%i ", num.integerValue);
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
