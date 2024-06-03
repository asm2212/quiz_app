import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/animation/fade_animation.dart';
import 'package:quiz_app/model/categories.dart';
import 'package:quiz_app/provider/question_provider.dart';
import 'package:quiz_app/screen/quiz_bottomsheet.dart';
import 'package:quiz_app/util/constant.dart';
import 'package:quiz_app/widget/card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    Provider.of<QuestionProvider>(context, listen: false).initValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: kItemSelectBottomNav,
        ),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            Text(
              "Home",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListView.builder(
                        itemCount: categories.length,
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                            child: InkWell(
                              onTap: () => _buildBottomSheet(context, categories[index].name, categories[index].id),
                              child: FadeAnimation(
                                0.5,
                                CardItem(
                                  index: index,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _buildBottomSheet(BuildContext context, String title, int id) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      context: context,
      builder: (_) {
        return QuizBottomSheet(
          title: title,
          id: id,
        );
      },
    );
  }
}
