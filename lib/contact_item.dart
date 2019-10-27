import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/contact.dart';

class ContactState extends State<ContactWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(CupertinoIcons.profile_circled, size: 50, color: Colors.cyan),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 4.0),
                  Text(
                    '${widget.contact.firstName} ${widget.contact.lastName}',
                    style: TextStyle(fontSize: 18.0, color: Colors.black87),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      widget.contact.phoneNumber,
                      style: TextStyle(fontSize: 14.0, color: Colors.black54),
                      maxLines: 1,
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
                onTap: () {
                  widget.onFavoritePressed(widget.contact);
                },
                child: Icon(CupertinoIcons.heart))
          ],
        ),
      ),
    );
  }
}

class ContactWidget extends StatefulWidget {
  const ContactWidget({this.contact, this.onPressed, this.onFavoritePressed});

  final Contact contact;
  final VoidCallback onPressed;
  final void Function(Contact) onFavoritePressed;

  @override
  State<StatefulWidget> createState() => ContactState();
}
