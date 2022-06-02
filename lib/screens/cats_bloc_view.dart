import 'package:cached_network_image/cached_network_image.dart';
import 'package:cat_api/bloc/cats_cubit.dart';
import 'package:cat_api/bloc/cats_repository.dart';
import 'package:cat_api/bloc/cats_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatBlocView extends StatefulWidget {
  const CatBlocView({Key? key}) : super(key: key);

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
          appBar: AppBar(title: const Text("Fav Cats")),
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
                return Text("Meow");
              } else if (state is CatsLoading) {
                return Center(
                  child: CupertinoActivityIndicator(),
                );
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
          title: Text(state.response![index].toString()),
          subtitle: CachedNetworkImage(
              imageUrl: state.response![index].source.toString()),
        ));
      },
      itemCount: state.response!.length,
    );
  }
}
