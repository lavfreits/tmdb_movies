import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/home_logic/home_bloc.dart';
import '../../../widgets/get_back_button.dart';
import '../../favorites/favorites_page.dart';

class SearchHeader extends StatelessWidget {
  final HomeBloc homeBloc;
  final TextEditingController textController;
  final Size screenSize;

  const SearchHeader({
    super.key,
    required this.homeBloc,
    required this.textController,
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeStates>(
      bloc: homeBloc,
      builder: (context, state) {
        if (state is HomeSearchState) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 8,
              top: 70,
              bottom: 20,
            ),
            child: GetBackButton(
              onPressed: () {
                homeBloc.add(LoadMoviesEvent());
                textController.clear();
              },
            ),
          );
        }
        return Row(
          children: [
            Container(
              height: 150,
              width: screenSize.width > 800 && screenSize.width < 1200
                  ? screenSize.width * 0.7
                  : screenSize.width * 0.8,
              padding: const EdgeInsets.only(
                  top: 60, bottom: 25, right: 20, left: 40),
              child: const Text(
                'O que você quer assistir hoje?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FavoritesPage(),
                  ),
                );
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }
}
