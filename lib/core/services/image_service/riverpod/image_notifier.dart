import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moneynest/core/services/image_service/domain/image_state.dart';
import 'package:moneynest/core/services/image_service/image_service.dart';
import 'package:moneynest/core/services/image_service/riverpod/image_service_provider.dart';

class ImageNotifier extends StateNotifier<ImageState> {
  final ImageService _imageService;

  ImageNotifier(this._imageService) : super(ImageState());

  Future<String?> pickImage() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final image = await _imageService.pickImageFromGallery();
      state = state.copyWith(imageFile: image, isLoading: false);
      return state.savedPath;
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to pick image: $e',
        isLoading: false,
      );
    }

    return '';
  }

  Future<String?> takePhoto() async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final image = await _imageService.takePhoto();
      state = state.copyWith(imageFile: image, isLoading: false);
      return state.savedPath;
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to take photo: $e',
        isLoading: false,
      );
    }
    return '';
  }

  Future<String?> saveImage() async {
    if (state.imageFile == null) return null;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final savedPath = await _imageService.saveImage(state.imageFile!);
      state = state.copyWith(savedPath: savedPath, isLoading: false);
      return savedPath;
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to save image: $e',
        isLoading: false,
      );

      return null;
    }
  }

  Future<bool> deleteImage() async {
    if (state.savedPath == null) return false;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final success = await _imageService.deleteImage(state.savedPath!);

      if (!success) {
        state.clear();
      } else {
        state = state.copyWith(isLoading: false);
      }

      return success;
    } catch (e) {
      state = state.copyWith(
        error: 'Failed to delete image: $e',
        isLoading: false,
      );

      return false;
    }
  }

  void clearSelection() {
    state = state.clear();
  }
}

final imageProvider = StateNotifierProvider<ImageNotifier, ImageState>((ref) {
  final imageService = ref.watch(imageServiceProvider);
  return ImageNotifier(imageService);
});
