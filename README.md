  # CSI 6th Project

## Contenuti:
* [1. mu-analysis](#1-mu-analysis)
* [2. Incertezze](#2-incertezze)
* [3. LTR](#3-ltr)
* [4. Risposta al gradino](#4-risposta-al-gradino)
* [5. File aggiuntivi](#5-file-aggiuntivi)
* [6. Bozze e test](#6-bozze-e-test)

Nota: Si presuppone che si sia data un'occhiata al capitolo 19 del Mackenroth.
Spiegazione dettagliata nel file Live Script: `Relazione_CSI.mlx` [trovi il file qui!](https://github.com/Elektron97/CSI-6th-Project/blob/main/Relazione_CSI.mlx)

## 1) mu-analysis
  Stesso codice del capitolo 19 del Mackenroth.

## 2) Incertezze
  Il file che gestisce le incertezze è `unstr_unc.m`. Non è necessario eseguirlo, in quanto verrà eseguito da `LTR.m`.

## 3) LTR
  Lo script `LTR.m` si occupa della sintesi del controllore LTR. Esegue a sua volta lo script delle incertezze che a sua volta esegue lo script `mod_robot.m`, 
  proveniente dal libro.
  Per valutare la Robusta prestazione e la Robusta stabilità, bisogna eseguire lo script `mu_ltr.m` (**dopo** `LTR.m`).
  
## 4) Risposta al gradino
  Per vedere la risposta al gradino, è necessario eseguire **dopo** `LTR.m`, `time_ltr.m`. Questo plotterà la risposta al gradino per varie realizzazioni dell'incertezza
  strutturata del sistema.

## 5) File aggiuntivi
  Oltre questi 3 fondamentali, ci sono altri file che emulano gli scripts sulla valutazione delle prestazioni con il controllore LTR sintetizzato. Possono essere scartati o  cancellati se non interessano.

## 6) Bozze e test
  Altri file come `unstr2.m` e in generale i file con suffisso "-2" sono bozze, in cui si considerano le realizzazioni di tutte e 2 le incertezze presenti nel sistema.
  Come dice l'articolo, la seconda incertezza è meno determinante ed è lecito considerarla costante.
