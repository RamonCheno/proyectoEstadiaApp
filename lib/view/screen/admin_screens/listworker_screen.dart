import 'package:control_asistencia_app/view/screen/admin_screens/addworker_screen.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';

class ListWorkerScreen extends StatefulWidget {
  const ListWorkerScreen({super.key});
  static const route = "/listWorkerScreen";

  @override
  State<ListWorkerScreen> createState() => _ListWorkerScreenState();
}

class _ListWorkerScreenState extends State<ListWorkerScreen> {
  final List<Widget> workers = [
    const ListTile(
      leading: Icon(Icons.person),
      title: Text("Jorge Cheno Durazo"),
      subtitle: Text("19-05-0000"),
    ),
    const ListTile(
      leading: Icon(Icons.person),
      title: Text("Ramon Cheno Ocaño"),
      subtitle: Text("19-05-0001"),
    ),
    const ListTile(
      leading: Icon(Icons.person),
      title: Text("Jorge Cheno Ocaño"),
      subtitle: Text("19-05-0002"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EasySearchBar(
        title: const Text(
          "Trabajadores",
          textAlign: TextAlign.center,
        ),
        onSearch: (value) => null,
        backgroundColor: const Color(0xffEBEBEB),
      ),
      backgroundColor: const Color(0xffEBEBEB),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0XFFF4F4F4),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 3.0),
                            blurRadius: 1),
                      ]),
                  child: workers[index]),
              itemCount: workers.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const SizedBox(
                height: 10,
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color(0xffD9D9D9),
        onPressed: () => Navigator.of(context).pushNamed(AddWorkerScreen.route),
        child: const Icon(
          Icons.person_add_outlined,
          size: 40,
          color: Colors.black,
        ),
      ),
    );
  }
}
