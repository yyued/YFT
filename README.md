# YFT

YFT 是一个轻量级的字符渲染库，你可以使用 YFT 将字元拼接成 Image 或是 Label

当前 YFT 支持输出至以下平台

* iOS
* Android

并计划输出至以下平台

* Web

## 使用

### 生成 YFT 字体文件

** 只能使用 macOS 进行本操作

1. Clone 本仓库，将你的字元放置在 res/xxx/ 目录下（将 xxx 替换为你的字体名称）；
2. 双击执行 RunScript（如遇权限问题，sudo chmod 777 这个文件即可）；
3. 在 YFTs 目录下，得到 yft 字体文件，用于集成。

### 集成至 iOS

使用 CocoaPods 集成，在 Podfile 中添加以下依赖

```
pod 'YFT', :podspec => 'https://raw.githubusercontent.com/yyued/YFT/master/ios/YFT.podspec'
```

将 yft 字体文件添加至工程包中，然后在需要的地方，使用以下方式获得 Image

```
UIImage *textImage = [YFTImage imageNamed:@"pop_score_big"
                               canvasSize:CGSizeMake(300, 66)
                                  andText:@"123"
                              letterSpace:-2
                            textAlignment:NSTextAlignmentCenter];
```

Label 的使用方法，参照本 GitHub Sample。

### 集成至 Android

使用 Gradle 集成，集成方法参照 [https://jitpack.io/#yyued/YFT](https://jitpack.io/#yyued/YFT)

将 yft 字体文件添加至 assets 目录下，在需要的地方，使用以下方式获得 Bitmap

···
try {
    Bitmap bitmap = YFTImage.create(this, "pop_score_big", 300 * getResources().getDisplayMetrics().density, 66 * getResources().getDisplayMetrics().density, getResources().getDisplayMetrics().density, "123", -2, 1);
} catch (Exception e) {
    e.printStackTrace();
}
···

Label 的使用方法，参照本 GitHub Sample。


