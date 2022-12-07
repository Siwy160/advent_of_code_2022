abstract class Item {
  int size();
}

class FileTree {
  final Directory root = Directory("/");
  final List<String> currentPath = [];

  void insertTo(Item item, List<String> path) {
    Directory currentDirectory = root;
    path.forEach((targetDirectory) {
      if (targetDirectory == "/") {
        currentDirectory;
      } else {
        List<Directory> subdirectories = currentDirectory.subdirectories();
        var target = subdirectories.firstWhere((element) => element.name == targetDirectory);
        currentDirectory = target;
      }
    });
    currentDirectory.add(item);
  }

  List<Directory> getAllDirectories(Directory directory) {
    List<Directory> result = [];
    var subdirectories = directory.subdirectories();
    result.addAll(subdirectories);
    subdirectories.forEach((element) {
      result.addAll(getAllDirectories(element));
    });
    return result;
  }
}

class Directory extends Item {
  final String name;
  final List<Item> contents = [];

  Directory(this.name);

  void add(Item item) {
    contents.add(item);
  }

  List<Directory> subdirectories() {
    List<Directory> result = [];
    contents.forEach((element) {
      if (element is Directory) {
        result.add(element);
      }
    });
    return result;
  }

  @override
  int size() => contents.map((e) => e.size()).reduce((value, element) => value + element);
}

class File extends Item {
  final String name;
  final int _size;

  File(this.name, this._size);

  @override
  int size() => _size;
}
