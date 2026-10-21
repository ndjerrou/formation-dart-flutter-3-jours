# B06 - Sortir proprement d’un échec de chargement

## Objectif

Quand le catalogue distant ne peut pas être chargé, l’utilisateur doit comprendre ce qui se passe et pouvoir effectuer une nouvelle tentative.

## Avant de commencer

- B01 à B04 validés.
- Utiliser le lancement réseau décrit dans le parcours général ; le lancement habituel avec le catalogue embarqué ne reproduit pas ce scénario.
- Le service de test doit être préparé sur le même poste. Le professeur fournit un état « indisponible » qui refuse la demande de catalogue.
- Utiliser une session privée ou une nouvelle origine de test sans catalogue précédemment enregistré. Dans cette fiche, l’absence de données déjà disponibles fait partie des conditions du test.

## Processus pour reproduire le problème

1. Faire confirmer que le service est dans son état « indisponible ».
2. Ouvrir l’application dans la session de test sans ancien catalogue.
3. Observer l’indication de chargement jusqu’à la réponse ou jusqu’à dix secondes.
4. Noter si une explication remplace l’attente et si une nouvelle tentative est proposée.
5. Relancer la tentative en gardant le service indisponible.
6. Vérifier que l’écran reste utilisable et ne laisse pas croire que le catalogue est vide.

## Ce que l’on observe dans la version de départ

L’indication de chargement peut rester affichée alors que le service a échoué. L’utilisateur ne dispose pas d’un retour clair pour comprendre l’échec ou recommencer.

## Résultat attendu

- Sans catalogue déjà disponible, un échec remplace l’attente par un message compréhensible en dix secondes au maximum dans le scénario prévu.
- Une action de nouvelle tentative est disponible.
- Une nouvelle tentative peut échouer à nouveau sans bloquer l’écran définitivement.
- Le retour au catalogue après rétablissement complet du service est une vérification croisée avec B05.

## Vérification : si je fais ceci, alors…

| Si je fais ceci… | Alors je dois observer… | Résultat |
| --- | --- | --- |
| Je charge le catalogue sans données locales et avec le service indisponible. | L’attente est remplacée par une explication en dix secondes au maximum. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je lis cet écran d’échec. | Je comprends qu’il s’agit d’un problème de chargement, pas d’une absence d’artisans. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je choisis « Réessayer » pendant la panne. | Une tentative est faite puis l’échec est de nouveau expliqué ; je ne reste pas en attente indéfiniment. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je répète cette tentative. | L’action reste utilisable et l’écran garde un état compréhensible. | ☐ OK / ☐ KO / ☐ Bloqué |
| Après validation de B05, je rétablis le service puis je choisis « Réessayer ». | Le catalogue s’affiche sans redémarrer l’application. | ☐ OK / ☐ KO / ☐ Bloqué |
| Après validation de B05, j’ai déjà un catalogue conservé puis le service tombe en panne. | Si les données locales sont affichées, leur origine locale est clairement signalée. | ☐ OK / ☐ KO / ☐ Bloqué |

## Quand considérer la fiche comme terminée ?

- [ ] L’échec sans données locales et les tentatives répétées ont été vérifiés.
- [ ] Les deux derniers contrôles sont notés « Bloqué par B05 » jusqu’à sa validation, puis rejoués.
- [ ] Un chargement interminable n’est plus le résultat d’une panne connue.
- [ ] J’ai conservé une preuve avant/après du scénario et indiqué le support utilisé.
- [ ] J’ai refait le scénario de reproduction complet après ma modification.


---

[Revenir au parcours](README.md) · [Fiche précédente](04_B04_coherence_des_favoris.md) · [Fiche suivante](06_B05_catalogue_depuis_le_service.md)
