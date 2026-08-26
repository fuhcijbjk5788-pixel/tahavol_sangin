class ChatService {
  static final Map<String, List<Map<String, dynamic>>> _conversations = {};
  static final Map<String, List<Map<String, dynamic>>> _messages = {};

  // Send message
  static Future<Map<String, dynamic>> sendMessage({
    required String conversationId,
    required String senderId,
    required String senderName,
    required String messageText,
    String? imageUrl,
    Map<String, double>? location,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      final message = {
        'id': 'msg_${DateTime.now().millisecondsSinceEpoch}',
        'senderId': senderId,
        'senderName': senderName,
        'text': messageText,
        'imageUrl': imageUrl,
        'location': location,
        'timestamp': DateTime.now().toIso8601String(),
        'isRead': false,
        'status': 'delivered', // sent, delivered, read
      };

      if (!_messages.containsKey(conversationId)) {
        _messages[conversationId] = [];
      }

      _messages[conversationId]!.add(message);

      return {
        'success': true,
        'message': message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'خطا در ارسال پیام',
      };
    }
  }

  // Get conversation messages
  static Future<List<Map<String, dynamic>>> getMessages(
    String conversationId,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 200));

      return _messages[conversationId] ?? [];
    } catch (e) {
      return [];
    }
  }

  // Create conversation
  static Future<Map<String, dynamic>> createConversation({
    required String userId1,
    required String userName1,
    required String userId2,
    required String userName2,
    required String loadId,
  }) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));

      final conversationId =
          'conv_${DateTime.now().millisecondsSinceEpoch}';

      final conversation = {
        'id': conversationId,
        'participants': [
          {'id': userId1, 'name': userName1},
          {'id': userId2, 'name': userName2},
        ],
        'loadId': loadId,
        'lastMessage': '',
        'lastMessageTime': DateTime.now().toIso8601String(),
        'unreadCount': 0,
      };

      _conversations[conversationId] = [conversation];
      _messages[conversationId] = [];

      return {
        'success': true,
        'conversationId': conversationId,
        'conversation': conversation,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'خطا در ایجاد گفتگو',
      };
    }
  }

  // Get all conversations for user
  static Future<List<Map<String, dynamic>>> getUserConversations(
    String userId,
  ) async {
    try {
      await Future.delayed(const Duration(milliseconds: 200));

      final userConversations = <Map<String, dynamic>>[];

      _conversations.forEach((convId, convList) {
        for (var conv in convList) {
          final participants =
              List<Map<String, dynamic>>.from(conv['participants'] ?? []);
          if (participants.any((p) => p['id'] == userId)) {
            userConversations.add(conv);
          }
        }
      });

      return userConversations;
    } catch (e) {
      return [];
    }
  }

  // Mark messages as read
  static Future<void> markMessagesAsRead(
    String conversationId,
    String userId,
  ) async {
    try {
      final messages = _messages[conversationId] ?? [];
      for (var message in messages) {
        if (message['senderId'] != userId) {
          message['isRead'] = true;
          message['status'] = 'read';
        }
      }
    } catch (e) {
      // Handle error
    }
  }

  // Get unread count
  static Future<int> getUnreadCount(
    String conversationId,
    String userId,
  ) async {
    try {
      final messages = _messages[conversationId] ?? [];
      return messages
          .where((m) => m['senderId'] != userId && !m['isRead'])
          .length;
    } catch (e) {
      return 0;
    }
  }

  // Update last message
  static void updateLastMessage(
    String conversationId,
    String messageText,
  ) {
    try {
      _conversations[conversationId]?.forEach((conv) {
        conv['lastMessage'] = messageText;
        conv['lastMessageTime'] = DateTime.now().toIso8601String();
      });
    } catch (e) {
      // Handle error
    }
  }

  // Delete conversation
  static Future<bool> deleteConversation(String conversationId) async {
    try {
      await Future.delayed(const Duration(milliseconds: 200));
      _conversations.remove(conversationId);
      _messages.remove(conversationId);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Clear test data
  static void clearTestData() {
    _conversations.clear();
    _messages.clear();
  }
}
