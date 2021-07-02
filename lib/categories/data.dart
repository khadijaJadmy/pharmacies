// To parse this JSON data, do
//
//     final items = itemsFromJson(jsonString);

import 'dart:convert';

List<Items> itemsFromJson(String str) =>
    List<Items>.from(json.decode(str).map((x) => Items.fromJson(x)));

String itemsToJson(List<Items> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Items {
  Items({
    this.code,
    this.nom,
    this.dci1,
    this.dosage1,
    this.uniteDosage1,
    this.forme,
    this.presentation,
    this.ppv,
    this.ph,
    this.prixBr,
    this.princepsGenerique,
    this.tauxRemboursement,
  });

  String code;
  String nom;
  String dci1;
  String dosage1;
  UniteDosage1 uniteDosage1;
  String forme;
  String presentation;
  String ppv;
  String ph;
  String prixBr;
  PrincepsGenerique princepsGenerique;
  TauxRemboursement tauxRemboursement;

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        code: json["CODE"],
        nom: json["NOM"],
        dci1: json["DCI1"],
        dosage1: json["DOSAGE1"] == null ? null : json["DOSAGE1"],
        uniteDosage1: uniteDosage1Values.map[json["UNITE_DOSAGE1"]],
        forme: json["FORME"],
        presentation: json["PRESENTATION"],
        ppv: json["PPV"],
        ph: json["PH"],
        prixBr: json["PRIX_BR"],
        princepsGenerique:
            princepsGeneriqueValues.map[json["PRINCEPS_GENERIQUE"]],
        tauxRemboursement:
            tauxRemboursementValues.map[json["TAUX_REMBOURSEMENT"]],
      );

  Map<String, dynamic> toJson() => {
        "CODE": code,
        "NOM": nom,
        "DCI1": dci1,
        "DOSAGE1": dosage1 == null ? null : dosage1,
        "UNITE_DOSAGE1": uniteDosage1Values.reverse[uniteDosage1],
        "FORME": forme,
        "PRESENTATION": presentation,
        "PPV": ppv,
        "PH": ph,
        "PRIX_BR": prixBr,
        "PRINCEPS_GENERIQUE":
            princepsGeneriqueValues.reverse[princepsGenerique],
        "TAUX_REMBOURSEMENT":
            tauxRemboursementValues.reverse[tauxRemboursement],
      };
}

enum PrincepsGenerique { P, G }

final princepsGeneriqueValues =
    EnumValues({"G": PrincepsGenerique.G, "P": PrincepsGenerique.P});

enum TauxRemboursement { THE_0, THE_70 }

final tauxRemboursementValues = EnumValues(
    {"0%": TauxRemboursement.THE_0, "70%": TauxRemboursement.THE_70});

enum UniteDosage1 {
  ML,
  MG,
  G,
  MG_MG,
  UNITE_DOSAGE1_G,
  G_G,
  EMPTY,
  UI,
  MUI_MG,
  UI_ANTI_XA,
  MUI,
  MG_UI,
  G_MG,
  MG_MG_MG,
  NA,
  UNITE_DOSAGE1_G_G,
  MG_ML,
  MG_G,
  NA_NA,
  UNITE_DOSAGE1,
  MG_100_ML,
  G_100_G,
  MUI_MUI_MUI_MG,
  UI_075_ML,
  MG_MUI,
  G_200_ML,
  U_CEIP,
  MG_5_ML,
  G_05_ML,
  UI_15_ML,
  MUI_MUI,
  MG_NA_NA,
  G_100_ML,
  UNITE_DOSAGE1_NA,
  MG_2_ML,
  UI_UI_UI,
  MG_MG_G,
  UNITE_DOSAGE1_G_MG,
  G_UI,
  G_H,
  UI_MG,
  ML_G_G,
  MG_20_ML,
  G_G_G,
  UI_G,
  UNITE_DOSAGE1_MG_G,
  G_MG_MG,
  MG_NA,
  G_2_ML,
  MMOLE,
  MG_1_MG,
  MG_4_ML,
  MG_04_ML,
  MG_10_ML,
  G_5_ML,
  G_ML,
  UI_05_ML,
  MG_137_ML,
  MG_MG_MG_MG,
  PURPLE_G_G,
  UNITE_DOSAGE1_G_100_G,
  U_A_T_EE_G,
  PURPLE_G,
  MG_G_UI,
  MG_G_G,
  UNITE_DOSAGE1_UI,
  UI_ML,
  UNITES_ALLERGAN,
  UAH,
  ML_MG,
  UI_UI,
  MEQ
}

final uniteDosage1Values = EnumValues({
  "%": UniteDosage1.EMPTY,
  "G": UniteDosage1.G,
  "µG/0.5 ML": UniteDosage1.G_05_ML,
  "% / G/100G": UniteDosage1.G_100_G,
  "G/100ML": UniteDosage1.G_100_ML,
  "G/200ML": UniteDosage1.G_200_ML,
  "G/2ML": UniteDosage1.G_2_ML,
  "G/5ml": UniteDosage1.G_5_ML,
  "G / G": UniteDosage1.G_G,
  "G / G / G": UniteDosage1.G_G_G,
  "µG/H": UniteDosage1.G_H,
  "G / MG": UniteDosage1.G_MG,
  "G / MG / MG": UniteDosage1.G_MG_MG,
  "µG/ML": UniteDosage1.G_ML,
  "G / UI": UniteDosage1.G_UI,
  "MEQ": UniteDosage1.MEQ,
  "MG": UniteDosage1.MG,
  "MG/0.4ML": UniteDosage1.MG_04_ML,
  "MG/100ML": UniteDosage1.MG_100_ML,
  "MG/10ML": UniteDosage1.MG_10_ML,
  "MG/1,37 ML": UniteDosage1.MG_137_ML,
  "MG/1MG": UniteDosage1.MG_1_MG,
  "MG/20ML": UniteDosage1.MG_20_ML,
  "MG/2ML": UniteDosage1.MG_2_ML,
  "MG/4ML": UniteDosage1.MG_4_ML,
  "MG/5ML": UniteDosage1.MG_5_ML,
  "MG / G": UniteDosage1.MG_G,
  "MG / G / G": UniteDosage1.MG_G_G,
  "MG / G / UI": UniteDosage1.MG_G_UI,
  "MG / MG": UniteDosage1.MG_MG,
  "MG / MG / G": UniteDosage1.MG_MG_G,
  "MG / MG / MG": UniteDosage1.MG_MG_MG,
  "MG / MG / MG / MG": UniteDosage1.MG_MG_MG_MG,
  "MG/ML": UniteDosage1.MG_ML,
  "MG / MUI": UniteDosage1.MG_MUI,
  "MG / NA": UniteDosage1.MG_NA,
  "MG / NA / NA": UniteDosage1.MG_NA_NA,
  "MG / UI": UniteDosage1.MG_UI,
  "ML": UniteDosage1.ML,
  "ML / G / G": UniteDosage1.ML_G_G,
  "ML / MG": UniteDosage1.ML_MG,
  "MMOLE": UniteDosage1.MMOLE,
  "MUI": UniteDosage1.MUI,
  "MUI / MG": UniteDosage1.MUI_MG,
  "MUI / MUI": UniteDosage1.MUI_MUI,
  "MUI / MUI / MUI / MG": UniteDosage1.MUI_MUI_MUI_MG,
  "NA": UniteDosage1.NA,
  "NA / NA": UniteDosage1.NA_NA,
  "% / G": UniteDosage1.PURPLE_G,
  "µG/G": UniteDosage1.PURPLE_G_G,
  "UAH": UniteDosage1.UAH,
  "UI": UniteDosage1.UI,
  "UI/0.5 ML": UniteDosage1.UI_05_ML,
  "UI/0.75 ML": UniteDosage1.UI_075_ML,
  "UI/1.5 ML": UniteDosage1.UI_15_ML,
  "UI ANTI-XA": UniteDosage1.UI_ANTI_XA,
  "UI / G": UniteDosage1.UI_G,
  "UI / MG": UniteDosage1.UI_MG,
  "UI / ML": UniteDosage1.UI_ML,
  "UI / UI": UniteDosage1.UI_UI,
  "UI / UI / UI": UniteDosage1.UI_UI_UI,
  "UNITES ALLERGAN": UniteDosage1.UNITES_ALLERGAN,
  "% / %": UniteDosage1.UNITE_DOSAGE1,
  "µG": UniteDosage1.UNITE_DOSAGE1_G,
  "G/100G": UniteDosage1.UNITE_DOSAGE1_G_100_G,
  "µG / µG": UniteDosage1.UNITE_DOSAGE1_G_G,
  "µG / MG": UniteDosage1.UNITE_DOSAGE1_G_MG,
  "MG / µG": UniteDosage1.UNITE_DOSAGE1_MG_G,
  "NA / %": UniteDosage1.UNITE_DOSAGE1_NA,
  "% / UI": UniteDosage1.UNITE_DOSAGE1_UI,
  "U.A.T.EE / G": UniteDosage1.U_A_T_EE_G,
  "U CEIP": UniteDosage1.U_CEIP
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
