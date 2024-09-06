import 'package:flutter/material.dart';

class SupportTicketViewModel extends ChangeNotifier {
  late BuildContext context;

  var ticketList = [
    {
      "ticketName":"Lorem Ipsum Doler Sit Amet",
      "ticketDescription":"Lorem ipsum dolor sit amet, consectetur adipiscing Lorem ipsum dolor sit amet, consectetur adipiscing",
      "ticketDate":"01 September, 2024",
      "ticketStatus":"New"
    },
    {
      "ticketName":"Lorem Ipsum Doler Sit Amet",
      "ticketDescription":"Lorem ipsum dolor sit amet, consectetur adipiscing Lorem ipsum dolor sit amet, consectetur adipiscing",
      "ticketDate":"01 September, 2024",
      "ticketStatus":"InProgress"
    },
    {
      "ticketName":"Lorem Ipsum Doler Sit Amet",
      "ticketDescription":"Lorem ipsum dolor sit amet, consectetur adipiscing Lorem ipsum dolor sit amet, consectetur adipiscing",
      "ticketDate":"01 September, 2024",
      "ticketStatus":"Fixed"
    },
    {
      "ticketName":"Lorem Ipsum Doler Sit Amet",
      "ticketDescription":"Lorem ipsum dolor sit amet, consectetur adipiscing Lorem ipsum dolor sit amet, consectetur adipiscing",
      "ticketDate":"01 September, 2024",
      "ticketStatus":"Completed"
    },
    {
      "ticketName":"Lorem Ipsum Doler Sit Amet",
      "ticketDescription":"Lorem ipsum dolor sit amet, consectetur adipiscing Lorem ipsum dolor sit amet, consectetur adipiscing",
      "ticketDate":"01 September, 2024",
      "ticketStatus":"Re-Open"
    },
    {
      "ticketName":"Lorem Ipsum Doler Sit Amet",
      "ticketDescription":"Lorem ipsum dolor sit amet, consectetur adipiscing Lorem ipsum dolor sit amet, consectetur adipiscing",
      "ticketDate":"01 September, 2024",
      "ticketStatus":"Refunded"
    },
    {
      "ticketName":"Lorem Ipsum Doler Sit Amet",
      "ticketDescription":"Lorem ipsum dolor sit amet, consectetur adipiscing Lorem ipsum dolor sit amet, consectetur adipiscing",
      "ticketDate":"01 September, 2024",
      "ticketStatus":"New"
    },
    {
      "ticketName":"Lorem Ipsum Doler Sit Amet",
      "ticketDescription":"Lorem ipsum dolor sit amet, consectetur adipiscing Lorem ipsum dolor sit amet, consectetur adipiscing",
      "ticketDate":"01 September, 2024",
      "ticketStatus":"New"
    },
    {
      "ticketName":"Lorem Ipsum Doler Sit Amet",
      "ticketDescription":"Lorem ipsum dolor sit amet, consectetur adipiscing Lorem ipsum dolor sit amet, consectetur adipiscing",
      "ticketDate":"01 September, 2024",
      "ticketStatus":"New"
    },
    {
      "ticketName":"Lorem Ipsum Doler Sit Amet",
      "ticketDescription":"Lorem ipsum dolor sit amet, consectetur adipiscing Lorem ipsum dolor sit amet, consectetur adipiscing",
      "ticketDate":"01 September, 2024",
      "ticketStatus":"New"
    },
  ];

  init(BuildContext context) async {
    this.context = context;
    notifyListeners();
  }
}
