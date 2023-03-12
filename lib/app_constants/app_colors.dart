import 'dart:ui';

final _AppColors appColors = _AppColors.instance;

class _AppColors {
  _AppColors._();

  static final _AppColors instance = _AppColors._();

  Color background = const Color(0xfffcf3f0);
  Color white = const Color(0xffffffff);
  Color textGrey = const Color(0xff7c7c7c);
  Color shimmerGrey = const Color(0xffcccccc);
  Color textGreyDark = const Color(0xff545454);
  Color hintText = const Color(0xff878686);
  Color textDark = const Color(0xff2f2f2f);
  Color red = const Color(0xff650000);
  Color yellow = const Color(0xfffdce2d);
}
