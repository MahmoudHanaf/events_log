import 'package:charging_station/screens/drawer_screens/collabrations/collabrations_screen.dart';
import 'package:charging_station/screens/drawer_screens/events/events_screen.dart';
import 'package:charging_station/screens/drawer_screens/submit_event/submit_event.dart';
import 'package:charging_station/screens/faq_screen/faq_screen.dart';
import 'package:flutter/material.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Drawer(
      width: size.width * .75,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(0),
          bottomRight: Radius.circular(0),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.zero,
            ),
            child: Column(
              children: [
                SizedBox(height: size.height * .05),
                //  Image.asset(Assets.logo),
                SizedBox(height: size.height * .01),
                Center(
                  child: Text(
                    "Events Log",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * .05),
          GestureDetector(
            onTap: () async {
              Navigator.pop(context);
            },
            child: ListTile(
              leading: Icon(Icons.home, size: 25, color: Colors.grey[500]),
              title: Text(
                "Home",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ),
          Divider(height: 3, color: Colors.grey[400]),

          GestureDetector(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventsScreen()),
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.event_note_sharp,
                size: 25,
                color: Colors.grey[500],
              ),
              title: Text(
                "Events",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ),
          Divider(height: 3, color: Colors.grey[400]),
          GestureDetector(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SubmitEventScreen()),
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.event_available_rounded,
                size: 25,
                color: Colors.grey[500],
              ),
              title: Text(
                "Submit Event",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ),
          Divider(height: 3, color: Colors.grey[400]),
          // SizedBox(height: 5),
          GestureDetector(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CollaborationsScreen()),
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.collections_bookmark,
                size: 25,
                color: Colors.grey[500],
              ),
              title: Text(
                "Collabrations",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ),
          Divider(height: 3, color: Colors.grey[400]),
          GestureDetector(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FAQScreen()),
              );
            },
            child: ListTile(
              leading: Icon(
                Icons.question_answer,
                size: 25,
                color: Colors.grey[500],
              ),
              title: Text(
                "FAQ",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ),

          Divider(height: 3, color: Colors.grey[400]),
          GestureDetector(
            onTap: () async {},
            child: ListTile(
              leading: Icon(Icons.logout, size: 25, color: Colors.grey[500]),
              title: Text(
                "Logout",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
            ),
          ),
          Divider(height: 3, color: Colors.grey[400]),
        ],
      ),
    );
  }
}
