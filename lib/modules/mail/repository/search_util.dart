import 'package:intl/intl.dart';

const searchUtil = const _SearchUtil();
final dateFormat = DateFormat('yyyy.MM.dd');

class _SearchUtil {
  const _SearchUtil();

  List<SearchParams> searchParams(String text) {
    if (text == null) {
      return [];
    }
    var params = <SearchParams>[];
    final matches =
        RegExp(r" *(?<pattern>\w+):(?:(?:'(?<value>.*)')|(?<value1>[^ ]*))")
            .allMatches(text);
    for (var item in matches) {
      final pattern = _selectPattern(item.namedGroup("pattern"));
      final value = item.namedGroup("value") ?? item.namedGroup("value1") ?? "";
      SearchParams searchParams;

      if (pattern == SearchPattern.Date) {
        final date =
            value.split("/").map((item) => tryParseDate(item)).toList();
        if (date.length == 1) {
          searchParams = DateSearchParams(
            value,
            pattern,
            date[0],
            null,
          );
        } else {
          searchParams = DateSearchParams(
            value,
            pattern,
            date[0],
            date[1],
          );
        }
      } else if (pattern == SearchPattern.Has) {
        final flags = value.split(",").map((item) => _selectFlag(item)).toSet();
        searchParams = HasSearchParams(
          value,
          pattern,
          flags,
        );
      } else {
        searchParams = SearchParams(
          value,
          pattern,
        );
      }
      params.add(searchParams);
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

  String wrapDate(DateTime since, DateTime till) {
    return _patternToText(SearchPattern.Date) +
        ":${since == null ? "" : dateFormat.format(since)}/${till == null ? "" : dateFormat.format(till)}";
  }

  String wrapFlag(Iterable<SearchFlag> flag) {
    return _patternToText(SearchPattern.Has) +
        ":${flag.map((item) => _flagToText(item)).join(",")}";
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
      case _has:
        return SearchPattern.Has;
      case _date:
        return SearchPattern.Date;
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
      case SearchPattern.Has:
        return _has;
      case SearchPattern.Date:
        return _date;
      case SearchPattern.Text:
        return _text;
    }
    return "invalid";
  }

  SearchFlag _selectFlag(String textPattern) {
    switch (textPattern) {
      case _attachment:
        return SearchFlag.Attachment;
      default:
        return null;
    }
  }

  String _flagToText(SearchFlag flag) {
    switch (flag) {
      case SearchFlag.Attachment:
        return _attachment;
    }
    return "invalid";
  }

  DateTime tryParseDate(String date) {
    try {
      return dateFormat.parse(date);
    } catch (e) {
      return null;
    }
  }

  static const _email = "email";
  static const _from = "from";
  static const _to = "to";
  static const _subject = "subject";
  static const _has = "has";
  static const _date = "date";
  static const _text = "text";

  static const _attachment = "attachment";
}

class SearchParams {
  final String value;
  final SearchPattern pattern;

  SearchParams(this.value, this.pattern);
}

class HasSearchParams extends SearchParams {
  final Set<SearchFlag> flags;

  HasSearchParams(String value, SearchPattern pattern, this.flags)
      : super(value, pattern);
}

class DateSearchParams extends SearchParams {
  final DateTime since;
  final DateTime till;

  DateSearchParams(String value, SearchPattern pattern, this.since, this.till)
      : super(value, pattern);
}

enum SearchPattern {
  Default,
  Email,
  From,
  To,
  Subject,
  Has,
  Date,
  Text,
}
enum SearchFlag { Attachment }
