import 'package:flutter/cupertino.dart';

class LoadingWidget extends StatelessWidget {
  final double? width;
  final double? height;

  const LoadingWidget({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: width ?? 40,
        width: height ?? 40,
        child: CupertinoTheme(
          data: CupertinoTheme.of(context).copyWith(
            brightness: Brightness.light,
          ),
          child: const CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}
