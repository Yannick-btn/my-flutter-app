import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/components/chat_bubble.dart';
import 'package:flutterapp/services/auth.dart';
import 'package:flutterapp/services/chat.dart';
import 'package:flutterapp/shared/textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Page de chat permettant d'envoyer et de recevoir des messages en temps réel via Firebase.
class ChatPage extends StatefulWidget {
  final String receiverEmail; // Email du destinataire du chat
  final String receiverID; // Identifiant unique du destinataire dans Firestore
  final String receiverName;

  const ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverID,
    required this.receiverName,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // Contrôleur pour récupérer le texte du champ de saisie
  final TextEditingController _messageController = TextEditingController();

  // Services pour la gestion des messages et de l'authentification
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  /// Fonction pour envoyer un message
  void sendMessage() async {
    // Vérifie si l'utilisateur a tapé un message avant d'envoyer
    if (_messageController.text.isNotEmpty) {
      // Envoie le message via le service de chat
      await _chatService.sendMessage(
          widget.receiverID, _messageController.text);
      // Vide le champ de saisie après l'envoi
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.receiverName), // Affiche l'email du destinataire en titre
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(), // Affiche la liste des messages
          ),
          _buildUserInput(), // Affiche la zone de saisie et le bouton d'envoi
        ],
      ),
    );
  }

  /// Affiche la liste des messages échangés entre l'utilisateur actuel et le destinataire
  Widget _buildMessageList() {
    final User? currentUser = _authService.getCurrentUser();

    // Vérifie si l'utilisateur est connecté
    if (currentUser == null) {
      return const Center(child: Text('Utilisateur non connecté'));
    }

    String senderID = currentUser.uid; // Récupère l'ID de l'utilisateur actuel
    Stream<QuerySnapshot> messagesStream =
        _chatService.getMessages(senderID, widget.receiverID);

    return StreamBuilder<QuerySnapshot>(
      stream:
          messagesStream, // Écoute en temps réel les messages depuis Firestore
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Erreur de chargement des messages');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Chargement...');
        }
        if (snapshot.data!.docs.isEmpty) {
          return const Text('Aucun message disponible');
        }

        // Affiche chaque message sous forme d'un widget personnalisé
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  /// Construit un élément de la liste de messages
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // Vérifie si l'utilisateur actuel est l'expéditeur du message
    bool isCurrentUser = data['senderID'] == _authService.getCurrentUser()!.uid;

    // Définit l'alignement du message en fonction de l'expéditeur
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment, // Aligne à droite ou à gauche selon l'expéditeur
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(
            message: data['message'], // Affiche le texte du message
            isCurrentUser:
                isCurrentUser, // Détermine le style de la bulle de chat
          ),
        ],
      ),
    );
  }

  /// Affiche la zone de saisie pour taper un message avec un bouton d'envoi
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: Row(
        children: [
          Expanded(
            child: MyTextField(
              controller:
                  _messageController, // Contrôleur pour récupérer le texte saisi
              hintText: "Type a message", // Texte indicatif
              obscureText: false, // Champ non masqué
            ),
          ),
          // Bouton d'envoi du message
          Container(
            decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.primary, // Couleur du bouton
                shape: BoxShape.rectangle),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
              onPressed: sendMessage, // Appelle `sendMessage` lorsqu'on clique
              icon: const Icon(Icons.send),
              color:
                  Theme.of(context).colorScheme.secondary, // Couleur de l'icône
            ),
          ),
        ],
      ),
    );
  }
}
