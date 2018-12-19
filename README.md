# NZHSegueIconView

Segue icon view is a common component in business application, and NZHSegueIconView allows you to create a segue icon view simply.

## Installation
1. Download all the files in the `NZHSegueIconView`.
2. Add the source files folder to your Xcode project.
3. Include wherever you need it with `#import "SegueView.h"`.

## Usage
The normal usage is like this, only need an icons array and a title string array for the icons:
```Objective-C
    SegueView *segueView = [[SegueView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 180) edgeDistance:27];
    segueView.iconImageArray = @[[UIImage imageNamed:@"location"],
                                 [UIImage imageNamed:@"location"],
                                 [UIImage imageNamed:@"location"],
                                 [UIImage imageNamed:@"location"],
                                 [UIImage imageNamed:@"location"],
                                 [UIImage imageNamed:@"location"],
                                 [UIImage imageNamed:@"location"]];
    segueView.infoTextArray = @[@"全科", @"妇产科", @"儿科", @"口腔科", @"眼科", @"皮肤科", @"内分泌科"];
```
![SegueIconViewSingle](https://github.com/iiyumewo/NZHSegueIconView/blob/master/ReadME/SegueIconViewSingle.gif?raw=true)

If the number of icons exceeds 8, it will automatically make the page scrollable to show the other icons:
![SegueIconViewPlural](https://github.com/iiyumewo/NZHSegueIconView/blob/master/ReadME/SegueIconViewPlural.gif?raw=true)
