import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../Style/AppTheme.dart';
import '../../Style/Borders.dart';
import '../../Style/Fonts.dart';
import '../../Utils/CommonWidget.dart';

class CustomTextField extends StatefulWidget {
  late final TextEditingController tecController;
  late final FocusNode focusNode;
  late final TextInputType? textInputType;
  late final String? hintText, errorText;
  late String? labelText;
  final FormFieldValidator? validator;
  List<TextInputFormatter>? inputFormatters = [];
  bool? enableSuggestions = false;
  bool? isShowSuffixIcon = false;
  bool? showSuffixDivider = false;
  bool? isShowPrefixIcon = false;
  bool? showCursor = true;
  bool? readOnly = false;
  final TextInputAction? textInputAction;
  int? maxLines, minLines, maxLength, height;
  double? paddingTop, paddingBottom, paddingLeft, paddingRight;
  double? suffixIconHeight, suffixPaddingTop, suffixPaddingBottom, suffixPaddingLeft, suffixPaddingRight;
  double? contentPaddingTop, contentPaddingBottom, contentPaddingLeft, contentPaddingRight;
  bool? isPassword = false;
  bool? obscureText = false;
  var fillColor;
  var hintColor;
  bool? enabled = true;
  VoidCallback? onTap, onTapOutSide;
  OutlineInputBorder? border;
  TextStyle? errorStyle;
  BoxDecoration? suffixIconDecoration;
  Border? suffixIconBorder;
  Widget? suffixIcon, prefixIcon;
  Color? suffixIconColor;
  Function? onTapSuffixIcon;
  TextStyle? textStyle;
  TextStyle? hintStyle;
  TextStyle? labelStyle;

  CustomTextField({
    super.key,
    required this.tecController,
    required this.focusNode,
    required this.hintText,
    this.labelText,
    this.errorText,
    this.prefixIcon,
    this.validator,
    this.inputFormatters,
    this.textInputType,
    this.enableSuggestions,
    this.isShowSuffixIcon,
    this.showSuffixDivider,
    this.isShowPrefixIcon,
    this.textInputAction,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.height,
    this.fillColor,
    this.hintColor,
    this.paddingTop,
    this.paddingBottom,
    this.paddingLeft,
    this.paddingRight,
    this.contentPaddingTop,
    this.contentPaddingBottom,
    this.contentPaddingRight,
    this.contentPaddingLeft,
    this.enabled = true,
    this.obscureText = false,
    this.onTap,
    this.onTapOutSide,
    this.border,
    this.isPassword = false,
    this.errorStyle,
    this.suffixIconDecoration,
    this.suffixIconBorder,
    this.suffixIcon,
    this.suffixIconColor,
    this.suffixIconHeight,
    this.suffixPaddingBottom,
    this.suffixPaddingRight,
    this.suffixPaddingLeft,
    this.suffixPaddingTop,
    this.onTapSuffixIcon,
    this.showCursor,
    this.readOnly,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool rxHasFocus = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(() {
      _onFocusChange();
    });
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  _onFocusChange() {
    setState(() {
      rxHasFocus = !rxHasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText?.isNotEmpty ?? false) ...[
          Text(
            widget.labelText ?? '',
            style: widget.labelStyle ?? Fonts.textStyleRegular.copyWith(
              fontSize: 16,
              color: AppColor.appWhiteColor,
            ),
          ),
          CommonWidget.getFieldSpacer(height: 10),
        ],
        Flexible(
          child: TextFormField(
            enabled: widget.enabled,
            onTapOutside: (event) {
              if (widget.onTapOutSide != null) {
                widget.onTapOutSide!();
              }
            },
            onChanged: (value) {
              setState(() {});
            },
            cursorColor: AppColor.appWhiteColor,
            focusNode: widget.focusNode,
            inputFormatters: widget.inputFormatters,
            validator: widget.validator,
            showCursor: widget.showCursor,
            readOnly: widget.readOnly ?? false,
            textCapitalization: TextCapitalization.none,
            controller: widget.tecController,
            keyboardType: widget.textInputType ?? TextInputType.emailAddress,
            style: Fonts.textStyleRegular.copyWith(color: (widget.enabled ?? false)  ? AppColor.appWhiteColor : AppColor.grey.withOpacity(0.5)),
            autocorrect: true,
            enableSuggestions: widget.enableSuggestions ?? true,
            maxLines: widget.maxLines ?? 1,
            minLines: widget.minLines ?? 1,
            maxLength: widget.maxLength,
            obscureText: widget.obscureText ?? false,
            textInputAction: widget.textInputAction ?? TextInputAction.next,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
                filled: true,
                fillColor: widget.fillColor ?? AppColor.appPrimaryLightColor,
                hintText: widget.hintText,
                hintStyle: widget.hintStyle ?? Fonts.textStyleRegular.copyWith(color: widget.hintColor ?? AppColor.appSecondaryColor, fontSize: 16),
                errorStyle: widget.errorStyle ?? Fonts.textStyleRegular.copyWith(color: AppColor.appRedColorError, fontSize: 14),
                errorMaxLines: 3,
                floatingLabelStyle: Fonts.textStyleRegular.copyWith(color: AppColor.appPrimaryColor, fontSize: 20),
                contentPadding: EdgeInsets.fromLTRB(widget.contentPaddingLeft ?? 20.0, widget.contentPaddingTop ?? 5.0,
                    widget.contentPaddingRight ?? 20.0, widget.contentPaddingBottom ?? 5.0),
                errorText: widget.errorText,
                counterText: '',
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 25,
                  minHeight: 25,
                ),
                prefixIcon: widget.isShowPrefixIcon == true ? widget.prefixIcon : null,
                suffixIcon: widget.isShowSuffixIcon == true ? widget.suffixIcon : null,
                focusedBorder: Borders.focusBorder,
                focusedErrorBorder: Borders.errorBorder,
                enabledBorder: widget.border ?? Borders.enableBorder,
                disabledBorder: widget.border ?? Borders.enableBorder,
                errorBorder: Borders.errorBorder),
          ),
        ),
      ],
    );
  }
}
