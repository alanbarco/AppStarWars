class PeliculaSW {
    String title;
    String url;

    PeliculaSW({
        required this.title,
        required this.url,
    });

    factory PeliculaSW.fromJson(Map<String, dynamic> json) => PeliculaSW(
        title: json["title"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "url": url,
    };
}
