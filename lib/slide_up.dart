library slide_up;

import 'package:flutter/material.dart';
import 'package:slide_up/slideUp/slide_up_controller.dart';

class SlideUp extends StatefulWidget {
  const SlideUp(
      {Key? key,
      required this.body,
      required this.bottomSheet,
      this.maxHeight = 500,
      this.minHeight = 100,
      this.slideUpController,
      this.initialHeight,
      this.animationDuration = const Duration(milliseconds: 300),
      this.thresholdHeight,
      this.color,
      this.decoration,
      this.alignment,
      this.clipBehavior = Clip.none,
      this.constraints,
      this.curve = Curves.linear,
      this.foregroundDecoration,
      this.margin,
      this.onEnd,
      this.padding,
      this.transform,
      this.transformAlignment,
      this.clickOutSlideToClose = false,
      this.reachedMaxPosition,
      this.reachedMinPosition})
      : assert(
            initialHeight == null ||
                (((initialHeight) >= minHeight) &&
                    ((initialHeight) <= maxHeight)),
            "Initial Height must be less then or equal to maxHeight and greater then or equal to minHeight"),
        assert(
            thresholdHeight == null ||
                ((thresholdHeight) >= minHeight &&
                    (thresholdHeight) <= maxHeight),
            "thresholdHeight must be less then or equal to maxHeight and greater then or equal to minHeight"),
        super(key: key);
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
  final bool clickOutSlideToClose;
  final VoidCallback? reachedMaxPosition;
  final VoidCallback? reachedMinPosition;
  @override
  State<SlideUp> createState() => _SlideUpState();
}

class _SlideUpState extends State<SlideUp> {
  late final double _minHeight = widget.minHeight;
  late final double _maxHeight = widget.maxHeight;
  late final ValueNotifier<double> _currentHeight =
      ValueNotifier(widget.initialHeight ?? _minHeight);
  late final double _thresholdHeight =
      widget.thresholdHeight ?? (_maxHeight / 2);
  late Size _size;
  @override
  void initState() {
    _controllerInit();
    super.initState();
  }

  @override
  void dispose() {
    _controllerDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Stack(children: [
      widget.clickOutSlideToClose
          ? InkWell(
              onTap: () => _currentHeight.value = _minHeight,
              child: widget.body,
            )
          : widget.body,
      Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onVerticalDragEnd: onDragEnd,
          onVerticalDragUpdate: onDragUpdate,
          child: ValueListenableBuilder(
              valueListenable: _currentHeight,
              child: widget.bottomSheet,
              builder: (context, double height, child) {
                return AnimatedContainer(
                  duration: widget.animationDuration,
                  height: height,
                  width: double.infinity,
                  color: widget.color,
                  decoration: widget.decoration,
                  alignment: widget.alignment,
                  clipBehavior: widget.clipBehavior,
                  constraints: widget.constraints,
                  curve: widget.curve,
                  foregroundDecoration: widget.foregroundDecoration,
                  margin: widget.margin,
                  onEnd: widget.onEnd,
                  padding: widget.padding,
                  transform: widget.transform,
                  transformAlignment: widget.transformAlignment,
                  child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: child),
                );
              }),
        ),
      )
    ]);
  }

  void _controllerInit() {
    widget.slideUpController?.setMinHeight(_minHeight);
    widget.slideUpController?.setMaxHeight(_maxHeight);
    widget.slideUpController?.setInitialHeight(_minHeight);
    widget.slideUpController?.addListener(() {
      _currentHeight.value =
          widget.slideUpController?.currentValue ?? _currentHeight.value;
    });
  }

  void _controllerDispose() {
    _currentHeight.dispose();
    widget.slideUpController?.dispose();
    widget.slideUpController?.removeListener(() {});
  }

  void onDragEnd(DragEndDetails details) {
    if (_currentHeight.value >= _thresholdHeight) {
      _currentHeight.value = _maxHeight;
      if (widget.reachedMaxPosition != null) {
        widget.reachedMaxPosition!();
      }
    } else {
      _currentHeight.value = _minHeight;
      if (widget.reachedMinPosition != null) {
        widget.reachedMinPosition!();
      }
    }
    widget.slideUpController?.setInitialHeight(_currentHeight.value);
  }

  void onDragUpdate(DragUpdateDetails details) {
    _currentHeight.value = _size.height - details.globalPosition.dy;
    if (_currentHeight.value < _minHeight) {
      _currentHeight.value = _minHeight;
    } else if (_currentHeight.value >= _maxHeight) {
      _currentHeight.value = _maxHeight;
    }
    widget.slideUpController?.setInitialHeight(_currentHeight.value);
  }
}
