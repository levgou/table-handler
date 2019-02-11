import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget {
  TitleBar();

  @override
  Widget build(BuildContext context) {
    return _buildTitleBar(context);
  }

  Widget _buildTitleBar(context) {
    return Container(
      height: 220.0,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15.0),
            child: Center(
              child:
                  Text('Your Piece', style: Theme.of(context).textTheme.title),
            ),
          ),
          Spacer(),
          SizedBox(
            height: 135.0,
            child: Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new AssetImage("assets/table.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
