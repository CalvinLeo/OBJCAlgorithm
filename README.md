# OBJCAlgorithm

OC语法的相关算法练习

```
// 二分查找
+ (NSInteger)binarySortWithArray:(NSArray<NSNumber *> *)array value:(NSInteger)value
{
    NSUInteger high = array.count - 1;
    NSUInteger low = 0;
    NSUInteger mid;
    while (low < high) {
        mid = low + ((high - low)>>1);
        NSInteger midNumber = [[array objectAtIndex:mid] integerValue];
        if (midNumber == value) {
            return mid;
        }
        else if (midNumber > value) {
            high = mid - 1;
        }
        else {
            low = mid + 1;
        }
    }
    return -1;
}
```
