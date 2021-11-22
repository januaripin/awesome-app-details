import 'package:awesome_app_details/details/domain/entities/photo.dart';
import 'package:awesome_app_details/details/domain/entities/photo_src.dart';
import 'package:awesome_app_details/details/presentation/blocs/photo_cubit.dart';
import 'package:awesome_app_details/details/presentation/pages/details_page.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';

import '../../../widget_test.dart';

class MockPhotoCubit extends MockBloc<PhotoCubit, PhotoState>
    implements PhotoCubit {}

class PhotoStateFake extends Fake implements PhotoState {}

void main() {
  setUpAll(() {
    registerFallbackValue(PhotoStateFake());
  });
  testWidgets('photo details', (tester) async {
    // tester.binding.window.devicePixelRatioTestValue = (2.625);
    // tester.binding.window.textScaleFactorTestValue = (1.1);
    //
    // final dpi = tester.binding.window.devicePixelRatio;
    // tester.binding.window.physicalSizeTestValue = Size(
    //   360 * dpi,
    //   800 * dpi,
    // );
    //
    // final mockPhotoCubit = MockPhotoCubit();
    //
    // when(() => mockPhotoCubit.state).thenReturn(
    //   PhotoLoaded(
    //     Photo(
    //       id: 1,
    //       width: 300,
    //       height: 400,
    //       photographerId: 1,
    //       photographer: 'Photographer 1',
    //       src: PhotoSrc(large: 'https://via.placeholder.com/300x400'),
    //     ),
    //   ),
    // );
    //
    // final page = createWidgetForTesting(child: const DetailsPage(photoId: 1));
    // await mockNetworkImagesFor(
    //   () => tester.pumpWidget(
    //     BlocProvider<PhotoCubit>(
    //         lazy: false,
    //         create: (_) => mockPhotoCubit..fetchPhoto(1),
    //         child: page),
    //     Duration(seconds: 2)
    //   ),
    // );
    //
    // expect(find.byWidget(page), findsOneWidget);
  });
}
