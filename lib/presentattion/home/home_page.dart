import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/home_logic/home_bloc.dart';
import 'widgets/home_background.dart';
import 'widgets/movie_content.dart';
import 'widgets/search_field.dart';
import 'widgets/search_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController textController;

  final ScrollController scrollController = ScrollController();
  final ScrollController scrollControllerPopulars = ScrollController();
  final ScrollController scrollControllerSearch = ScrollController();

  late final HomeBloc homeBloc;

  @override
  void initState() {
    super.initState();
    homeBloc = BlocProvider.of<HomeBloc>(context);
    textController = TextEditingController();

    homeBloc.add(LoadMoviesEvent());
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    scrollController.dispose();
    scrollControllerPopulars.dispose();
    scrollControllerSearch.dispose();

    homeBloc.close();
    textController.dispose();

    super.dispose();
  }

  void scrollListener() {
    if (scrollController.offset >=
        scrollController.position.maxScrollExtent -
            scrollController.position.viewportDimension) {
      homeBloc.add(LoadMoviesEvent());
    }
    if (scrollControllerPopulars.offset >=
        scrollControllerPopulars.position.maxScrollExtent -
            scrollControllerPopulars.position.viewportDimension) {
      homeBloc.add(LoadMoviesEvent(isPopular: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF16171F),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Stack(
              children: [
                HomeBackground(screenSize: screenSize),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenSize.width > 800 ? 80 : 0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SearchHeader(
                        homeBloc: homeBloc,
                        textController: textController,
                        screenSize: screenSize,
                      ),
                      SearchField(
                        homeBloc: homeBloc,
                        textController: textController,
                        screenSize: screenSize,
                      ),
                      MovieContent(
                        homeBloc: homeBloc,
                        scrollController: scrollController,
                        scrollControllerPopulars: scrollControllerPopulars,
                        scrollControllerSearch: scrollControllerSearch,
                        screenSize: screenSize,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
