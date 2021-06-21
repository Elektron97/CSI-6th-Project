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
  
## 4) Risposta al gradino
  Per vedere la risposta al gradino, è necessario eseguire **dopo** `LTR.m`, `time_ltr.m`. Questo plotterà la risposta al gradino per varie realizzazioni dell'incertezza
  strutturata del sistema.

## 5) File aggiuntivi

## 6) Bozze e test
