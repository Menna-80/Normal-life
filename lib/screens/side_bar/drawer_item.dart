import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({Key? key, required this.name, required this.icon, required this.onPressed}) : super(key: key);

  final String name;
  final IconData icon;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context) => ProjectCubit(),
    child: BlocConsumer<ProjectCubit, ProjectStates>(
        listener: (context, state) {},
    builder: (context, state) {
          return InkWell(
            onTap: onPressed,
            child: SizedBox(
              height: 40,
              child: Row(
                children: [
                  Icon(icon, size: 20,),
                  const SizedBox(width: 18,),
                  Text(name, style:  TextStyle(fontSize: 20,))
                ],
              ),
            ),
          );
    },
    ),
    );
  }
}
