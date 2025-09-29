class SearchEngineModel {
  SearchEngineModel({
    required this.kind,
    required this.url,
    required this.queries,
    required this.context,
    required this.searchInformation,
    required this.items,
  });

  final String? kind;
  final Url? url;
  final Queries? queries;
  final Context? context;
  final SearchInformation? searchInformation;
  final List<Item> items;

  SearchEngineModel copyWith({
    String? kind,
    Url? url,
    Queries? queries,
    Context? context,
    SearchInformation? searchInformation,
    List<Item>? items,
  }) {
    return SearchEngineModel(
      kind: kind ?? this.kind,
      url: url ?? this.url,
      queries: queries ?? this.queries,
      context: context ?? this.context,
      searchInformation: searchInformation ?? this.searchInformation,
      items: items ?? this.items,
    );
  }

  factory SearchEngineModel.fromJson(Map<String, dynamic> json) {
    return SearchEngineModel(
      kind: json["kind"],
      url: json["url"] == null ? null : Url.fromJson(json["url"]),
      queries: json["queries"] == null ? null : Queries.fromJson(json["queries"]),
      context: json["context"] == null ? null : Context.fromJson(json["context"]),
      searchInformation: json["searchInformation"] == null ? null : SearchInformation.fromJson(json["searchInformation"]),
      items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "url": url?.toJson(),
        "queries": queries?.toJson(),
        "context": context?.toJson(),
        "searchInformation": searchInformation?.toJson(),
        "items": items.map((x) => x?.toJson()).toList(),
      };

  @override
  String toString() {
    return "$kind, $url, $queries, $context, $searchInformation, $items, ";
  }
}

class Context {
  Context({
    required this.title,
  });

  final String? title;

  Context copyWith({
    String? title,
  }) {
    return Context(
      title: title ?? this.title,
    );
  }

  factory Context.fromJson(Map<String, dynamic> json) {
    return Context(
      title: json["title"],
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
      };

  @override
  String toString() {
    return "$title, ";
  }
}

class Item {
  Item({
    required this.kind,
    required this.title,
    required this.htmlTitle,
    required this.link,
    required this.displayLink,
    required this.snippet,
    required this.htmlSnippet,
    required this.formattedUrl,
    required this.htmlFormattedUrl,
    required this.pagemap,
  });

  final String? kind;
  final String? title;
  final String? htmlTitle;
  final String? link;
  final String? displayLink;
  final String? snippet;
  final String? htmlSnippet;
  final String? formattedUrl;
  final String? htmlFormattedUrl;
  final Pagemap? pagemap;

  Item copyWith({
    String? kind,
    String? title,
    String? htmlTitle,
    String? link,
    String? displayLink,
    String? snippet,
    String? htmlSnippet,
    String? formattedUrl,
    String? htmlFormattedUrl,
    Pagemap? pagemap,
  }) {
    return Item(
      kind: kind ?? this.kind,
      title: title ?? this.title,
      htmlTitle: htmlTitle ?? this.htmlTitle,
      link: link ?? this.link,
      displayLink: displayLink ?? this.displayLink,
      snippet: snippet ?? this.snippet,
      htmlSnippet: htmlSnippet ?? this.htmlSnippet,
      formattedUrl: formattedUrl ?? this.formattedUrl,
      htmlFormattedUrl: htmlFormattedUrl ?? this.htmlFormattedUrl,
      pagemap: pagemap ?? this.pagemap,
    );
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      kind: json["kind"],
      title: json["title"],
      htmlTitle: json["htmlTitle"],
      link: json["link"],
      displayLink: json["displayLink"],
      snippet: json["snippet"],
      htmlSnippet: json["htmlSnippet"],
      formattedUrl: json["formattedUrl"],
      htmlFormattedUrl: json["htmlFormattedUrl"],
      pagemap: json["pagemap"] == null ? null : Pagemap.fromJson(json["pagemap"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "title": title,
        "htmlTitle": htmlTitle,
        "link": link,
        "displayLink": displayLink,
        "snippet": snippet,
        "htmlSnippet": htmlSnippet,
        "formattedUrl": formattedUrl,
        "htmlFormattedUrl": htmlFormattedUrl,
        "pagemap": pagemap?.toJson(),
      };

  @override
  String toString() {
    return "$kind, $title, $htmlTitle, $link, $displayLink, $snippet, $htmlSnippet, $formattedUrl, $htmlFormattedUrl, $pagemap, ";
  }
}

class Pagemap {
  Pagemap({
    required this.cseThumbnail,
    required this.metatags,
    required this.cseImage,
    required this.hcard,
    required this.hproduct,
    required this.thumbnail,
    required this.webpage,
    required this.listitem,
  });

  final List<CseThumbnail> cseThumbnail;
  final List<Map<String, String>> metatags;
  final List<CseImage> cseImage;
  final List<Hcard> hcard;
  final List<Hproduct> hproduct;
  final List<CseImage> thumbnail;
  final List<Webpage> webpage;
  final List<Listitem> listitem;

  Pagemap copyWith({
    List<CseThumbnail>? cseThumbnail,
    List<Map<String, String>>? metatags,
    List<CseImage>? cseImage,
    List<Hcard>? hcard,
    List<Hproduct>? hproduct,
    List<CseImage>? thumbnail,
    List<Webpage>? webpage,
    List<Listitem>? listitem,
  }) {
    return Pagemap(
      cseThumbnail: cseThumbnail ?? this.cseThumbnail,
      metatags: metatags ?? this.metatags,
      cseImage: cseImage ?? this.cseImage,
      hcard: hcard ?? this.hcard,
      hproduct: hproduct ?? this.hproduct,
      thumbnail: thumbnail ?? this.thumbnail,
      webpage: webpage ?? this.webpage,
      listitem: listitem ?? this.listitem,
    );
  }

  factory Pagemap.fromJson(Map<String, dynamic> json) {
    return Pagemap(
      cseThumbnail: json["cse_thumbnail"] == null ? [] : List<CseThumbnail>.from(json["cse_thumbnail"]!.map((x) => CseThumbnail.fromJson(x))),
      metatags: json["metatags"] == null ? [] : List<Map<String, String>>.from(json["metatags"]!.map((x) => Map.from(x).map((k, v) => MapEntry<String, String>(k, v)))),
      cseImage: json["cse_image"] == null ? [] : List<CseImage>.from(json["cse_image"]!.map((x) => CseImage.fromJson(x))),
      hcard: json["hcard"] == null ? [] : List<Hcard>.from(json["hcard"]!.map((x) => Hcard.fromJson(x))),
      hproduct: json["hproduct"] == null ? [] : List<Hproduct>.from(json["hproduct"]!.map((x) => Hproduct.fromJson(x))),
      thumbnail: json["thumbnail"] == null ? [] : List<CseImage>.from(json["thumbnail"]!.map((x) => CseImage.fromJson(x))),
      webpage: json["webpage"] == null ? [] : List<Webpage>.from(json["webpage"]!.map((x) => Webpage.fromJson(x))),
      listitem: json["listitem"] == null ? [] : List<Listitem>.from(json["listitem"]!.map((x) => Listitem.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "cse_thumbnail": cseThumbnail.map((x) => x?.toJson()).toList(),
        "metatags": metatags.map((x) => Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v))).toList(),
        "cse_image": cseImage.map((x) => x?.toJson()).toList(),
        "hcard": hcard.map((x) => x?.toJson()).toList(),
        "hproduct": hproduct.map((x) => x?.toJson()).toList(),
        "thumbnail": thumbnail.map((x) => x?.toJson()).toList(),
        "webpage": webpage.map((x) => x?.toJson()).toList(),
        "listitem": listitem.map((x) => x?.toJson()).toList(),
      };

  @override
  String toString() {
    return "$cseThumbnail, $metatags, $cseImage, $hcard, $hproduct, $thumbnail, $webpage, $listitem, ";
  }
}

class CseImage {
  CseImage({
    required this.src,
  });

  final String? src;

  CseImage copyWith({
    String? src,
  }) {
    return CseImage(
      src: src ?? this.src,
    );
  }

  factory CseImage.fromJson(Map<String, dynamic> json) {
    return CseImage(
      src: json["src"],
    );
  }

  Map<String, dynamic> toJson() => {
        "src": src,
      };

  @override
  String toString() {
    return "$src, ";
  }
}

class CseThumbnail {
  CseThumbnail({
    required this.src,
    required this.width,
    required this.height,
  });

  final String? src;
  final String? width;
  final String? height;

  CseThumbnail copyWith({
    String? src,
    String? width,
    String? height,
  }) {
    return CseThumbnail(
      src: src ?? this.src,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }

  factory CseThumbnail.fromJson(Map<String, dynamic> json) {
    return CseThumbnail(
      src: json["src"],
      width: json["width"],
      height: json["height"],
    );
  }

  Map<String, dynamic> toJson() => {
        "src": src,
        "width": width,
        "height": height,
      };

  @override
  String toString() {
    return "$src, $width, $height, ";
  }
}

class Hcard {
  Hcard({
    required this.fn,
  });

  final String? fn;

  Hcard copyWith({
    String? fn,
  }) {
    return Hcard(
      fn: fn ?? this.fn,
    );
  }

  factory Hcard.fromJson(Map<String, dynamic> json) {
    return Hcard(
      fn: json["fn"],
    );
  }

  Map<String, dynamic> toJson() => {
        "fn": fn,
      };

  @override
  String toString() {
    return "$fn, ";
  }
}

class Hproduct {
  Hproduct({
    required this.price,
    required this.fn,
    required this.photo,
    required this.currency,
    required this.currencyIso4217,
    required this.url,
  });

  final String? price;
  final String? fn;
  final String? photo;
  final String? currency;
  final String? currencyIso4217;
  final String? url;

  Hproduct copyWith({
    String? price,
    String? fn,
    String? photo,
    String? currency,
    String? currencyIso4217,
    String? url,
  }) {
    return Hproduct(
      price: price ?? this.price,
      fn: fn ?? this.fn,
      photo: photo ?? this.photo,
      currency: currency ?? this.currency,
      currencyIso4217: currencyIso4217 ?? this.currencyIso4217,
      url: url ?? this.url,
    );
  }

  factory Hproduct.fromJson(Map<String, dynamic> json) {
    return Hproduct(
      price: json["price"],
      fn: json["fn"],
      photo: json["photo"],
      currency: json["currency"],
      currencyIso4217: json["currency_iso4217"],
      url: json["url"],
    );
  }

  Map<String, dynamic> toJson() => {
        "price": price,
        "fn": fn,
        "photo": photo,
        "currency": currency,
        "currency_iso4217": currencyIso4217,
        "url": url,
      };

  @override
  String toString() {
    return "$price, $fn, $photo, $currency, $currencyIso4217, $url, ";
  }
}

class Listitem {
  Listitem({
    required this.item,
    required this.name,
    required this.position,
  });

  final String? item;
  final String? name;
  final String? position;

  Listitem copyWith({
    String? item,
    String? name,
    String? position,
  }) {
    return Listitem(
      item: item ?? this.item,
      name: name ?? this.name,
      position: position ?? this.position,
    );
  }

  factory Listitem.fromJson(Map<String, dynamic> json) {
    return Listitem(
      item: json["item"],
      name: json["name"],
      position: json["position"],
    );
  }

  Map<String, dynamic> toJson() => {
        "item": item,
        "name": name,
        "position": position,
      };

  @override
  String toString() {
    return "$item, $name, $position, ";
  }
}

class Webpage {
  Webpage({
    required this.name,
    required this.description,
  });

  final String? name;
  final String? description;

  Webpage copyWith({
    String? name,
    String? description,
  }) {
    return Webpage(
      name: name ?? this.name,
      description: description ?? this.description,
    );
  }

  factory Webpage.fromJson(Map<String, dynamic> json) {
    return Webpage(
      name: json["name"],
      description: json["description"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
      };

  @override
  String toString() {
    return "$name, $description, ";
  }
}

class Queries {
  Queries({
    required this.request,
    required this.nextPage,
  });

  final List<NextPage> request;
  final List<NextPage> nextPage;

  Queries copyWith({
    List<NextPage>? request,
    List<NextPage>? nextPage,
  }) {
    return Queries(
      request: request ?? this.request,
      nextPage: nextPage ?? this.nextPage,
    );
  }

  factory Queries.fromJson(Map<String, dynamic> json) {
    return Queries(
      request: json["request"] == null ? [] : List<NextPage>.from(json["request"]!.map((x) => NextPage.fromJson(x))),
      nextPage: json["nextPage"] == null ? [] : List<NextPage>.from(json["nextPage"]!.map((x) => NextPage.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "request": request.map((x) => x?.toJson()).toList(),
        "nextPage": nextPage.map((x) => x?.toJson()).toList(),
      };

  @override
  String toString() {
    return "$request, $nextPage, ";
  }
}

class NextPage {
  NextPage({
    required this.title,
    required this.totalResults,
    required this.searchTerms,
    required this.count,
    required this.startIndex,
    required this.inputEncoding,
    required this.outputEncoding,
    required this.safe,
    required this.cx,
  });

  final String? title;
  final String? totalResults;
  final String? searchTerms;
  final int? count;
  final int? startIndex;
  final String? inputEncoding;
  final String? outputEncoding;
  final String? safe;
  final String? cx;

  NextPage copyWith({
    String? title,
    String? totalResults,
    String? searchTerms,
    int? count,
    int? startIndex,
    String? inputEncoding,
    String? outputEncoding,
    String? safe,
    String? cx,
  }) {
    return NextPage(
      title: title ?? this.title,
      totalResults: totalResults ?? this.totalResults,
      searchTerms: searchTerms ?? this.searchTerms,
      count: count ?? this.count,
      startIndex: startIndex ?? this.startIndex,
      inputEncoding: inputEncoding ?? this.inputEncoding,
      outputEncoding: outputEncoding ?? this.outputEncoding,
      safe: safe ?? this.safe,
      cx: cx ?? this.cx,
    );
  }

  factory NextPage.fromJson(Map<String, dynamic> json) {
    return NextPage(
      title: json["title"],
      totalResults: json["totalResults"],
      searchTerms: json["searchTerms"],
      count: json["count"],
      startIndex: json["startIndex"],
      inputEncoding: json["inputEncoding"],
      outputEncoding: json["outputEncoding"],
      safe: json["safe"],
      cx: json["cx"],
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "totalResults": totalResults,
        "searchTerms": searchTerms,
        "count": count,
        "startIndex": startIndex,
        "inputEncoding": inputEncoding,
        "outputEncoding": outputEncoding,
        "safe": safe,
        "cx": cx,
      };

  @override
  String toString() {
    return "$title, $totalResults, $searchTerms, $count, $startIndex, $inputEncoding, $outputEncoding, $safe, $cx, ";
  }
}

class SearchInformation {
  SearchInformation({
    required this.searchTime,
    required this.formattedSearchTime,
    required this.totalResults,
    required this.formattedTotalResults,
  });

  final double? searchTime;
  final String? formattedSearchTime;
  final String? totalResults;
  final String? formattedTotalResults;

  SearchInformation copyWith({
    double? searchTime,
    String? formattedSearchTime,
    String? totalResults,
    String? formattedTotalResults,
  }) {
    return SearchInformation(
      searchTime: searchTime ?? this.searchTime,
      formattedSearchTime: formattedSearchTime ?? this.formattedSearchTime,
      totalResults: totalResults ?? this.totalResults,
      formattedTotalResults: formattedTotalResults ?? this.formattedTotalResults,
    );
  }

  factory SearchInformation.fromJson(Map<String, dynamic> json) {
    return SearchInformation(
      searchTime: json["searchTime"],
      formattedSearchTime: json["formattedSearchTime"],
      totalResults: json["totalResults"],
      formattedTotalResults: json["formattedTotalResults"],
    );
  }

  Map<String, dynamic> toJson() => {
        "searchTime": searchTime,
        "formattedSearchTime": formattedSearchTime,
        "totalResults": totalResults,
        "formattedTotalResults": formattedTotalResults,
      };

  @override
  String toString() {
    return "$searchTime, $formattedSearchTime, $totalResults, $formattedTotalResults, ";
  }
}

class Url {
  Url({
    required this.type,
    required this.template,
  });

  final String? type;
  final String? template;

  Url copyWith({
    String? type,
    String? template,
  }) {
    return Url(
      type: type ?? this.type,
      template: template ?? this.template,
    );
  }

  factory Url.fromJson(Map<String, dynamic> json) {
    return Url(
      type: json["type"],
      template: json["template"],
    );
  }

  Map<String, dynamic> toJson() => {
        "type": type,
        "template": template,
      };

  @override
  String toString() {
    return "$type, $template, ";
  }
}
