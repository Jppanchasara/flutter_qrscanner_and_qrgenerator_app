import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SlidableScreen extends StatefulWidget {
  const SlidableScreen({super.key});

  @override
  State<SlidableScreen> createState() => _SlidableScreenState();
}

class _SlidableScreenState extends State<SlidableScreen> {
  List list=['jayesh','pradip','ravi','hardik',];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Slidable Example',
      home: Scaffold(
        body: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      key: const ValueKey(0),
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        dismissible: DismissiblePane(onDismissed: () {

                        }),
                        children: const [
                          SlidableAction(
                            onPressed: doNothing,
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      endActionPane: const ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          
                          SlidableAction(
                            onPressed: doNothing,
                            backgroundColor: Color(0xFF0392CF),
                            foregroundColor: Colors.white,
                            icon: Icons.save,
                            label: 'Save',
                          ),
                        ],
                      ),
                      child:  ListTile(title: Text(list[index].toString())),
                    );
                    // ListTile(
                    //   title: Text(snapshot.data![index].title.toString()),
                    //     leading: CircleAvatar(
                    //       backgroundImage: NetworkImage(
                    //           snapshot.data![index].url.toString()),
                    //     ),
                    //   );
                  })
      ),
    );
  }
}

void doNothing(BuildContext context) {
  

}
