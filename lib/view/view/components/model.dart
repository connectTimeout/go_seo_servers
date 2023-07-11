class TemplateTableModle {
  final String url;
  final String tag;
  final String type;
  final String time;
  final String count;
  TemplateTableModle(
    this.url,
    this.tag,
    this.type,
    this.time,
    this.count,
  );
}

class ITextRadioModel {
  final HttpOption value;
  final String title;
  final int type;
  ITextRadioModel(this.value, this.title, this.type);
}

enum HttpOption { option0, option1, option2, option3 }
