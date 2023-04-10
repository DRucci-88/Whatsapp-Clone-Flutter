import 'package:flutter/material.dart';
import 'package:whatsapp_clone/colors.dart';

class BottomChatField extends StatefulWidget {
  const BottomChatField({
    super.key,
  });

  @override
  State<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends State<BottomChatField> {
  final _inputText = TextEditingController();
  late FocusNode _inputFocusNode;

  final _isShowSendButton = ValueNotifier<bool>(false);

  @override
  void initState() {
    /// Listener for switch send and mic button
    _inputText.addListener(() {
      debugPrint('input node');
      if (_inputText.text.isNotEmpty && _isShowSendButton.value == false) {
        _isShowSendButton.value = true;
      }
      if (_inputText.text.isEmpty && _isShowSendButton.value == true) {
        _isShowSendButton.value = false;
      }
    });
    _inputFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _inputText.dispose();
    _inputFocusNode.dispose();
    _isShowSendButton.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            focusNode: _inputFocusNode,
            controller: _inputText,
            decoration: InputDecoration(
              filled: true,
              fillColor: mobileChatBoxColor,
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: SizedBox(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.emoji_emotions,
                            color: Colors.grey),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.gif, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              suffixIcon: SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _isShowSendButton,
                      builder: (context, value, child) {
                        if (value == true) return Container();
                        return IconButton(
                          onPressed: () {},
                          icon:
                              const Icon(Icons.camera_alt, color: Colors.grey),
                        );
                      },
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.attach_file, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              hintText: 'Type a message',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              contentPadding: const EdgeInsets.all(10),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: 8,
            right: 2,
            left: 2,
          ),
          child: ValueListenableBuilder(
            valueListenable: _isShowSendButton,
            builder: (context, value, child) {
              return CircleAvatar(
                backgroundColor: const Color(0xFF128C7E),
                radius: 25,
                child: Icon(
                  value ? Icons.send : Icons.mic,
                  color: Colors.white,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
