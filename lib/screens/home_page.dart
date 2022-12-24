import 'package:crud_sqlite_joes/database/user.dart';
import 'package:crud_sqlite_joes/screens/edit_user.dart';
import 'package:crud_sqlite_joes/screens/add_user.dart';
import 'package:crud_sqlite_joes/database/user_service.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<User> _userList = <User>[];
  final _userService = UserService();

  getAllUserDetails() async {
    var users = await _userService.readAllUsers();
    _userList = <User>[];
    users.forEach((user) {
      setState(() {
        var userModel = User();
        userModel.id = user['id'];
        userModel.name = user['name'];
        userModel.contact = user['contact'];
        _userList.add(userModel);
      });
    });
  }

  @override
  void initState() {
    getAllUserDetails();
    super.initState();
  }

  _deleteFormDialog(BuildContext context, userId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Are You Sure to Delete',
              style: TextStyle(color: Colors.teal, fontSize: 20),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.red),
                  onPressed: ()  async{
                     var result=await _userService.deleteUser(userId);
                     if (result != null) {
                       Navigator.pop(context);
                       getAllUserDetails();
                     }
                  },
                  child: const Text('Delete')),
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.teal),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of Users"),
      ),
      body: ListView.builder(
          itemCount: _userList.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(_userList[index].name ?? ''),
                  subtitle: Text(_userList[index].contact ?? ''),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditUser(
                                          user: _userList[index],
                                        ))).then((data) {
                              if (data != null) {
                                getAllUserDetails();
                              }
                            });
                            ;
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.teal,
                          )),
                    ],
                  ),
                ),
              ),
              onDismissed: (direction) {
                setState(() {
                  _deleteFormDialog(context, _userList[index].id);
                });
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddUser()))
              .then((data) {
            if (data != null) {
              getAllUserDetails();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
