const searchUtil = const _SearchUtil();

class _SearchUtil {
  const _SearchUtil();

  SearchParams searchParams(String text) {
    if (text?.startsWith(_emailCase) == true) {
      return SearchParams(
        text.substring(_emailCase.length),
        SearchPattern.Email,
      );
    } else {
      return SearchParams(
        text,
        SearchPattern.Default,
      );
    }
  }

  String searchByEmail(String email) {
    return _emailCase + email;
  }

  static const _emailCase = "email:";
}

class SearchParams {
  final String value;
  final SearchPattern pattern;

  SearchParams(this.value, this.pattern);
}

enum SearchPattern { Default, Email }
