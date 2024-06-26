import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/util/constant.dart';
import 'package:quiz_app/model/categories.dart';

class CardItem extends StatelessWidget {
  final int index;
  
  const CardItem({required Key key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(categories[index].image),
            fit: BoxFit.cover
          )
        ),
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  categories[index].name,
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
            )
          ],
        ),
      );
  }
}
