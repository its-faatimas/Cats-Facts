import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_api/bloc/cats_cubit.dart';
import 'package:cat_api/bloc/cats_repository.dart';
import 'package:cat_api/bloc/cats_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CatBlocView extends StatefulWidget {
  CatBlocView({Key? key}) : super(key: key);
  final DateTime now = DateTime.now();
  final DateFormat formatter = DateFormat('dd/mm/yyyy');
  @override
  void initState() {
    final String formatted = formatter.format(now);
  }

  @override
  _CatBlocViewState createState() => _CatBlocViewState();
}

class _CatBlocViewState extends State<CatBlocView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        lazy: false,
        create: (_) => CatsCubit(SampleCatsRepository()),
        child: Scaffold(
          floatingActionButton: BlocBuilder<CatsCubit, CatsState>(
            builder: (context, state) {
              CatsCubit cubit = context.watch();
              return FloatingActionButton(onPressed: () {
                cubit.getCats();
              });
            },
          ),
          appBar: AppBar(title: const Text("Cats Facts")),
          body: Column(children: [
            Expanded(
                child: BlocConsumer<CatsCubit, CatsState>(
                    listener: (context, state) {
              if (state is CatsError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  state.errorMessage.toString(),
                )));
              }
            }, //listener is important - > narigi tomondan ma'lumot kelmay qolsa, bu bilan ham stateni boshqarish mumkin va errorni ekranga chiqarish mumkin
                    builder: (context, state) {
              if (state is CatsInitial) {
                return const Text("Meow");
              } else if (state is CatsLoading) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (state is CatsCompleted) {
                return dataListViewBuilder(state);
              } else {
                final error = state as CatsError;
                return Center(
                  child: Text(error.errorMessage),
                );
              }
            }))
          ]),
        ));
  }

  // FloatingActionButton floatingButton(BuildContext context) {
  //   return FloatingActionButton(onPressed: () {
  //     BlocProvider.of<CatsCubit>(context, listen: false).getCats();
  //   });
  // }

  ListView dataListViewBuilder(CatsCompleted state) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
            child: ListTile(
          title: Row(
            children: [
              Expanded(
                  child: Text(
                state.response![index].text.toString(),
                maxLines: state.response![index].text!.length.toInt(),
              )),
              Expanded(child: Text(state.response![index].createdAt.toString()))
            ],
          ),
          subtitle: CachedNetworkImage(imageUrl: 'https://cataas.com/cat'),
        ));
      },
      itemCount: state.response!.length,
    );
  }
}
