import 'package:flutter_screenutil/flutter_screenutil.dart';

class SWS {
  static height(double height) {
    return ScreenUtil().setHeight(height);
  }

  static width(double width) {
    return ScreenUtil().setWidth(width);
  }

  static fontSize(double police) {
    return ScreenUtil().setSp(police);
  }
}