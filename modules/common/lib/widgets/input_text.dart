import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputText extends StatelessWidget {
  Function(String)? onChanged;

  InputText(
      {Key? key,
      this.hintText = "请输入",
      this.onChanged,
      this.fontSize = 16,
      this.prefixIcon,
      this.isPwd = false,
      this.marginLeft = 0,
      this.marginRight = 8,
      this.marginBottom = 0,
      this.marginTop = 0,
      this.errorText,
      this.inputFormatters,
      this.maxLines = 1,
      this.bgColor = Colors.transparent,
      this.maxLength,
      this.suffixIcon,
      this.prefixText,
      this.prefixStyle,
      this.editingController,
      this.labelText,
      this.enabled = true})
      : super(key: key);

  String? hintText;
  String? prefixText;
  String? errorText;
  IconData? prefixIcon;
  IconData? suffixIcon;
  TextStyle? prefixStyle;
  String? labelText;
  List<TextInputFormatter>? inputFormatters;

  double? fontSize;

  bool isPwd;

  double marginLeft;
  double marginRight;
  double marginTop;
  double marginBottom;
  int maxLines;
  Color? bgColor;
  int? maxLength;
  bool enabled;

  TextEditingController? editingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12, width: 1))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment:
            maxLines > 2 ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(
                left: marginLeft,
                right: marginRight,
                top: marginTop,
                bottom: marginBottom),
            child: Text(labelText ?? "",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.black87,
                )),
          ),
          Expanded(
            child: TextField(
              controller: editingController,
              cursorColor: Colors.black12,
              obscureText: isPwd,
              maxLines: maxLines,
              maxLength: maxLength,
              enabled: enabled,
              inputFormatters: inputFormatters,
              decoration: InputDecoration(
                  errorText: errorText,
                  hintText: hintText,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  focusColor: Colors.black12,
                  filled: true,
                  fillColor: bgColor,
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding: EdgeInsets.fromLTRB(0, 6.h, 0, 0), //文本垂直居中
                  /*focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),*/
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none),
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      suffixIcon,
                      color: Colors.grey,
                    ),
                  ),
                  prefixIcon: prefixIcon == null
                      ? null
                      : Icon(
                          prefixIcon,
                          color: Colors.grey,
                        )),
              autofocus: false,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black87,
              ),
              onChanged: this.onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
