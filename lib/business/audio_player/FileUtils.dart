import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../utils/Constants.dart';
import '../../utils/app_util.dart';
import 'FileUtils.dart' as DownloaderPlugin;

Future<String> getAppInternalFolderPath() async {
  Directory appDocumentsDirectory = await getApplicationDocumentsDirectory(); // 1
  return appDocumentsDirectory.path; // 2
}

Future<void> copyAssetImageToAppFolder(String destinationFilePath, String assetFileName) async {
  try {
    await Directory(dirname(destinationFilePath)).create(recursive: true);
  } catch (_) {}
  // Copy from asset
  const String assetsFolder = "assets";
  const String assetsImagesFolder = assetsFolder+"/"+"drawables"+"/";
  ByteData sourceData =
  await rootBundle.load(join(assetsImagesFolder, assetFileName));
  List<int> sourceBytes =
  sourceData.buffer.asUint8List(sourceData.offsetInBytes, sourceData.lengthInBytes);
  // Write and flush the bytes written
  await File(destinationFilePath).writeAsBytes(sourceBytes, flush: true);
}

bool isFileExist({
  required String destinationDirPath,
  required String fileName,
}) {
  return DownloaderPlugin.isFileExist(
      destinationDirPath: destinationDirPath, fileName: fileName);
}

Future<String> getDownloadSowarInternalFolderPath() async {
  String path = join(
      await getAppInternalFolderPath(), Constants.DownloadSowarFolderName) +
      Platform.pathSeparator;
  return path;
}

Future<bool> getTelawaDownloadStatus(int readerId, int soraNum) async {
  var soraNumText = getStringOfSoraNumber(soraNum);
  String fileName = "$readerId-$soraNumText${Constants.extensionMp3}";
  return isFileExist(
    destinationDirPath: await getDownloadSowarInternalFolderPath(),
    fileName: fileName,
  );
}
