import 'package:flutter/material.dart';

import '../../../logic/home_logic/home_bloc.dart';

class SearchField extends StatelessWidget {
  final HomeBloc homeBloc;
  final TextEditingController textController;
  final Size screenSize;

  const SearchField({
    super.key,
    required this.homeBloc,
    required this.textController,
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize.width - 5,
      height: screenSize.height / 9,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        onChanged: (value) {
          homeBloc.add(PerformSearchEvent(value));
        },
        onFieldSubmitted: (value) {
          homeBloc.add(PerformSearchEvent(value));
        },
        controller: textController,
        textInputAction: TextInputAction.search,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Buscar',
          hintStyle: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: const Color(0xFF36076A),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              homeBloc.add(PerformSearchEvent(textController.text));
            },
            icon: const Icon(
              Icons.search_outlined,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
