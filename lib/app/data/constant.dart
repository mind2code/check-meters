import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

HexColor primaryColor = HexColor("#f37735");

//keycloak config

// String client_id = "cmeter-mobile";

String realm = "meterschecker";
String client_id = "mobile-recette";

String keycloakUrl = "https://iamsso.univers.ci";
//String keycloakUrl = "https://auth.mind2codes.com";

String base_url = "http://10.10.158.55:8062";

int syncr = 1;
int non_syncr = 0;


List formBuilderData = [{"type":"select","required":true,"label":"Dr","className":"form-control","name":"directio_regionale","access":false,"multiple":false,"values":[{"label":"33","value":"33","selected":true},{"label":"34","value":"34","selected":false},{"label":"35","value":"35","selected":false}]},{"type":"select","required":true,"label":"Secteur","className":"form-control","name":"secteur","access":false,"multiple":false,"values":[{"label":"Secteur 1","value":"secteur_1","selected":true},{"label":"Secteur 2","value":"secteur_2","selected":false}]},{"type":"number","required":false,"label":"Numéro compteur","className":"form-control","name":"numero_compteur","access":false},{"type":"select","required":true,"label":"Réglage disjoncteur","className":"form-control","name":"reglage_disjoncteur","access":false,"multiple":false,"values":[{"label":"15A","value":"15A","selected":true},{"label":"10A","value":"10A","selected":false},{"label":"5A","value":"5A","selected":false}]},{"type":"select","required":false,"label":"Type compteur","className":"form-control","name":"select-1678701338995-0","access":false,"multiple":false,"values":[{"label":"Prepaid","value":"prepaid","selected":true},{"label":"Postpaid","value":"postpaid","selected":false}]},{"type":"text","required":false,"label":"Situation géographique","className":"form-control","name":"situation_geographique","access":false,"subtype":"text"}];