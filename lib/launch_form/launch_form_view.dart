import 'package:flutter/material.dart';
import 'package:flutter_google_form/model/create_form_model.dart';
import 'package:flutter_google_form/result_form/result_form_view.dart';
import 'package:flutter_google_form/utils/screen_argument.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LaunchFormView extends StatefulWidget {
  const LaunchFormView({super.key, required this.data});

  final ScreenArguments data;

  @override
  State<LaunchFormView> createState() => _LaunchFormViewState();
}

class _LaunchFormViewState extends State<LaunchFormView> {
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

  bool validateSubmit() {
    List<bool> listChecked = [];
    bool isParagraph = false;
    bool isRequired = false;
    for (final i in createForm) {
      if (i.isRequired!) {
        isRequired = true;
        if (i.isParagraph!) {
          isParagraph = true;
          if (i.option![0].option! == 'Option') {
            Fluttertoast.showToast(
                msg: 'Paragraph can not be empty', gravity: ToastGravity.TOP);
            return false;
          }
        } else {
          isParagraph = false;
          for (final e in i.option!) {
            listChecked.add(e.isChecked!);
            if (e.isChecked!) {
              if (e.isOther! && e.option! == 'Other') {
                Fluttertoast.showToast(
                    msg: 'Other can not be empty', gravity: ToastGravity.TOP);
                return false;
              }
            }
          }
        }
      }
    }

    if (!isParagraph && isRequired && countBoolList(listChecked) == 0) {
      Fluttertoast.showToast(
          msg: 'Checkbox can not be empty', gravity: ToastGravity.TOP);
      return false;
    }

    return true;
  }

  int countBoolList(List<bool> boolList) {
    int count = 0;
    for (int i = 0; i < boolList.length; i++) {
      if (boolList.elementAt(i) == true) {
        count++;
      }
    }
    return count;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(5),
          child: ListView(
            children: [
              titleFormWidget(),
              const SizedBox(height: 10),
              questionWidget(),
              const SizedBox(height: 10),
              submitWidget()
            ],
          ),
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
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextFormField(
                          decoration: InputDecoration(
                              fillColor: Colors.purple[50],
                              border: InputBorder.none,
                              focusedBorder: const UnderlineInputBorder(),
                              labelText: 'Enter another answer',
                              hintText: 'Enter another answer'),
                          onFieldSubmitted: (value) {
                            setState(() {
                              createForm[index].option?[0].option = value;
                            });
                          },
                          onChanged: (value) {
                            setState(() {
                              createForm[index].option?[0].option = value;
                            });
                          },
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: createForm[index].option?.length,
                        itemBuilder: (context, itemIndex) {
                          final data = createForm[index].option?[itemIndex];
                          return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                contentPadding: EdgeInsets.zero,
                                title: data!.isOther!
                                    ? Center(
                                        child: TextFormField(
                                          readOnly: !data.isChecked!,
                                          decoration: InputDecoration(
                                              fillColor: Colors.purple[50],
                                              border: InputBorder.none,
                                              focusedBorder:
                                                  const UnderlineInputBorder(),
                                              labelText: 'Enter another answer',
                                              hintText: 'Enter another answer'),
                                          onFieldSubmitted: (value) {
                                            setState(() {
                                              data.option = value;
                                            });
                                          },
                                          onChanged: (value) {
                                            setState(() {
                                              data.option = value;
                                            });
                                          },
                                        ),
                                      )
                                    : Text(data.option ?? ''),
                                value: data.isChecked ?? false,
                                onChanged: (value) {
                                  setState(() {
                                    data.isChecked = value;
                                  });
                                },
                              ));
                        },
                      ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget submitWidget() {
    return Visibility(
      visible: createForm.isNotEmpty,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 30,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  for (final x in createForm) {
                    for (final y in x.option!) {
                      y.isChecked = false;
                    }
                  }
                });

                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              child: const Text('Back',
                  style: TextStyle(fontSize: 16, color: Colors.purple)),
            ),
          ),
          SizedBox(
            height: 30,
            child: ElevatedButton(
              onPressed: () {
                bool validate = validateSubmit();

                if (validate) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ResultFormView(
                              data: ScreenArguments(
                                  arg1: createForm,
                                  arg2: titleOption,
                                  arg3: titleDescription))));
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: const Text('Send',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
