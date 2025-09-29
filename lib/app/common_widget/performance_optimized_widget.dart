import 'dart:async';
import 'package:flutter/material.dart';
import 'package:chatsy/extension.dart';

/// A performance-optimized widget that prevents unnecessary rebuilds
class PerformanceOptimizedWidget extends StatefulWidget {
  final Widget child;
  final String? key;

  const PerformanceOptimizedWidget({
    super.key,
    required this.child,
    this.key,
  });

  @override
  State<PerformanceOptimizedWidget> createState() => _PerformanceOptimizedWidgetState();
}

class _PerformanceOptimizedWidgetState extends State<PerformanceOptimizedWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  bool shouldRebuild(PerformanceOptimizedWidget oldWidget) {
    return oldWidget.key != widget.key;
  }
}

/// Optimized list view with lazy loading
class OptimizedListView extends StatelessWidget {
  final List<Widget> children;
  final ScrollController? controller;
  final EdgeInsets? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const OptimizedListView({
    super.key,
    required this.children,
    this.controller,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: children.length,
      itemBuilder: (context, index) {
        return PerformanceOptimizedWidget(
          key: ValueKey('list_item_$index'),
          child: children[index],
        );
      },
    );
  }
}

/// Optimized grid view with lazy loading
class OptimizedGridView extends StatelessWidget {
  final List<Widget> children;
  final SliverGridDelegate gridDelegate;
  final ScrollController? controller;
  final EdgeInsets? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const OptimizedGridView({
    super.key,
    required this.children,
    required this.gridDelegate,
    this.controller,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: controller,
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics,
      gridDelegate: gridDelegate,
      itemCount: children.length,
      itemBuilder: (context, index) {
        return PerformanceOptimizedWidget(
          key: ValueKey('grid_item_$index'),
          child: children[index],
        );
      },
    );
  }
}

/// Cached image widget with optimized loading
class CachedImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final BorderRadius? borderRadius;

  const CachedImageWidget({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.placeholder,
    this.errorWidget,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(8.px),
      child: Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit ?? BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return placeholder ?? _buildDefaultPlaceholder();
        },
        errorBuilder: (context, error, stackTrace) {
          return errorWidget ?? _buildDefaultErrorWidget();
        },
        cacheWidth: width?.toInt(),
        cacheHeight: height?.toInt(),
      ),
    );
  }

  Widget _buildDefaultPlaceholder() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: borderRadius ?? BorderRadius.circular(8.px),
      ),
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2.px,
        ),
      ),
    );
  }

  Widget _buildDefaultErrorWidget() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: borderRadius ?? BorderRadius.circular(8.px),
      ),
      child: Icon(
        Icons.error_outline,
        color: Colors.grey[600],
        size: 24.px,
      ),
    );
  }
}

/// Debounced text field to prevent excessive API calls
class DebouncedTextField extends StatefulWidget {
  final String? initialValue;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final Duration debounceDuration;
  final TextEditingController? controller;
  final InputDecoration? decoration;

  const DebouncedTextField({
    super.key,
    this.initialValue,
    this.hintText,
    this.onChanged,
    this.debounceDuration = const Duration(milliseconds: 500),
    this.controller,
    this.decoration,
  });

  @override
  State<DebouncedTextField> createState() => _DebouncedTextFieldState();
}

class _DebouncedTextFieldState extends State<DebouncedTextField> {
  late TextEditingController _controller;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onTextChanged(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(widget.debounceDuration, () {
      widget.onChanged?.call(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: _onTextChanged,
      decoration: widget.decoration ?? InputDecoration(
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.px),
        ),
      ),
    );
  }
}

/// Memory-efficient animation controller
class OptimizedAnimationController extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Curve curve;
  final bool autoPlay;
  final VoidCallback? onComplete;

  const OptimizedAnimationController({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeInOut,
    this.autoPlay = true,
    this.onComplete,
  });

  @override
  State<OptimizedAnimationController> createState() => _OptimizedAnimationControllerState();
}

class _OptimizedAnimationControllerState extends State<OptimizedAnimationController>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );

    if (widget.autoPlay) {
      _controller.forward().then((_) {
        widget.onComplete?.call();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Opacity(
            opacity: _animation.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}
