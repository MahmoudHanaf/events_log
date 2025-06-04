class AllEventsModel {
  final int id;
  final String date;
  final String modified;
  final String slug;
  final String status;
  final String type;
  final String link;
  final Title title;
  final Content content;
  final Excerpt excerpt;
  final int author;
  final int featuredMedia;
  final List<int> eventerCategory;
  final List<int> eventerVenue;
  final List<int> eventerOrganizer;
  final EventerOrganizer eventerOrganizerDetails;
  final EventerVenue eventerVenueDetails;

  AllEventsModel({
    required this.id,
    required this.date,
    required this.modified,
    required this.slug,
    required this.status,
    required this.type,
    required this.link,
    required this.title,
    required this.content,
    required this.excerpt,
    required this.author,
    required this.featuredMedia,
    required this.eventerCategory,
    required this.eventerVenue,
    required this.eventerOrganizer,
    required this.eventerOrganizerDetails,
    required this.eventerVenueDetails,
  });

  factory AllEventsModel.fromJson(Map<String, dynamic> json) {
    return AllEventsModel(
      id: json['id'],
      date: json['date'],
      modified: json['modified'],
      slug: json['slug'],
      status: json['status'],
      type: json['type'],
      link: json['link'],
      title: Title.fromJson(json['title']),
      content: Content.fromJson(json['content']),
      excerpt: Excerpt.fromJson(json['excerpt']),
      author: json['author'],
      featuredMedia: json['featured_media'],
      eventerCategory: List<int>.from(json['eventer-category']),
      eventerVenue: List<int>.from(json['eventer-venue']),
      eventerOrganizer: List<int>.from(json['eventer-organizer']),
      eventerOrganizerDetails: EventerOrganizer.fromJson(
        json['eventer_organizer'],
      ),
      eventerVenueDetails: EventerVenue.fromJson(json['eventer_venue']),
    );
  }
}

class Title {
  final String rendered;
  Title({required this.rendered});
  factory Title.fromJson(Map<String, dynamic> json) {
    return Title(rendered: json['rendered']);
  }
}

class Content {
  final String rendered;
  Content({required this.rendered});
  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(rendered: json['rendered']);
  }
}

class Excerpt {
  final String rendered;
  Excerpt({required this.rendered});
  factory Excerpt.fromJson(Map<String, dynamic> json) {
    return Excerpt(rendered: json['rendered']);
  }
}

class EventerOrganizer {
  final String term;
  final String organizerPhone;
  final String organizerEmail;
  final String organizerWebsite;
  final String organizerImage;

  EventerOrganizer({
    required this.term,
    required this.organizerPhone,
    required this.organizerEmail,
    required this.organizerWebsite,
    required this.organizerImage,
  });

  factory EventerOrganizer.fromJson(Map<String, dynamic> json) {
    return EventerOrganizer(
      term: json['term'],
      organizerPhone: json['organizer_phone'],
      organizerEmail: json['organizer_email'],
      organizerWebsite: json['organizer_website'],
      organizerImage: json['organizer_image'],
    );
  }
}

class EventerVenue {
  final String term;
  final String venueImage;
  final String venueAddress;
  final String venueCoordinates;

  EventerVenue({
    required this.term,
    required this.venueImage,
    required this.venueAddress,
    required this.venueCoordinates,
  });

  factory EventerVenue.fromJson(Map<String, dynamic> json) {
    return EventerVenue(
      term: json['term'],
      venueImage: json['venue_image'] ?? '',
      venueAddress: json['venue_address'] ?? '',
      venueCoordinates: json['venue_coordinates'] ?? '',
    );
  }
}
