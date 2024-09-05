import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gal/gal.dart';
import 'package:heron/constants/request.dart';
import 'package:heron/utilities/auth.dart';
import 'package:heron/widgets/appbar/appbar.dart';
import 'package:heron/widgets/appbar/status.dart';
import 'package:heron/widgets/button/icon.dart';
import 'package:heron/widgets/other/future.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:share_plus/share_plus.dart';

class ImageScreen extends StatefulWidget {
  final String id;

  const ImageScreen(this.id, {super.key});

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  bool _isAppBarVisible = true;
  bool _isLoading = true;
  late String _imagePath;

  @override
  void initState() {
    super.initState();
    _imagePath = '${Directory.systemTemp.path}/${widget.id}.jpg';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kHeronAppBarHeight),
        child: AnimatedOpacity(
          opacity: _isAppBarVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 180),
          child: DecoratedBox(
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.8)),
            child: HeronAppBar(
              title: Text(
                l10n.imageScreenTitle,
                style: const TextStyle(color: Colors.white),
              ),
              backButtonIcon: const Icon(
                HugeIcons.strokeRoundedArrowLeft01,
                color: Colors.white,
              ),
              actions: [
                AbsorbPointer(
                  absorbing: _isLoading,
                  child: Row(
                    children: [
                      HeronIconButton(
                        icon: const Icon(
                          HugeIcons.strokeRoundedDownload04,
                          color: Colors.white,
                          size: 27.0,
                        ),
                        onPressed: () async {
                          await Gal.putImage(_imagePath, album: "Heron");

                          Fluttertoast.showToast(
                            msg: l10n.imageSaved,
                            backgroundColor: Colors.white.withOpacity(0.1),
                            textColor: Colors.white,
                          );
                        },
                      ),
                      HeronIconButton(
                        icon: const Icon(
                          HugeIcons.strokeRoundedShare08,
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          Share.shareXFiles([XFile(_imagePath)]);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: HeronFutureBuilder(
        future: () async {
          final dio = await getDio();
          return dio
              .download(
            "$kImageBaseURL/${widget.id}",
            _imagePath,
            options: Options(
              responseType: ResponseType.bytes,
            ),
          )
              .then((v) {
            setState(() {
              _isLoading = false;
            });
            return v;
          });
        },
        builder: (context, snapshot) => HeronFutureFader(
          snapshot: snapshot,
          builder: (context, snapshot) => StatusBarColor(
            brightness: Brightness.light,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isAppBarVisible = !_isAppBarVisible;
                });
              },
              child: PhotoView(
                backgroundDecoration: const BoxDecoration(color: Colors.black),
                minScale: PhotoViewComputedScale.contained,
                imageProvider: FileImage(
                  File(_imagePath),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
