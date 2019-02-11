import 'package:flutter/material.dart';

class CustomExpansionTile extends StatelessWidget {
  var trailing;
  var leading;
  var children;
  var title;

  CustomExpansionTile({this.title, this.trailing, this.leading, this.children});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
          title: this.title,
          trailing: this.trailing,
          leading: this.leading,
          children: this.children),
    );
  }
}
