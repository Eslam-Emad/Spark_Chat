import 'package:flutter/material.dart';

import '/constants/constants.dart';
import '/utils/utils.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: SizedBox(
        child: TextFormField(
          cursorColor: Palette.kTheme,
          decoration: InputDecoration(
            filled: true,
            hintText: "search...",
            border: InputBorder.none,
            fillColor: Palette.kIconLight.withOpacity(0.2),
            enabledBorder: AppTheme.searchOutLinedBorder(context),
            focusedBorder: AppTheme.searchOutLinedBorder(context),
            contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            suffixIcon: IconButton(onPressed: () => Helper.closeKeyboard(context),
            icon: const Icon(Icons.search)),

          ),
        ),
      ),
    );
  }
}
