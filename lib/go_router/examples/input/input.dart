import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'decoration/code_decoration.dart';
import 'input_painter.dart';

typedef AsyncSubmit = Future<bool> Function(String value);

/// @desc 短信验证码输入框
/// @time 2019-05-14 16:16
/// @author Cheney
class TolyCodeInput extends StatefulWidget {
  final int count;

  final AsyncSubmit onSubmit;

  final CodeDecoration decoration;

  final TextInputType keyboardType;

  final bool autoFocus;

  final FocusNode? focusNode;

  final TextInputAction textInputAction;

  const TolyCodeInput(
      {this.count = 6,
     required this.onSubmit,
      this.decoration = const UnderlineDecoration(),
      this.keyboardType = TextInputType.number,
      this.focusNode,
      this.autoFocus = false,
      this.textInputAction = TextInputAction.done,
      super.key});

  @override
  State createState() {
    return TolyCodeInputState();
  }
}

class TolyCodeInputState extends State<TolyCodeInput>
    with SingleTickerProviderStateMixin {
  ///输入监听器
  final TextEditingController _controller = TextEditingController();
  late AnimationController _animaCtrl;
  late Animation<int> _animation;

  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    _controller.addListener(_listenValueChange);
    initAnimation();
    super.initState();
  }

  void initAnimation() {
    _animaCtrl = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = IntTween(begin: 0, end: 255).animate(_animaCtrl)
      ..addStatusListener(_stateChange);
    _animaCtrl.forward();
  }

  void _listenValueChange() {
    submit(_controller.text);
  }

  void submit(String text) async{
    if (text.length >= widget.count) {
     bool success = await widget.onSubmit.call(text.substring(0, widget.count));
     if(success){
       _focusNode.unfocus();
     }else{
       _controller.text = "";
     }
    }
  }

  @override
  void dispose() {
    /// Only execute when the controller is autoDispose.
    _controller.dispose();
    _animaCtrl.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: InputPainter(
        RRectCodeDecoration(
          height: 56,
          strokeWidth: 1,
          activeColor: const Color(0xff010101),
          inactiveColor: const Color(0xffB6B6B6),
          cursorColor: Color(0xff3776E9),
          textStyle: TextStyle(color: Colors.black),
          cursorSize: Size(1, 24),
        ),
        controller: _controller,
        count: widget.count,
        decoration: widget.decoration,
        alpha: _animation,
      ),
      child: RepaintBoundary(
        child: TextField(
          controller: _controller,
          /// Fake the text style.
          style: const TextStyle(
            color: Colors.transparent,
          ),
          cursorColor: Colors.transparent,
          cursorWidth: 0.0,
          autocorrect: false,
          textAlign: TextAlign.center,
          enableInteractiveSelection: false,
          maxLength: widget.count,
          onSubmitted: submit,
          keyboardType: widget.keyboardType,
          focusNode: _focusNode,
          autofocus: widget.autoFocus,
          textInputAction: widget.textInputAction,
          obscureText: true,
          decoration: const InputDecoration(
            counterText: '',
            contentPadding: EdgeInsets.symmetric(vertical: 24),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  void _stateChange(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _animaCtrl.reverse();
    } else if (status == AnimationStatus.dismissed) {
      _animaCtrl.forward();
    }
  }


}

/// 默认的样式
const TextStyle defaultStyle = TextStyle(
  /// Default text color.
  color: Color(0x80000000),

  /// Default text size.
  fontSize: 24.0,
);

abstract class CodeDecoration {
  /// The style of painting text.
  final TextStyle? textStyle;

  final ObscureStyle? obscureStyle;

  const CodeDecoration({
    this.textStyle,
    this.obscureStyle,
  });
}

/// The object determine the obscure display
class ObscureStyle {
  /// Determine whether replace [obscureText] with number.
  final bool isTextObscure;

  /// The display text when [isTextObscure] is true
  final String obscureText;

  const ObscureStyle({
    this.isTextObscure = false,
    this.obscureText = '*',
  }) : assert(obscureText.length == 1);
}

/// The object determine the underline color etc.
class UnderlineDecoration extends CodeDecoration {
  /// The space between text and underline.
  final double gapSpace;

  /// The color of the underline.
  final Color color;

  /// The height of the underline.
  final double lineHeight;

  /// The underline changed color when user enter pin.
  final Color? enteredColor;

  const UnderlineDecoration({
    TextStyle? textStyle,
    ObscureStyle? obscureStyle,
    this.enteredColor = const Color(0xff3776E9),
    this.gapSpace = 15.0,
    this.color = const Color(0x24000000),
    this.lineHeight = 0.5,
  }) : super(
          textStyle: textStyle,
          obscureStyle: obscureStyle,
        );
}
