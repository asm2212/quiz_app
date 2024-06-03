import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/provider/score_provider.dart';
import 'package:quiz_app/util/constant.dart';
import 'package:quiz_app/widget/awesomedialog.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

const Color kItemSelectBottomNav = Color(0xff33333);

class ScoreScreen extends StatefulWidget {
  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ScoreProvider>(context, listen: false).getAllScore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: kItemSelectBottomNav,
        ),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            const Text(
              "History Point",
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
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                child: Consumer<ScoreProvider>(
                  builder: (BuildContext context, ScoreProvider value, Widget? child) {
                    return value.arrScore.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('assets/empty.jpg'),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "Your score not found",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: value.arrScore.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        offset: const Offset(4, 4),
                                        blurRadius: 10,
                                        color: Colors.grey.withOpacity(.3),
                                      ),
                                      BoxShadow(
                                        offset: const Offset(-3, 0),
                                        blurRadius: 15,
                                        color: const Color(0xffb8bfce).withOpacity(.1),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            value.arrScore[index].nameUser,
                                            style: kHeadingTextStyleAppBar.copyWith(
                                              fontSize: 25,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "Quiz: ${value.arrScore[index].categories}",
                                            style: kHeadingTextStyleAppBar.copyWith(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "Question: ${value.arrScore[index].totalAnswer}/${value.arrScore[index].totalQuestion}",
                                            style: kHeadingTextStyleAppBar.copyWith(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "Date: ${value.arrScore[index].date}",
                                            style: kHeadingTextStyleAppBar.copyWith(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            "Your Score: ${value.arrScore[index].score}",
                                            style: kHeadingTextStyleAppBar.copyWith(
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        InkWell(
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.red,
                                          ),
                                          onTap: () => buildDialog(
                                            context,
                                            "Delete",
                                            "Do you want to delete this score?",
                                              DialogType.warning,
                                            () => deleteScore(value, index),
                                            () => null,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        CircularPercentIndicator(
                                          radius: 100.0,
                                          lineWidth: 13.0,
                                          percent: (value.arrScore[index].score * 1.0) / 100,
                                          animationDuration: 1200,
                                          circularStrokeCap: CircularStrokeCap.round,
                                          center: Text("${value.arrScore[index].score}%"),
                                          progressColor: conditionalColor(value, index),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void deleteScore(ScoreProvider value, int index) {
    value.deleteScore(value.arrScore[index].id);
    setState(() {
      value.arrScore.removeAt(index);
    });
  }

  Color conditionalColor(ScoreProvider value, int index) {
    if (value.arrScore[index].score <= 10) {
      return Colors.red;
    } else if (value.arrScore[index].score >= 70) {
      return Colors.green;
    }
    return Colors.orange;
  }
}