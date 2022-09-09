
## slide_up
### create a slider




## Installation

Add slide_up to your pubspec.yaml dependencies. And import it:

```bash
  slide_up: ^1.0.0
```
    
## How to use #

Simply create a SlideUp widget, and pass the required params:

```bash
  SlideUp( 
          color: Color.fromRGBO(244, 67, 54, 1),
          body: Container(
            color: Colors.yellow,
          ), 
          bottomSheet: Container(
            color: Colors.green,
            child: Text("g")
          )
    ),
```


## Params

```dart
  final Widget body;
  final Widget bottomSheet;
  final double maxHeight;
  final double minHeight;
  final double? initialHeight;
  final SlideUpController? slideUpController;
  final Duration animationDuration;
  final double? thresholdHeight;
  final Color? color;
  final Decoration? decoration;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final Decoration? foregroundDecoration;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry? margin;
  final Matrix4? transform;
  final AlignmentGeometry? transformAlignment;
  final Clip clipBehavior;
  final Curve curve;
  final void Function()? onEnd;
  final bool clickOutSlideToClose;  // default value is false 
  final VoidCallback? reachedMaxPosition;
  final VoidCallback? reachedMinPosition;
```


## Screenshots

![App Screenshot](https://github.com/praveen576232/slide_up/blob/main/screenshots/preview.gif?raw=true)


## SlideController methods
``` bash 
.goToMinPosition()

```
go to the min position

``` bash 
.goToMaxPosition()

```
go to the max position

## SlideController value
``` bash 
 currentValue (get a currentValue of slider)

 minHeight (get a minHeight of slider)

 maxHeight (get a maxHeight of slider)

 inMinPosition (true if slider reach min position)
 
 inMaxPosition (true if slider reach max position)
```

## Badges


[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)


