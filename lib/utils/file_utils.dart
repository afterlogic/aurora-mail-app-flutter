class FileUtils {
  static String getFileNameFromPath(String path) {
    final List<String> pathList = path.split("/");
    return pathList.last;
  }
}