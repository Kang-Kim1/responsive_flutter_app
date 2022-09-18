import 'package:flutter/material.dart';

class CommonComponents {
  static Widget textFormFieldBordered({required key, String? hint, ValueChanged<String>? onChanged, bool isObscure = false,
    int? maxLength, int? maxLines, TextEditingController? controller, prefix, bool hasIcon = false, ValueChanged<String>? onSubmitted}) {
    return TextFormField(
      onChanged: onChanged,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(width: 1)
        ),
        hintText: hint,
        alignLabelWithHint: true,
        counterText: '',
        prefixIcon: hasIcon ? const Icon(Icons.search) : null
      ),
      maxLength: maxLength ?? 300,
      minLines: maxLines ?? 1,
      maxLines: maxLines ?? 1,
      controller: controller,
      onFieldSubmitted: onSubmitted,
      obscureText: isObscure,
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBarWithMsg(
      {required BuildContext context, required String msg}) {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: SizedBox(height: 50, child: Text(msg, style: const TextStyle(color: Colors.yellow)))));
  }

  static Widget customTextLabel({required String? text, TextStyle? textStyle, int? maxLines}) {
    return Text(text?.replaceAll('', '\u{200B}') ?? '',
        maxLines: maxLines ?? 2,
        style: textStyle,
        overflow: TextOverflow.ellipsis);
  }

  static Widget widthSpace(double width) {
    return SizedBox(width: width);
  }

  static Widget heightSpace(double height) {
    return SizedBox(height: height, width: double.infinity);
  }
}
