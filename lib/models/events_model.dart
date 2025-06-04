// models/event_model.dart

class EventModel {
  final int id;
  final String title;
  final String date;
  final String slug;
  final String link;
  final String content;
  final String excerpt;
  final String status;
  final int featuredMedia;
  final Organizer organizer;
  final Venue venue;

  EventModel({
    required this.id,
    required this.title,
    required this.date,
    required this.slug,
    required this.link,
    required this.content,
    required this.excerpt,
    required this.status,
    required this.featuredMedia,
    required this.organizer,
    required this.venue,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      title: json['title']['rendered'],
      date: json['date'],
      slug: json['slug'],
      link: json['link'],
      content: json['content']['rendered'],
      excerpt: json['excerpt']['rendered'],
      status: json['status'],
      featuredMedia: json['featured_media'],
      organizer: Organizer.fromJson(json['eventer_organizer']),
      venue: Venue.fromJson(json['eventer_venue']),
    );
  }
}

class Organizer {
  final String name;
  final String phone;
  final String email;
  final String website;
  final String imageId;

  Organizer({
    required this.name,
    required this.phone,
    required this.email,
    required this.website,
    required this.imageId,
  });

  factory Organizer.fromJson(Map<String, dynamic> json) {
    return Organizer(
      name: json['term'] ?? '',
      phone: json['organizer_phone'] ?? '',
      email: json['organizer_email']?.trim() ?? '',
      website: json['organizer_website'] ?? '',
      imageId: json['organizer_image'] ?? '',
    );
  }
}

class Venue {
  final String name;
  final String address;
  final String coordinates;

  Venue({required this.name, required this.address, required this.coordinates});

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(
      name: json['term'] ?? '',
      address: json['venue_address'] ?? '',
      coordinates: json['venue_coordinates'] ?? '',
    );
  }
}
