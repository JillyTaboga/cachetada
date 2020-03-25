import 'package:flutter/material.dart';

class TextButton extends StatefulWidget {
  TextButton({@required this.text, @required this.onTap});
  final String text;
  final Function onTap;

  @override
  _TextButtonState createState() => _TextButtonState();
}

class _TextButtonState extends State<TextButton> {
  Offset shadowOffsetIdle = Offset(0, 3);
  Offset shadowOffsetPressed = Offset(0, 0);
  Offset actualOffset;
  String text;
  Function onTap;

  initState(){
    actualOffset = shadowOffsetIdle;
    text = widget.text;
    onTap = widget.onTap;
    super.initState();
  }

  @override
  void didUpdateWidget(TextButton oldWidget) {
    actualOffset = shadowOffsetIdle;
    text = widget.text;
    onTap = widget.onTap;
    super.didUpdateWidget(oldWidget);
  }

  _press()async{
    setState(() {
      actualOffset = shadowOffsetPressed;
    });
    await Future.delayed(Duration(milliseconds: 180));
    setState(() {
      actualOffset = shadowOffsetIdle;
    });
  }


  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 50),
              decoration: BoxDecoration(
          border: Border.all(color: Colors.black45, width: 1),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.black54, offset: actualOffset, blurRadius: 2)
          ]
              ),
          child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Material(
                child: InkWell(
                  onTap: (){
                    _press();
                    onTap();
                  },
                                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Text(
              widget.text ?? 'Botão',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
                ),
        ),
      ),
    );
  }
}
