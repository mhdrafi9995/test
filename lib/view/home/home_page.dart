
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/data_list.dart';
import 'package:flutter_application_1/model/model_class.dart';
import 'package:flutter_application_1/view/login/login_page.dart';
import 'package:flutter_application_1/view/splash/splash_scree.dart';
import 'package:flutter_application_1/view/widget/box_widget.dart';
import 'package:flutter_application_1/view/widget/text_widget.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

String netWorkImg =
    "https://img.freepik.com/free-vector/flat-design-no-data-illustration_23-2150527130.jpg?t=st=1710482402~exp=1710486002~hmac=f8aae9241ad6b722deabd4406be09fcfd1506bfb861fb3302196b49caa3b8883&w=826";

TextEditingController namecontroller = TextEditingController();
TextEditingController allcontroller = TextEditingController();
TextEditingController priorityController = TextEditingController();
@override
String dropdownvalue3 = 'All';
List<DataModel> dataList = List.empty(growable: true);
const String key = 'userName';
// Animation//
double opacity = 0.0;

var items = [
  'Low',
  'Medium',
  'High',
];

var dropList = [
  'All',
  'Open',
  'Close',
];

class _HomePageState extends State<HomePage> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 18),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(children: [
                        TextField(
                            controller: namecontroller,
                            decoration: const InputDecoration(
                              labelText: 'Name',
                            )),
                        TextField(
                            controller: allcontroller,
                            decoration: const InputDecoration(
                              labelText: 'ALL',
                            )),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).alwaysUse24HourFormat
                                      ? 60
                                      : 0),
                          child: TextField(
                              controller: priorityController,
                              decoration: const InputDecoration(
                                labelText: 'Priority',
                              )),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 126,
                              height: 54,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.teal),
                                ),
                                onPressed: () {
                                  String name = namecontroller.text;
                                  String all = allcontroller.text;
                                  String priority = priorityController.text;
                                  if (name.isNotEmpty &&
                                      all.isNotEmpty &&
                                      priority.isNotEmpty) {
                                    setState(() {
                                      DataList.dataList.add(DataModel(
                                        name: name,
                                        type: all,
                                        priority: priority,
                                      ));
                                      namecontroller.text = '';
                                      allcontroller.text = '';
                                      priorityController.text = '';
                                    });

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Data added successfully!'),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text('Please fill in all fields.'),
                                        duration: Duration(seconds: 2),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                  }
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Save',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        )
                      ]),
                    ),
                  ));
        },
        child: const Icon(Icons.add, color: Colors.white, size: 32),
      ),
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton<String>(
            color: Colors.white,
            onSelected: (value) {
              log(value);
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'Low',
                  child: Text('Low'),
                ),
                const PopupMenuItem(
                  value: 'Medium',
                  child: Text('Medium'),
                ),
                const PopupMenuItem(
                  value: 'High',
                  child: Text('High'),
                ),
              ];
            },
          ),
        ],
        leading: IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
              size: 32,
            ),
            onPressed: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              preferences.remove(key);

              // ignore: use_build_context_synchronously
              await Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            }),
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Column(children: [
          Text(
            'Hi $finalUserName',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ]),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              width: double.infinity,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: DropdownButton(
                  isExpanded: true,
                  hint: const Text('ALL'),
                  iconSize: 24,
                  value: dropdownvalue3,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: dropList.map((String dropList) {
                    return DropdownMenuItem(
                      value: dropList,
                      child: Text(dropList),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue3 = newValue!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            DataList.dataList.isEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        netWorkImg,
                        height: 150,
                        width: 150,
                      ),
                      const Text(
                        'No Data',
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: DataList.dataList.length,
                    itemBuilder: (context, index) {
                      return Slidable(
                          startActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    setState(() {
                                      DataList.dataList.removeAt(index);
                                    });
                                  },
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Delete',
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                              ]),
                          child: Container(
                            width: double.infinity,
                            height: 130,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black12,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Row(children: [
                                const BoxDataWidget(),
                                const SizedBox(
                                  width: 160,
                                ),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        text: DataList.dataList[index].name,
                                      ),
                                      TextWidget(
                                        text: DataList.dataList[index].type,
                                      ),
                                      TextWidget(
                                        text: DataList.dataList[index].priority,
                                      ),
                                    ]),
                              ]),
                            ),
                          ));
                    })
          ],
        ),
      ),
    );
  }
}
