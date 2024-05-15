import 'package:flutter/material.dart';
import 'package:flutter_google_form/model/create_form_model.dart';
import 'package:flutter_google_form/utils/screen_argument.dart';
import 'package:flutter_google_form/widget/pie_chart.dart';

class ResultFormView extends StatefulWidget {
  const ResultFormView({super.key, required this.data});

  final ScreenArguments data;

  @override
  State<ResultFormView> createState() => _ResultFormViewState();
}

class _ResultFormViewState extends State<ResultFormView> {
  List<CreateFormModel> createForm = [];
  String? titleOption;
  String? titleDescription;

  @override
  void initState() {
    createForm = widget.data.arg1;
    titleOption = widget.data.arg2;
    titleDescription = widget.data.arg3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.all(5),
        child: ListView(
          children: [
            titleFormWidget(),
            const SizedBox(height: 10),
            questionWidget(),
            // const SizedBox(height: 10),
            // submitWidget()
          ],
        ),
      ),
    );
  }

  Widget titleFormWidget() {
    return Container(
      padding: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border:
              const Border(top: BorderSide(width: 5, color: Colors.purple))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            titleOption ?? '',
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
          ),
          Text(
            titleDescription ?? '',
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget questionWidget() {
    return Visibility(
      visible: createForm.isNotEmpty,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: createForm.length,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    createForm[index].question ?? '',
                    style: const TextStyle(fontSize: 17),
                  ),
                ),
                const SizedBox(height: 10),
                createForm[index].isParagraph!
                    ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(createForm[index].option?[0].option ?? ''))
                    : PieChartView(
                        data: ScreenArguments(arg1: createForm[index].option),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}
