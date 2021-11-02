import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

import '/constants/constants.dart';
import '/services/firestore_service.dart';

class ImageUploadCubit extends Cubit<File?> {
  final ImagePicker _picker = ImagePicker();
  final FireStoreServices _store = FireStoreServices();

  ImageUploadCubit() : super(null);

  Future<void> getImage() async {
    XFile? image = await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (image == null) return;
    emit(File(image.path));
  }

  uploadImage() async => await _store.uploadFile(FirestoreConstants.imagesPath, state!);

}
