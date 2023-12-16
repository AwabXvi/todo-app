import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constants.dart';

//
class InputWidget extends StatelessWidget {
  //
  final TextInputType? textInputType;
  final String? emptyMsg;
  final String? hint;
  final String? lableTxt;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final int? maxLines;
  final int? maxLength;
  final bool? obscureText;
  final bool? autofocus;
  final bool? isShowBuildCounter;
  final ValueChanged? onChange;
  final Function? changeValueObScureText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final AutovalidateMode? autovalidateMode;
  final EdgeInsets? margin;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double? height;
  final double? fontSize;
  final double? borderWidth;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final Color? color;
  final void Function()? onTap;
  final String? prefixText;
  final bool? filled;
  final Color? fillColor;
  final double? hintFontSize;
  final double? lableFontSize;
  final double? raduis;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? inputFormat;

  //
  const InputWidget(
      {Key? key,
      this.inputFormat,
      this.lableFontSize,
      this.focusNode,
      this.emptyMsg,
      this.hint,
      this.obscureText,
      this.lableTxt,
      this.controller,
      this.maxLines,
      this.maxLength,
      this.onChange,
      this.autovalidateMode,
      this.validator,
      this.margin,
      this.textInputType,
      this.changeValueObScureText,
      this.suffixIcon,
      this.prefixIcon,
      this.height,
      this.contentPadding,
      this.textStyle,
      this.onFieldSubmitted,
      this.color,
      this.fontSize,
      this.onTap,
      this.autofocus,
      this.isShowBuildCounter,
      this.prefixText,
      this.borderWidth,
      this.filled,
      this.fillColor,
      this.hintFontSize,
      this.raduis,
      this.textAlign})
      : super(key: key);

  //
  @override
  Widget build(BuildContext context) {
    //
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      autofocus: autofocus ?? false,
      maxLength: maxLength ?? 80,
      maxLines: maxLines ?? 1,
      keyboardType: textInputType,
      cursorColor: Constants.orange,
      textAlign: textAlign ?? TextAlign.start,
      textDirection: TextDirection.ltr,
      inputFormatters: inputFormat,
      textInputAction: TextInputAction.done,
      autovalidateMode: autovalidateMode ?? AutovalidateMode.onUserInteraction,
      validator: validator,
      onChanged: onChange,
      style: textStyle,
      onTap: onTap,
      onFieldSubmitted: (value) {},
      cursorHeight: 25.0,
      decoration: InputDecoration(
        labelText: lableTxt,
        counterText: '',
        labelStyle: TextStyle(
            fontSize: 14.0,
            fontFamily: Constants.fontFamily,
            color: focusNode!.hasFocus ? Constants.orange : Constants.txtGrey),
        isDense: true,
        prefixText: prefixText ?? '',
        prefixStyle: const TextStyle(
          fontSize: 10.0,
          // fontWeight: FontWeight.bold,
        ),
        // hint
        hintText: hint,

        hintStyle: TextStyle(
            fontSize: hintFontSize ?? 16,
            color: Colors.black26,
            fontFamily: Constants.fontFamily //filled
            ),
        // error
        errorStyle: const TextStyle(
            fontSize: 12, fontFamily: Constants.fontFamily //filled

            ),
        prefixIconConstraints:
            const BoxConstraints(maxWidth: 20, maxHeight: 20),
        suffixIconConstraints:
            const BoxConstraints(maxWidth: 20, maxHeight: 20),
        // outlineBorder
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(raduis ?? 5.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(raduis ?? 5.0),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1,
          ),
        ),

        contentPadding: contentPadding ?? const EdgeInsets.only(right: 10.0),
        filled: filled ?? false,
        fillColor: fillColor,
        //
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(raduis ?? 5.0),
          borderSide: BorderSide(
            color: Constants.orange,
            width: borderWidth ?? 1.0,
          ),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        //
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(raduis ?? 5.0),
          borderSide:
              BorderSide(color: Constants.grey_20, width: borderWidth ?? 1.0),
        ),
      ),
    );
  }
}
