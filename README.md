# OC版本的算法练习
#### 排序、查找算法包括
* 二分查找
* 冒牌排序
* 插入排序
* 选择排序
* OC自带的排序方式

OC自带的排序方式有：NSComparator、NSDescriptor、Selector。

#### 二叉树相关

**二叉树基本概念**

二叉树是每个节点最多有两个字树的树结构

**根节点：** 一棵树最上面的结点成为根结点。
**父结点：** 一个结点下面连接多个结点，那么该结点称为父结点。
**子结点：** 一个结点下面连接的多个结点称为该结点的子结点。
**叶子结点：** 没有任何子结点的结点称为叶子结点。
**兄弟结点：** 具有相同父结点的结点互称为兄弟结点。
**结点的度：** 结点拥有的子结点的个数称为结点的度。
**满二叉树：** 除最后一层无任何子结点外，每一层上的所有结点都有左右两个子结点，最后一层都是叶子结点。
**完全二叉树：** 若设二叉树的高度为h，除第 h 层外，其它各层 (1～h-1) 的结点数都达到最大个数，第h层有叶子结点，并且叶子结点都是从左到右依次排布，这就是完全二叉树
**平衡二叉树：** 平衡二叉树又被称为AVL树（区别于AVL算法），它是一棵二叉排序树，且具有以下性质：它是一棵空树或它的左右两个子树的高度差的绝对值不超过1，并且左右两个子树都是一棵平衡二叉树。

#### 队列相关

CLQueue:

非常简单的一个队列实现，根据NSMutableArray相关方法，设计QueuePush，QueuePop的入列和出列方法。