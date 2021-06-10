import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints.expand(),
        child: Dialog(
          child: SizedBox(
            width: 50.h,
            child: Container(
              height: 100.h,
              width: 50.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    strokeWidth: 1.0,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '加载中...',
                    style: TextStyle(fontSize: 16.0),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
