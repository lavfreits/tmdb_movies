import 'package:flutter/material.dart';
import 'package:tmdb_movies/widgets/scroll_button.dart';

import '../../../models/provider.dart';
import 'rounded_box.dart';

class ProviderList extends StatelessWidget {
  final List<Provider> providers;

  const ProviderList({
    super.key,
    required this.providers,
  });

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final screenSizeWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenSizeWidth,
      height: 40,
      child: Row(
        children: [
          if (screenSizeWidth > 600)
            ScrollButton(
              icon: Icons.arrow_back_ios,
              controller: scrollController,
              offset: -200,
            ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: scrollController,
              itemCount: providers.length,
              padding: const EdgeInsets.only(left: 10),
              itemBuilder: (context, index) {
                final provider = providers[index];

                return Container(
                  margin: const EdgeInsets.only(right: 10, left: 10),
                  child: RoundedBox(name: provider.providerName),
                );
              },
            ),
          ),
          if (screenSizeWidth > 600)
            ScrollButton(
              icon: Icons.arrow_forward_ios,
              controller: scrollController,
              offset: 200,
            )
        ],
      ),
    );
  }
}
