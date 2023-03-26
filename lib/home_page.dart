import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'models/post.dart';
import 'services/google_photos.dart';
import 'app.dart';
import 'package:photo_headquarters/services/google_photos.dart';

class HomePage extends StatefulWidget {
  static String routeName = 'home';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Boilerplate')),
      body:
          FutureBuilder(builder: (context, AsyncSnapshot<List<Post>> snapshot) {
        if (snapshot.hasData) {
          return RefreshIndicator(
            onRefresh: () async => setState(() {}),
            child: ListView.separated(
              separatorBuilder: (context, idx) => const Divider(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text('${snapshot.data![index].id}'),
                  ),
                  title: Text(snapshot.data![index].title!),
                  subtitle: Text(snapshot.data![index].body!),
                );
              },
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      }),
    );
  }

  Widget _PhotoList() {
    GoogleSignInAccount? user = GooglePhotosService.curUser;
    setState(() {});

    if (user != null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          const Text('Signed in successfully.'),
          const ElevatedButton(
            onPressed: GooglePhotosService.handleSignOut,
            child: Text('SIGN OUT'),
          ),
          const ElevatedButton(
            onPressed: GooglePhotosService.handleGetPhotos,
            child: Text('REFRESH'),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const <Widget>[
          Text('You are not currently signed in.'),
          ElevatedButton(
            onPressed: GooglePhotosService.handleSignIn,
            child: Text('SIGN IN'),
          ),
        ],
      );
    }
  }
}
/*
FutureBuilder(
  future: GooglePhotosService.getPhotos(),
  builder: (context, AsyncSnapshot<List<Post>> snapshot) {
    if (snapshot.hasData) {
      return RefreshIndicator(
        onRefresh: () async => setState(() {}),
        child: ListView.separated(
          separatorBuilder: (context, idx) => const Divider(),
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                child: Text('${snapshot.data![index].id}'),
              ),
              title: Text(snapshot.data![index].title!),
              subtitle: Text(snapshot.data![index].body!),
            );
          },
        ),
      );
    }
    if (snapshot.hasError) {
      return Center(child: Text(snapshot.error.toString()));
    }
    return const Center(child: CircularProgressIndicator());
  },
),
*/
