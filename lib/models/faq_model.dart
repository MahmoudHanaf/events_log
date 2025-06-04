class FAQModel {
  int id;
  String date;
  String dateGmt;
  Guid guid;
  String modified;
  String modifiedGmt;
  String slug;
  String status;
  String type;
  String link;
  Title title;
  Content content;
  Excerpt excerpt;
  int author;
  int featuredMedia;
  int parent;
  int menuOrder;
  String commentStatus;
  String pingStatus;
  String template;
  Meta meta;
  List<dynamic> acf;
  Links links;

  FAQModel({
    required this.id,
    required this.date,
    required this.dateGmt,
    required this.guid,
    required this.modified,
    required this.modifiedGmt,
    required this.slug,
    required this.status,
    required this.type,
    required this.link,
    required this.title,
    required this.content,
    required this.excerpt,
    required this.author,
    required this.featuredMedia,
    required this.parent,
    required this.menuOrder,
    required this.commentStatus,
    required this.pingStatus,
    required this.template,
    required this.meta,
    required this.acf,
    required this.links,
  });

  factory FAQModel.fromJson(Map<String, dynamic> json) {
    return FAQModel(
      id: json['id'],
      date: json['date'],
      dateGmt: json['date_gmt'],
      guid: Guid.fromJson(json['guid']),
      modified: json['modified'],
      modifiedGmt: json['modified_gmt'],
      slug: json['slug'],
      status: json['status'],
      type: json['type'],
      link: json['link'],
      title: Title.fromJson(json['title']),
      content: Content.fromJson(json['content']),
      excerpt: Excerpt.fromJson(json['excerpt']),
      author: json['author'],
      featuredMedia: json['featured_media'],
      parent: json['parent'],
      menuOrder: json['menu_order'],
      commentStatus: json['comment_status'],
      pingStatus: json['ping_status'],
      template: json['template'],
      meta: Meta.fromJson(json['meta']),
      acf: json['acf'],
      links: Links.fromJson(json['_links']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'date_gmt': dateGmt,
      'guid': guid.toJson(),
      'modified': modified,
      'modified_gmt': modifiedGmt,
      'slug': slug,
      'status': status,
      'type': type,
      'link': link,
      'title': title.toJson(),
      'content': content.toJson(),
      'excerpt': excerpt.toJson(),
      'author': author,
      'featured_media': featuredMedia,
      'parent': parent,
      'menu_order': menuOrder,
      'comment_status': commentStatus,
      'ping_status': pingStatus,
      'template': template,
      'meta': meta.toJson(),
      'acf': acf,
      '_links': links.toJson(),
    };
  }
}

class Guid {
  String rendered;

  Guid({required this.rendered});

  factory Guid.fromJson(Map<String, dynamic> json) {
    return Guid(rendered: json['rendered']);
  }

  Map<String, dynamic> toJson() {
    return {'rendered': rendered};
  }
}

class Title {
  String rendered;

  Title({required this.rendered});

  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(rendered: json['rendered']);
  }

  Map<String, dynamic> toJson() {
    return {'rendered': rendered};
  }
}

class Content {
  String rendered;
  bool protected;

  Content({required this.rendered, required this.protected});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(rendered: json['rendered'], protected: json['protected']);
  }

  Map<String, dynamic> toJson() {
    return {'rendered': rendered, 'protected': protected};
  }
}

class Excerpt {
  String rendered;
  bool protected;

  Excerpt({required this.rendered, required this.protected});

  factory Excerpt.fromJson(Map<String, dynamic> json) {
    return Excerpt(rendered: json['rendered'], protected: json['protected']);
  }

  Map<String, dynamic> toJson() {
    return {'rendered': rendered, 'protected': protected};
  }
}

class Meta {
  String footnotes;

  Meta({required this.footnotes});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(footnotes: json['footnotes']);
  }

  Map<String, dynamic> toJson() {
    return {'footnotes': footnotes};
  }
}

class Links {
  List<Self> self;
  List<Collection> collection;
  List<About> about;
  List<Author> author;
  List<Replies> replies;
  List<VersionHistory> versionHistory;
  List<WpAttachment> wpAttachment;
  List<Cury> curies;

  Links({
    required this.self,
    required this.collection,
    required this.about,
    required this.author,
    required this.replies,
    required this.versionHistory,
    required this.wpAttachment,
    required this.curies,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      self: (json['self'] as List).map((item) => Self.fromJson(item)).toList(),
      collection:
          (json['collection'] as List)
              .map((item) => Collection.fromJson(item))
              .toList(),
      about:
          (json['about'] as List).map((item) => About.fromJson(item)).toList(),
      author:
          (json['author'] as List)
              .map((item) => Author.fromJson(item))
              .toList(),
      replies:
          (json['replies'] as List)
              .map((item) => Replies.fromJson(item))
              .toList(),
      versionHistory:
          (json['version-history'] as List)
              .map((item) => VersionHistory.fromJson(item))
              .toList(),
      wpAttachment:
          (json['wp:attachment'] as List)
              .map((item) => WpAttachment.fromJson(item))
              .toList(),
      curies:
          (json['curies'] as List).map((item) => Cury.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'self': self.map((item) => item.toJson()).toList(),
      'collection': collection.map((item) => item.toJson()).toList(),
      'about': about.map((item) => item.toJson()).toList(),
      'author': author.map((item) => item.toJson()).toList(),
      'replies': replies.map((item) => item.toJson()).toList(),
      'version-history': versionHistory.map((item) => item.toJson()).toList(),
      'wp:attachment': wpAttachment.map((item) => item.toJson()).toList(),
      'curies': curies.map((item) => item.toJson()).toList(),
    };
  }
}

class Self {
  String href;

  Self({required this.href});

  factory Self.fromJson(Map<String, dynamic> json) {
    return Self(href: json['href']);
  }

  Map<String, dynamic> toJson() {
    return {'href': href};
  }
}

class Collection {
  String href;

  Collection({required this.href});

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(href: json['href']);
  }

  Map<String, dynamic> toJson() {
    return {'href': href};
  }
}

class About {
  String href;

  About({required this.href});

  factory About.fromJson(Map<String, dynamic> json) {
    return About(href: json['href']);
  }

  Map<String, dynamic> toJson() {
    return {'href': href};
  }
}

class Author {
  bool embeddable;
  String href;

  Author({required this.embeddable, required this.href});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(embeddable: json['embeddable'], href: json['href']);
  }

  Map<String, dynamic> toJson() {
    return {'embeddable': embeddable, 'href': href};
  }
}

class Replies {
  bool embeddable;
  String href;

  Replies({required this.embeddable, required this.href});

  factory Replies.fromJson(Map<String, dynamic> json) {
    return Replies(embeddable: json['embeddable'], href: json['href']);
  }

  Map<String, dynamic> toJson() {
    return {'embeddable': embeddable, 'href': href};
  }
}

class VersionHistory {
  int count;
  String href;

  VersionHistory({required this.count, required this.href});

  factory VersionHistory.fromJson(Map<String, dynamic> json) {
    return VersionHistory(count: json['count'], href: json['href']);
  }

  Map<String, dynamic> toJson() {
    return {'count': count, 'href': href};
  }
}

class WpAttachment {
  String href;

  WpAttachment({required this.href});

  factory WpAttachment.fromJson(Map<String, dynamic> json) {
    return WpAttachment(href: json['href']);
  }

  Map<String, dynamic> toJson() {
    return {'href': href};
  }
}

class Cury {
  String name;
  String href;
  bool templated;

  Cury({required this.name, required this.href, required this.templated});

  factory Cury.fromJson(Map<String, dynamic> json) {
    return Cury(
      name: json['name'],
      href: json['href'],
      templated: json['templated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'href': href, 'templated': templated};
  }
}
