import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controller/PhotoController.dart';
import '../model/PhotosModel.dart';

class PhotoScreen extends StatefulWidget {
  static const id = 'PhotoScreen';
  const PhotoScreen({Key? key}) : super(key: key);
  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends StateMVC<PhotoScreen> {
  PhotoController _photoController = PhotoController();

  @override
  void initState() {
    _photoController.getPhotos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: FutureBuilder<List<PhotosModel>>(
        future: _photoController.getPhotos(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return PhotosList(photos: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  const PhotosList({super.key, required this.photos});

  final List<PhotosModel> photos;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: photos.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(photos[index].url.toString()),
            ),
            subtitle: Text(photos[index].title.toString()),
            title: Text('Notes id:${photos[index].id}'),
          );
        });
  }
}
