
class Compteur {
  Compteur({
    this.dr,
    this.secteur,
    this.compteur,
    this.reglageDisjoncteur,
    this.situationGeographique,
    this.typeCompteur,
    this.coordonnees,
    this.nomAbonne, this.referenceContrat, this.referenceClient,
    this.tournee, this.agent, this.contact, this.contact_secondaire,
    this.prenomsAbonne, this.createdAt
  });

  String? dr;
  String? secteur, tournee, nomAbonne, prenomsAbonne;
  String? compteur, referenceClient, referenceContrat;
  String? reglageDisjoncteur, agent, contact, contact_secondaire;
  String? situationGeographique;
  String? typeCompteur;
  Coordonnees? coordonnees;
  DateTime? createdAt;

  factory Compteur.fromJson(Map<String, dynamic> json) => Compteur(
    dr: json["dr"],
    secteur: json["secteur"],
    compteur: json["compteur"],
    reglageDisjoncteur: json["reglage_disjoncteur"],
    situationGeographique: json["situation_geographique"],
    typeCompteur: json["type_compteur"],
    coordonnees: json["coordonnees"] == null ? null : Coordonnees.fromJson(json["coordonnees"]),
  );

  Map<String, dynamic> toJson() => {
    "dr": dr,
    "secteur": secteur,
    "tournee": tournee,
    "reference_client": referenceClient,
    "reference_contrat": referenceContrat,
    "nom_abonne": nomAbonne,
    "prenoms_abonne": prenomsAbonne,
    "contact": contact,
    "contact_secondaire": contact_secondaire,
    "compteur": compteur,
    "reglage_disjoncteur": reglageDisjoncteur,
    "situation_geographique": situationGeographique,
    "type_compteur": typeCompteur,
    "coordonnees": coordonnees?.toJson(),
    "agent": agent,
    "created_at": createdAt!.toIso8601String()
  };
}

class Coordonnees {
  Coordonnees({
    this.longitude,
    this.latitude,
  });

  String? longitude;
  String? latitude;

  factory Coordonnees.fromJson(Map<String, dynamic> json) => Coordonnees(
    longitude: json["longitude"],
    latitude: json["latitude"],
  );

  Map<String, dynamic> toJson() => {
    "longitude": longitude,
    "latitude": latitude,
  };
}
