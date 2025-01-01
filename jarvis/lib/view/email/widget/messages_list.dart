import 'package:flutter/material.dart';
import 'package:jarvis/view_model/email_view_model.dart';
import 'package:provider/provider.dart';

import '../../../constant.dart';

class MessagesList extends StatelessWidget {
  final bool isLargeScreen;

  MessagesList({super.key, required this.isLargeScreen});

  @override
  Widget build(BuildContext context) {
    final emailViewModel = Provider.of<EmailViewModel>(context);
    final messages = emailViewModel.conversationMessages ?? [];

    TextEditingController emailController = TextEditingController();
    if (emailViewModel.email != " ") {
      emailController.text = emailViewModel.email;
    }
    FocusNode emailFocusNode = FocusNode(); // Create a FocusNode

    // Add listener to update when focus is lost
    emailFocusNode.addListener(() {
      if (!emailFocusNode.hasFocus) {
        // The TextField lost focus, update the view model
        emailViewModel.updateEmail(emailController.text);
      }
    });

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: messages.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey[300]!,
                ),
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200]),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Received email",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                ),
                const Divider(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: TextField(
                        controller: emailController, // Use the controller
                        decoration: const InputDecoration(
                          hintText: "Enter your email",
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 8,
                        focusNode: emailFocusNode, // Assign the FocusNode
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        final message = messages[index - 1];
        return Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[300]!,
              ),
              borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                    text: TextSpan(children: <TextSpan>[
                  const TextSpan(
                      text: "Jarvis reply: ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue)),
                  TextSpan(
                    text: "\"${message.query}\"",
                    style: const TextStyle(color: Colors.lightBlue),
                  ),
                ])),
              ),
              const Divider(),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      message.answer,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
