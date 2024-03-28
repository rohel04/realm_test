import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realm_mongo/bloc/cubit/my_profile_cubit.dart';
import 'package:realm_mongo/widgets/text_form_field.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyProfileCubit()..getMyProfileDetail(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Profile'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocConsumer<MyProfileCubit, MyProfileState>(
                  listener: (context, state) {
                if (state is MyProfileLoaded) {
                  context.read<MyProfileCubit>().getMyProfileDetail();
                }
              }, builder: (context, state) {
                if (state is MyProfileLoaded) {
                  return Text(state.user.name);
                } else {
                  return const SizedBox();
                }
              }),
              const SizedBox(
                height: 20,
              ),
              TextFormWidget(
                controller: _nameController,
                label: const Text('Name'),
              ),
              Builder(builder: (context) {
                return ElevatedButton(
                    onPressed: () async {
                      context
                          .read<MyProfileCubit>()
                          .upateProfile(_nameController.text);
                    },
                    child: const Text('Update'));
              })
            ],
          ),
        ),
      ),
    );
  }
}
