import 'package:flutter/material.dart';

class Link extends StatefulWidget {
  const Link({ Key? key, required this.text, required this.to }) : super(key: key);

  @override
  State<Link> createState() => _LinkState();


  final String text;
  final String to;
}

class _LinkState extends State<Link> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Color nonHoverColor = theme.textTheme.bodyText2!.color!.withOpacity(1.0);
    final Color hoverColor = theme.textTheme.bodyText2!.color!.withOpacity(0.5);

    return MouseRegion(
      cursor: (!_isHovering) ? MouseCursor.defer : MaterialStateMouseCursor.clickable,
      onEnter: (event) => setState(() => _isHovering = true),
      onExit: (event) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(widget.to),
        child: TweenAnimationBuilder<double>(
          tween: Tween(end: (!_isHovering) ? 0.0 : 1.0),
          duration: const Duration(milliseconds: 100),
          builder: (context, value, child) {
            return Text(widget.text, style: TextStyle(color: Color.lerp(nonHoverColor, hoverColor, value), fontWeight: FontWeight.bold));
          }
        ),
      )
    );
  }


  bool _isHovering = false;
}