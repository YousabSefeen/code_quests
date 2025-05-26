import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task/core/constants/common_widgets/custom_loading%20_list.dart';
import 'package:flutter_task/core/enum/request_state.dart';
import 'package:flutter_task/features/doctor_list/presentation/widgets/doctor_list_view.dart';

import '../controller/cubit/doctor_list_cubit.dart';
import '../controller/states/doctor_list_state.dart';
import '../widgets/custom_drawer.dart';

class DoctorListViewScreen extends StatefulWidget {
  const DoctorListViewScreen({super.key});

  @override
  State<DoctorListViewScreen> createState() => _DoctorListViewScreenState();
}

class _DoctorListViewScreenState extends State<DoctorListViewScreen> {
  @override
  void initState() {
    super.initState();

    context.read<DoctorListCubit>().getDoctorList();
  }

  @override
  Widget build(BuildContext context) {
    print('_DoctorListViewScreenState.build');
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(title: const Text('Browse Doctors')),
      body: BlocBuilder<DoctorListCubit, DoctorListState>(
        buildWhen: (previous, current) =>
            previous.doctorList != current.doctorList,
        builder: (context, state) {
          switch (state.doctorListState) {
            case RequestState.loading:
              return const CustomLoadingList(height: 150);
            case RequestState.loaded:
              return   state.doctorList.isEmpty ?   Container(height: 400,width: 200,color: Colors.red,): DoctorListView(doctorList: state.doctorList);
            case RequestState.error:
              return Center(
                child: Text(
                  state.doctorListError,
                  style: const TextStyle(fontSize: 30, color: Colors.red),
                ),
              );
          }
        },
      ),
    );
  }
}
