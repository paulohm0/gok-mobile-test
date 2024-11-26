import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserCardWidget extends StatelessWidget {
  final String image;
  final String username;
  final String handle;
  final String company;
  final String location;
  final int followers;
  final int following;

  const UserCardWidget({
    super.key,
    required this.image,
    required this.username,
    required this.handle,
    required this.company,
    required this.location,
    required this.followers,
    required this.following,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 24.0, right: 12.0, top: 32.0, bottom: 32.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                      radius: 32, backgroundImage: NetworkImage(image)),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  username,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(left: 8.0),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 16,
                                  ),
                                ),
                              ],
                            ),
                            Text('@$handle'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete,
                      size: 24,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Row(
                  children: [
                    Visibility(
                      visible: company.isNotEmpty,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.business_sharp,
                            size: 18,
                            color: Colors.grey,
                          ),
                          Text(
                            ' $company',
                            style: const TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Icon(
                        Icons.location_on,
                        size: 18,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      ' $location',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Icon(
                        FontAwesomeIcons.users,
                        size: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      '  $followers',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Icon(
                        FontAwesomeIcons.userCheck,
                        size: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      '  $following',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
