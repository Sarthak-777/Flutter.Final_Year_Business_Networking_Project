import 'package:flutter/material.dart';
import 'package:drag_down_to_pop/drag_down_to_pop.dart';

class ImageViewerPageRoute extends MaterialPageRoute {
  ImageViewerPageRoute({required WidgetBuilder builder})
      : super(builder: builder, maintainState: false);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return const DragDownToPopPageTransitionsBuilder()
        .buildTransitions(this, context, animation, secondaryAnimation, child);
  }

  @override
  bool canTransitionFrom(TransitionRoute previousRoute) {
    return false;
  }

  @override
  bool canTransitionTo(TransitionRoute nextRoute) {
    return false;
  }
}
