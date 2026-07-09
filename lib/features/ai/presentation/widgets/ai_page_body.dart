import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../cubit/ai_chat/ai_chat_cubit.dart';
import '../cubit/ai_chat/ai_chat_state.dart';
import 'ai_advisor_banner.dart';
import 'ai_chat_bubble.dart';
import 'ai_input_area.dart';

class AiMessage {
  final String text;
  final bool isUser;

  AiMessage({required this.text, required this.isUser});
}

class AiPageBody extends StatefulWidget {
  const AiPageBody({super.key});

  @override
  State<AiPageBody> createState() => _AiPageBodyState();
}

class _AiPageBodyState extends State<AiPageBody> {
  final List<AiMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage(String text) {
    setState(() {
      _messages.add(AiMessage(text: text, isUser: true));
    });
    _scrollToBottom();
    context.read<AiChatCubit>().sendMessage(text);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AiChatCubit, AiChatState>(
      listener: (context, state) {
        if (state is AiChatSuccess) {
          setState(() {
            _messages.add(
                AiMessage(text: state.response.response, isUser: false));
          });
          _scrollToBottom();
        } else if (state is AiChatError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.failure.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Column(
        children: [
          const AiAdvisorBanner(),
          Expanded(
            child: BlocBuilder<AiChatCubit, AiChatState>(
              builder: (context, state) {
                final isLoading = state is AiChatLoading;
                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                  itemCount: _messages.length + (isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (isLoading && index == _messages.length) {
                      return const Skeletonizer(
                        enabled: true,
                        child: AiChatBubble(
                          text: 'Thinking...\nGenerating a detailed business response for you.',
                          isUser: false,
                        ),
                      );
                    }
                    final message = _messages[index];
                    return AiChatBubble(
                      text: message.text,
                      isUser: message.isUser,
                    );
                  },
                );
              },
            ),
          ),
          BlocBuilder<AiChatCubit, AiChatState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AiInputArea(
                    onSend: _sendMessage,
                    isLoading: state is AiChatLoading,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
