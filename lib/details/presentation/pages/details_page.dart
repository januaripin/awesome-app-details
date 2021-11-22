import 'package:awesome_app_details/details/data/data_sources/photo_remote_data_source.dart';
import 'package:awesome_app_details/details/data/repositories/photo_repository_impl.dart';
import 'package:awesome_app_details/details/domain/entities/photo.dart';
import 'package:awesome_app_details/details/domain/use_cases/fetch_photo.dart';
import 'package:awesome_app_details/details/presentation/blocs/photo_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key, required this.photoId}) : super(key: key);

  final int photoId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('$photoId'),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          icon: Icon(
            Icons.chevron_left,
            color: AppColors.orange,
          ),
        ),
      ),
      body: BlocProvider<PhotoCubit>(
        create: (context) => PhotoCubit(
          FetchPhoto(
            PhotoRepositoryImpl(
              PhotoRemoteDataSourceImpl(http.Client()),
              InternetConnectionChecker(),
            ),
          ),
        )..fetchPhoto(photoId),
        child: SingleChildScrollView(child: BlocBuilder<PhotoCubit, PhotoState>(
          builder: (context, state) {
            if (state is FailedLoadPhoto) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Gap.p24(),
                    Text(
                      state.message,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Gap.p16(),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<PhotoCubit>(context).fetchPhoto(photoId);
                      },
                      child: Text(
                        'Retry',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    )
                  ],
                ),
              );
            } else if (state is PhotoLoaded) {
              return _buildScreen(context, state.photo);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),),
      ),
    );
  }

  Column _buildScreen(BuildContext context, Photo photo) {
    return Column(
      children: [
        CachedNetworkImage(
          placeholder: (context, url) => AspectRatio(
            aspectRatio: 3 / 4,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.grey,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
          imageUrl: photo.src.large,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Creator',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Gap.p8(),
                Text(
                  photo.photographer ?? 'NN',
                  style: Theme.of(context).textTheme.headline5,
                ),
                Gap.p16(),
                Text(
                  'Size',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                Gap.p8(),
                Text(
                  '${photo.width}x${photo.height}',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
