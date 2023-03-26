import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as auth show AuthClient;
import 'package:googleapis/photoslibrary/v1.dart' as photos;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/models.dart';
import '../utils/http_client.dart';

class GooglePhotosService {
  List<GoogleSignInAccount>? accounts = <GoogleSignInAccount>[];
  // sign in to google photos
  static final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'https://www.googleapis.com/auth/photoslibrary.readonly',
      'https://www.googleapis.com/auth/photoslibrary.sharing',
      'https://www.googleapis.com/auth/photoslibrary.edit.appcreateddata',
      'https://www.googleapis.com/auth/photoslibrary.readonly.appcreateddata',
    ],
    // clientId: dotenv.env['GOOGLE_PHOTOS_API'],
  );
  static GoogleSignInAccount? curUser;

  static Future<void> handleSignIn() async {
    try {
      curUser = await googleSignIn.signIn();
      print(curUser);
    } catch (error) {
      print("yoyo");
      print(error);
    }
  }

  static Future<void> handleSignOut() => googleSignIn.disconnect();
  static Future<auth.AuthClient> handleGetPhotos() async {
    // setState(() {
    //   message = 'Loading photos...';
    // });

    // Retrieve an [auth.AuthClient] from the current [GoogleSignIn] instance.
    final auth.AuthClient client =
        await googleSignIn.authenticatedClient() as auth.AuthClient;

    assert(client != null, 'Authenticated client missing!');

    return client;
  }

  static Future<List<String>> getPhotoUrls() async {
    // Retrieve an [auth.AuthClient] from the current [GoogleSignIn] instance.
    final auth.AuthClient? client = await googleSignIn.authenticatedClient();

    assert(client != null, 'Authenticated client missing!');
    // Prepare a photos Service authenticated client.
    final photos.PhotosLibraryApi photosApi = photos.PhotosLibraryApi(client!);
    // Retrieve a list of all images from the user's library.
    final photos.ListMediaItemsResponse response =
        await photosApi.mediaItems.list();
    final List<photos.MediaItem> mediaItems =
        response.mediaItems ?? <photos.MediaItem>[];
    print(mediaItems);
    // setState(() {
    if (mediaItems.isNotEmpty) {
      // message = 'I see ${mediaItems.length} photos!';
      return mediaItems
          .map((photos.MediaItem mediaItem) => mediaItem.baseUrl ?? '')
          .toList();
    } else {
      return (['No photos found!']);
    }
    // }
    // );

    // final photos.SearchMediaItemsResponse response =
    //     await photosApi.mediaItems.search(
    //   photos.SearchMediaItemsRequest(
    //     pageSize: 100,
    //     filters: photos.Filters(
    //       contentFilter: photos.FiltersContentFilter.includeNonAppCreatedData,
    //     ),
    //   ),
    // );
  }
  // Send un-cached http request
  // static Future<List<Post>> getPhotos() async {
  //   var response = await HttpClient.create()
  //       .get('${HttpClient.google_photos_url}/mediaItems');
  //   return response.data.map<Post>((p) => Post.fromJson(p)).toList();
  // }

  // This method implements an HTTP request with caching
  // static Future<List<Post>> getPostsWithCaching({ignoreCache = false}) async {
  //   var response = await HttpClient.create(
  //           cacheOptions: HttpClient.defaultCacheOptions
  //               .copyWith(maxStale: const Nullable(Duration(days: 1))))
  //       .get(
  //     '${HttpClient.google_photos_url}/mediaItems',
  //   );
  //   return response.data.map<Post>((p) => Post.fromJson(p)).toList();
  // }
}
