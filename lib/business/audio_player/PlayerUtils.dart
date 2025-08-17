import 'dart:io';
import 'package:path/path.dart';
import '../../utils/Constants.dart';
import 'FileUtils.dart';

Future<String> getPlayerNotificationIconPath() async {
  String appInternalFolder = await getAppInternalFolderPath();
  return "file://"+appInternalFolder+Platform.pathSeparator+Constants.playerNotificationIconName;
}

Future<void> copyPlayerNotificationIconToAppFolder() async {
  String path = join(await getAppInternalFolderPath(), Constants.playerNotificationIconName);
  bool exists = await File(path).exists();
  if(!File(path).existsSync())
  {
    await copyAssetImageToAppFolder(path,Constants.playerNotificationIconName);
  }
}