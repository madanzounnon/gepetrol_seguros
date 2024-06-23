import 'package:flutter/material.dart';

List storeList = [
  {
    "img":
        "https://images.unsplash.com/photo-1507914372368-b2b085b925a1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
    "name": "Châtelet - Les Halles, Paris",
    "open": 1,
    "category": "Actualité"
  },
  {
    "img":
        "https://images.unsplash.com/photo-1546213290-e1b492ab3eee?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
    "name": "Champs-Élysées, Paris",
    "open": 2,
    "category": "Médiath.."
  },
  {
    "img":
        "https://images.unsplash.com/photo-1555529771-7888783a18d3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
    "name": "Châtelet - Les Halles, Paris",
    "open": 1,
    "category": "Actualité"
  },
  {
    "img":
        "https://images.unsplash.com/photo-1507914372368-b2b085b925a1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
    "name": "Châtelet - Les Halles, Paris",
    "open": 3,
    "category": "News"
  },
  {
    "img":
        "https://images.unsplash.com/photo-1546213290-e1b492ab3eee?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
    "name": "Champs-Élysées, Paris",
    "open": 2,
    "category": "Médiath.."
  },
  {
    "img":
        "https://images.unsplash.com/photo-1555529771-7888783a18d3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
    "name": "Châtelet - Les Halles, Paris",
    "open": 3,
    "category": "News"
  },
  {
    "img":
        "https://images.unsplash.com/photo-1546213290-e1b492ab3eee?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
    "name": "Champs-Élysées, Paris",
    "open": 2,
    "category": "Médiath.."
  },
  {
    "img":
        "https://images.unsplash.com/photo-1555529771-7888783a18d3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
    "name": "Châtelet - Les Halles, Paris",
    "open": 1,
    "category": "Actualité"
  },
  {
    "img":
        "https://images.unsplash.com/photo-1507914372368-b2b085b925a1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
    "name": "Châtelet - Les Halles, Paris",
    "open": 3,
    "category": "News"
  },
  {
    "img":
        "https://images.unsplash.com/photo-1546213290-e1b492ab3eee?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
    "name": "Champs-Élysées, Paris",
    "open": 2,
    "category": "Médiath.."
  },
  {
    "img":
        "https://images.unsplash.com/photo-1555529771-7888783a18d3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
    "name": "Châtelet - Les Halles, Paris",
    "open": 1,
    "category": "Actualité"
  },
  {
    "img":
        "https://images.unsplash.com/photo-1507914372368-b2b085b925a1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60",
    "name": "Châtelet - Les Halles, Paris",
    "open": 3,
    "category": "News"
  },
];

List accountList = [
  {"nom": "Information personnelles", "route": '/information'},
  //{"nom": "Moyens de paiement", "route": '/moyen_paiment'},
  {"nom": "Sécurité", "route": '/securite'},
  {"nom": "Langue", "route": '/'},
  {"nom": "Nous contacter", "route": '/contacts'},
  {"nom": "A propos de nous", "route": '/apropos'},
];
List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("EPARGNE ACTION"), value: "EPARGNE ACTION"),
    DropdownMenuItem(child: Text("CAPITAL SÛR"), value: "CAPITAL SÛR"),
    DropdownMenuItem(
        child: Text("EPARGNE CROISSANCE"), value: "EPARGNE CROISSANCE"),
    DropdownMenuItem(child: Text("OBLIGATIS"), value: "OBLIGATIS"),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get civiliteItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Monsieur"), value: "M."),
    DropdownMenuItem(child: Text("Madame"), value: "Mme"),
    DropdownMenuItem(child: Text("Mademoiselle"), value: "Mdme"),
  ];
  return menuItems;
}

List<DropdownMenuItem<String>> get typepieceItems {
  List<DropdownMenuItem<String>> menuItem = [
    DropdownMenuItem(child: Text("CIP"), value: "CIP."),
    DropdownMenuItem(
        child: Text("Pièce d'identité national"),
        value: "Pièce d'identité national"),
    DropdownMenuItem(
        child: Text("Carte Biométrique"), value: "Carte Biométrique"),
    DropdownMenuItem(child: Text("Passport"), value: "Passport"),
  ];
  return menuItem;
}

const String profileUrl =
    "https://images.unsplash.com/photo-1616597082843-de7ce757d548?ixid=MXwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw0N3x8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=60";
