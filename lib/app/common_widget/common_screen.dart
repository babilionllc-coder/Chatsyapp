import '../helper/all_imports.dart';
import '../helper/font_family.dart';

class CommonScreen extends StatefulWidget {
  final String? title;
  final double? lineUpScrollBtn;
  final ScrollController? scrollController;
  final Widget body;
  final Widget? leading;
  final bool? centerTitle;
  final double? leadingWidth;
  final bool? extendBodyBehindAppBar;
  final bool? resizeToAvoidBottomInset;
  final List<Widget>? actions;
  final Widget? bottomSheet;
  final Widget? titleView;
  final EdgeInsetsGeometry? padding;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Color? backgroundColor;
  final double? toolbarHeight;
  void Function()? leadingOnTap;
  PreferredSizeWidget? bottom;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? floatingActionButton;
  final bool isBottom;
  final Color? appBarBackGroundColor;

  CommonScreen({
    super.key,
    this.title,
    required this.body,
    this.leading,
    this.centerTitle,
    this.lineUpScrollBtn,
    this.leadingWidth,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.extendBodyBehindAppBar,
    this.leadingOnTap,
    this.titleView,
    this.actions,
    this.systemOverlayStyle,
    this.resizeToAvoidBottomInset,
    this.backgroundColor,
    this.toolbarHeight,
    this.drawer,
    this.floatingActionButton,
    this.scrollController,
    this.floatingActionButtonLocation,
    this.appBarBackGroundColor,
    this.padding,
    this.isBottom = false,
    // this.key,
  });

  @override
  State<CommonScreen> createState() => _CommonScreenState();
}

class _CommonScreenState extends State<CommonScreen> {
  RxBool isAtTop = false.obs;

  void scroll() {
    widget.scrollController!.animateTo(
      widget.scrollController!.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    if (widget.scrollController != null) {
      widget.scrollController?.addListener(() {
        if (widget.scrollController!.offset <
                widget.scrollController!.position.maxScrollExtent - 100 &&
            !isAtTop.value) {
          isAtTop.value = true;
        } else if (widget.scrollController!.offset >=
                widget.scrollController!.position.maxScrollExtent - 100 &&
            isAtTop.value) {
          isAtTop.value = false;
        }
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        utils.hideKeyboard();
      },
      child: Scaffold(
        extendBodyBehindAppBar: widget.extendBodyBehindAppBar ?? false,
        backgroundColor: widget.backgroundColor ?? AppColors().backgroundColor1,
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        drawer: widget.drawer,
        appBar:
            (widget.toolbarHeight != null && widget.toolbarHeight == 0)
                ? null
                : AppBar(
                  backgroundColor: widget.appBarBackGroundColor ?? AppColors.transparent,
                  elevation: 0,
                  toolbarHeight: widget.toolbarHeight ?? 70,
                  scrolledUnderElevation: 0,
                  systemOverlayStyle:
                      widget.systemOverlayStyle ??
                      SystemUiOverlayStyle(
                        statusBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
                        statusBarBrightness: isLight ? Brightness.light : Brightness.dark,
                      ),

                  leadingWidth: widget.leadingWidth ?? commonLeadingWith + 40.px,
                  centerTitle: widget.centerTitle ?? true,
                  actions: widget.actions,
                  // scrolledUnderElevation: 0, // To doesn't change bg color of AppBar while scroll
                  leading: Center(
                    child:
                        widget.leading ??
                        (ModalRoute.of(context)?.impliesAppBarDismissal == true
                            ? GestureDetector(
                              onTap:
                                  widget.leadingOnTap ??
                                  () {
                                    Get.back();
                                  },
                              child: Container(
                                color: AppColors.transparent,
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: AppColors().darkAndWhite,
                                  size: 20.px,
                                ),
                              ),
                            )
                            : null),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: AppText(
                          widget.title ?? "",
                          maxLines: 1,
                          fontSize: 18.px,
                          fontFamily: FontFamily.helveticaBold,
                          color: AppColors().darkAndWhite,
                        ),
                      ),
                      if (widget.titleView != null) SizedBox(width: 5.px),
                      if (widget.titleView != null) widget.titleView!,
                      // if (titleView != null) SizedBox(width: 5.px),
                    ],
                  ),
                ),
        body: widget.body,
        bottomSheet: widget.bottomSheet,
        bottomNavigationBar: widget.bottomNavigationBar,
        floatingActionButton: Obx(() {
          isAtTop.value;
          return (widget.scrollController != null &&
                  (!ChatApi.isStreamingData.value) &&
                  isAtTop.value &&
                  (widget.lineUpScrollBtn != null) &&
                  (MediaQuery.of(context).viewInsets.bottom == 0))
              ? Align(
                alignment: Alignment(
                  0.1,
                  (MediaQuery.of(context).viewInsets.bottom == 0) ? widget.lineUpScrollBtn! : 0.9,
                ),
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: FittedBox(
                    child: FloatingActionButton(
                      mini: true,
                      backgroundColor: AppColors.primary,
                      shape: CircleBorder(),
                      onPressed: scroll,
                      child: const Icon(Icons.arrow_downward, color: AppColors.white),
                    ),
                  ),
                ),
              )
              : SizedBox();
        }),
        // floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterTop,
      ),
    );
  }
}
