import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lesson_4_database_hive/model/user_model.dart';
import 'package:lesson_4_database_hive/src/db_service.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _id = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Scaffold(
        body: SafeArea(
            child: FutureBuilder(
                future: HiveDbService.getDataUser(id: 'test'),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                  return Card(
                    child: ListTile(
                      title: Text(snapshot.data!.email.toString()),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () async {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Update User'),
                                        content: Card(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextField(
                                                controller: _id,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText: 'newId'),
                                              ),
                                              TextField(
                                                controller: _email,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText: 'newEmail'),
                                              ),
                                              TextField(
                                                controller: _password,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText:
                                                            'newPassword'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () async {
                                                if (_id.text.isEmpty) {
                                                  return;
                                                }
                                                if (_email.text.isEmpty) {
                                                  return;
                                                }
                                                if (_password.text.isEmpty) {
                                                  return;
                                                }
                                                final uuid = const Uuid().v1();
                                                final newUser = User(
                                                    token: uuid,
                                                    email: _email.text,
                                                    id: 'test',
                                                    password: _password.text);
                                                await HiveDbService.writeData(
                                                    user: newUser);
                                                _email.clear();
                                                _id.clear();
                                                _password.clear();
                                                setState(() {
                                                  Navigator.of(context).pop();
                                                });
                                              },
                                              child: const Text('update'))
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () async {
                                await HiveDbService.delete(id: 'test');
                                setState(() {});
                              },
                              icon: const Icon(Icons.delete))
                        ],
                      ),
                      subtitle: Text(snapshot.data!.token.toString()),
                    ),
                  );
                })),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Add user'),
                    content: Card(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: _id,
                            decoration:
                                const InputDecoration(hintText: 'newId'),
                          ),
                          TextField(
                            controller: _email,
                            decoration:
                                const InputDecoration(hintText: 'newEmail'),
                          ),
                          TextField(
                            controller: _password,
                            decoration:
                                const InputDecoration(hintText: 'newPassword'),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            if (_id.text.isEmpty) {
                              return;
                            }
                            if (_email.text.isEmpty) {
                              return;
                            }
                            if (_password.text.isEmpty) {
                              return;
                            }
                            final uuid = const Uuid().v1();
                            final user = User(
                                token: uuid,
                                email: _email.text,
                                id: 'test',
                                password: _password.text);
                            await HiveDbService.writeData(user: user);
                            _email.clear();
                            _id.clear();
                            _password.clear();
                            setState(() {
                              Navigator.of(context).pop();
                            });
                          },
                          child: const Icon(Icons.add))
                    ],
                  );
                });
          },
          child: const Icon(Icons.add),
        ),
      );
    });
  }
}
