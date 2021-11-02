import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/bloc/image_uploader/image_upload_cubit.dart';

import '/constants/constants.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 126.0,
      width: 126.0,
      child: Material(
        borderRadius: BorderRadius.circular(126.0),
        color: AppTheme.isLightTheme(context)
            ? const Color(0xFFF2F2F2)
            : const Color(0xFF211E1E),
        child: InkWell(
          borderRadius: BorderRadius.circular(126.0),
          onTap: ()async => await BlocProvider.of<ImageUploadCubit>(context).getImage(),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                child: BlocBuilder<ImageUploadCubit, File?>(
                  builder: (context, state) {
                    return state == null
                        ? Icon(
                            Icons.person_outline_rounded,
                            size: 75,
                            color: AppTheme.isLightTheme(context)
                                ? Palette.kIconLight
                                : Colors.black,
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(126.0),
                            child: Image.file(
                              state,
                              height: 126,
                              width: 126,
                              fit: BoxFit.fill,
                            ),
                          );
                  },
                ),
              ),
              const Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  Icons.add_circle_rounded,
                  color: Palette.kTheme,
                  size: 30.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
