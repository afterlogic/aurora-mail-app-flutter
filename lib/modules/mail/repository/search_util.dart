import 'package:intl/intl.dart';

const searchUtil = const _SearchUtil();
final dateFormat = DateFormat('yyyy.MM.dd');
class _SearchUtil {
  const _SearchUtil();

  List<SearchParams> searchParams(String text) {
    var params = <SearchParams>[];
    final matches =
        RegExp(r" *(?<pattern>\w+):(?:(?:'(?<value>.*)')|(?<value1>[^ ]*))")
            .allMatches(text);
    for (var value in matches) {
      final patternText = _selectPattern(value.namedGroup("pattern"));

      params.add(
        SearchParams(
          value.namedGroup("value") ?? value.namedGroup("value1") ?? "",
          patternText,
        ),
      );
    }
    if (params.isEmpty) {
      return [SearchParams(text, SearchPattern.Default)];
    }
    return params;
  }

  String wrap(SearchPattern pattern, String text) {
    if (text.contains(" ")) {
      return _patternToText(pattern) + ":'" + text + "' ";
    } else {
      return _patternToText(pattern) + ":" + text + " ";
    }
  }

  SearchPattern _selectPattern(String textPattern) {
    switch (textPattern) {
      case _email:
        return SearchPattern.Email;
      case _from:
        return SearchPattern.From;
      case _to:
        return SearchPattern.To;
      case _subject:
        return SearchPattern.Subject;
      case _hasAttachment:
        return SearchPattern.HasAttachment;
      case _since:
        return SearchPattern.Since;
      case _till:
        return SearchPattern.Till;
      case _text:
        return SearchPattern.Text;
      default:
        return SearchPattern.Default;
    }
  }

  String _patternToText(SearchPattern pattern) {
    switch (pattern) {
      case SearchPattern.Default:
        return "default";
      case SearchPattern.Email:
        return _email;
      case SearchPattern.From:
        return _from;
      case SearchPattern.To:
        return _to;
      case SearchPattern.Subject:
        return _to;
      case SearchPattern.HasAttachment:
        return _hasAttachment;
      case SearchPattern.Since:
        return _since;
      case SearchPattern.Till:
        return _till;
      case SearchPattern.Text:
        return _text;
    }
    return "default";
  }

  static const _email = "email";
  static const _from = "from";
  static const _to = "to";
  static const _subject = "subject";
  static const _hasAttachment = "attachment";
  static const _since = "since";
  static const _till = "till";
  static const _text = "text";
}

class SearchParams {
  final String value;
  final SearchPattern pattern;

  SearchParams(this.value, this.pattern);
}

enum SearchPattern {
  Default,
  Email,
  From,
  To,
  Subject,
  HasAttachment,
  Since,
  Till,
  Text,
}
