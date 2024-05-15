import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_form/model/create_form_model.dart';
import 'package:flutter_google_form/utils/screen_argument.dart';

class PieChartView extends StatefulWidget {
  const PieChartView({super.key, required this.data});
  final ScreenArguments data;

  @override
  State<PieChartView> createState() => _PieChartViewState();
}

class _PieChartViewState extends State<PieChartView> {
  int touchedIndex = -1;
  List<ListOptionModel>? option;

  @override
  void initState() {
    option = widget.data.arg1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          const SizedBox(width: 50),
          Expanded(
            child: SizedBox(
              height: 200,
              width: 200,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(option),
                ),
              ),
            )
          ),
          const SizedBox(width: 100,),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: option?.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Text(option?[index].option ?? '', textAlign: TextAlign.start, style: TextStyle(color: indexColor(index)),),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections(List<ListOptionModel>? option) {
    List<PieChartSectionData> data = [];
    int countChoice = 0;

    for(final i in option!) {
      if(i.isChecked!) {
        countChoice = countChoice + 1;
      }
    }

    for(int i = 0; i < option!.length; i++) {
      if(option[i].isChecked!) {
        data.add(PieChartSectionData(
          color: indexColor(i),
          value: 1/countChoice * 100,
          title: '${(1/countChoice * 100).toStringAsFixed(1)}%',
          radius: 50,
          titleStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [Shadow(color: Colors.black, blurRadius: 2)],
          ),
        ));
      }
    }

    return data;
  }

  Color indexColor(index) {
    switch(index) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.purple;
      case 2:
        return Colors.yellow;
      case 3:
        return Colors.green;
      case 4:
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }
}
