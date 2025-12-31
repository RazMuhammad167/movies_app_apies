class NewsPaperModel {
  List<Newspapers>? newspapers;

  NewsPaperModel({this.newspapers});

  NewsPaperModel.fromJson(Map<String, dynamic> json) {
    if (json['newspapers'] != null) {
      newspapers = <Newspapers>[];
      json['newspapers'].forEach((v) {
        newspapers!.add(new Newspapers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.newspapers != null) {
      data['newspapers'] = this.newspapers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Newspapers {
  String? lccn;
  String? url;
  String? state;
  String? title;

  Newspapers({this.lccn, this.url, this.state, this.title});

  Newspapers.fromJson(Map<String, dynamic> json) {
    lccn = json['lccn'];
    url = json['url'];
    state = json['state'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lccn'] = this.lccn;
    data['url'] = this.url;
    data['state'] = this.state;
    data['title'] = this.title;
    return data;
  }
}