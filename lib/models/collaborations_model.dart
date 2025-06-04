import 'dart:convert';

class CollaborationsModel {
  final int id;
  final String date;
  final String dateGmt;
  final Guid guid;
  final String modified;
  final String modifiedGmt;
  final String slug;
  final String status;
  final String type;
  final String link;
  final Title title;
  final Content content;
  final Excerpt excerpt;
  final int author;
  final int featuredMedia;
  final int parent;
  final int menuOrder;
  final String commentStatus;
  final String pingStatus;
  final String template;
  final Meta meta;
  final List<dynamic> acf;
  final Links links;

  CollaborationsModel({
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

  factory CollaborationsModel.fromJson(Map<String, dynamic> json) {
    return CollaborationsModel(
      id: json['id'] as int,
      date: json['date'] as String,
      dateGmt: json['date_gmt'] as String,
      guid: Guid.fromJson(json['guid'] as Map<String, dynamic>),
      modified: json['modified'] as String,
      modifiedGmt: json['modified_gmt'] as String,
      slug: json['slug'] as String,
      status: json['status'] as String,
      type: json['type'] as String,
      link: json['link'] as String,
      title: Title.fromJson(json['title'] as Map<String, dynamic>),
      content: Content.fromJson(json['content'] as Map<String, dynamic>),
      excerpt: Excerpt.fromJson(json['excerpt'] as Map<String, dynamic>),
      author: json['author'] as int,
      featuredMedia: json['featured_media'] as int,
      parent: json['parent'] as int,
      menuOrder: json['menu_order'] as int,
      commentStatus: json['comment_status'] as String,
      pingStatus: json['ping_status'] as String,
      template: json['template'] as String,
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      acf: json['acf'] as List<dynamic>,
      links: Links.fromJson(json['_links'] as Map<String, dynamic>),
    );
  }
}

class Guid {
  final String rendered;

  Guid({required this.rendered});

  factory Guid.fromJson(Map<String, dynamic> json) {
    return Guid(rendered: json['rendered'] as String);
  }
}

class Title {
  final String rendered;

  Title({required this.rendered});

  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(rendered: json['rendered'] as String);
  }
}

class Content {
  final String rendered;
  final bool protected;

  Content({required this.rendered, required this.protected});

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      rendered: json['rendered'] as String,
      protected: json['protected'] as bool,
    );
  }
}

class Excerpt {
  final String rendered;
  final bool protected;

  Excerpt({required this.rendered, required this.protected});

  factory Excerpt.fromJson(Map<String, dynamic> json) {
    return Excerpt(
      rendered: json['rendered'] as String,
      protected: json['protected'] as bool,
    );
  }
}

class Meta {
  final String footnotes;

  Meta({required this.footnotes});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(footnotes: json['footnotes'] as String);
  }
}

class Links {
  final List<Link> self;
  final List<Link> collection;
  final List<Link> about;
  final List<AuthorLink> author;
  final List<Link> replies;
  final List<VersionHistory> versionHistory;
  final List<PredecessorVersion> predecessorVersion;
  final List<Link> wpAttachment;
  final List<Cury> curies;

  Links({
    required this.self,
    required this.collection,
    required this.about,
    required this.author,
    required this.replies,
    required this.versionHistory,
    required this.predecessorVersion,
    required this.wpAttachment,
    required this.curies,
  });

  factory Links.fromJson(Map<String, dynamic> json) {
    return Links(
      self:
          (json['self'] as List<dynamic>)
              .map((e) => Link.fromJson(e as Map<String, dynamic>))
              .toList(),
      collection:
          (json['collection'] as List<dynamic>)
              .map((e) => Link.fromJson(e as Map<String, dynamic>))
              .toList(),
      about:
          (json['about'] as List<dynamic>)
              .map((e) => Link.fromJson(e as Map<String, dynamic>))
              .toList(),
      author:
          (json['author'] as List<dynamic>)
              .map((e) => AuthorLink.fromJson(e as Map<String, dynamic>))
              .toList(),
      replies:
          (json['replies'] as List<dynamic>)
              .map((e) => Link.fromJson(e as Map<String, dynamic>))
              .toList(),
      versionHistory:
          (json['version-history'] as List<dynamic>)
              .map((e) => VersionHistory.fromJson(e as Map<String, dynamic>))
              .toList(),
      predecessorVersion:
          (json['predecessor-version'] as List<dynamic>)
              .map(
                (e) => PredecessorVersion.fromJson(e as Map<String, dynamic>),
              )
              .toList(),
      wpAttachment:
          (json['wp:attachment'] as List<dynamic>)
              .map((e) => Link.fromJson(e as Map<String, dynamic>))
              .toList(),
      curies:
          (json['curies'] as List<dynamic>)
              .map((e) => Cury.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }
}

class Link {
  final String href;

  Link({required this.href});

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(href: json['href'] as String);
  }
}

class AuthorLink {
  final bool embeddable;
  final String href;

  AuthorLink({required this.embeddable, required this.href});

  factory AuthorLink.fromJson(Map<String, dynamic> json) {
    return AuthorLink(
      embeddable: json['embeddable'] as bool,
      href: json['href'] as String,
    );
  }
}

class VersionHistory {
  final int count;
  final String href;

  VersionHistory({required this.count, required this.href});

  factory VersionHistory.fromJson(Map<String, dynamic> json) {
    return VersionHistory(
      count: json['count'] as int,
      href: json['href'] as String,
    );
  }
}

class PredecessorVersion {
  final int id;
  final String href;

  PredecessorVersion({required this.id, required this.href});

  factory PredecessorVersion.fromJson(Map<String, dynamic> json) {
    return PredecessorVersion(
      id: json['id'] as int,
      href: json['href'] as String,
    );
  }
}

class Cury {
  final String name;
  final String href;
  final bool templated;

  Cury({required this.name, required this.href, required this.templated});

  factory Cury.fromJson(Map<String, dynamic> json) {
    return Cury(
      name: json['name'] as String,
      href: json['href'] as String,
      templated: json['templated'] as bool,
    );
  }
}
