# B05 - Afficher les informations fournies par le service

## Objectif

Quand le service de catalogue répond correctement, l’application doit afficher ses artisans avec les bonnes informations.

## Avant de commencer

- B06 traité pour les scénarios d’erreur : un échec est maintenant visible.
- Garder le lancement réseau et la session de test prévus dans le parcours général.
- Le professeur a remis le service en état « disponible » et confirmé que sa réponse contient bien les six artisans de démonstration.
- Commencer sans ancien catalogue local pour vérifier cette réponse, plutôt qu’un résultat conservé lors d’un essai précédent.

## Processus pour reproduire le problème

1. Faire confirmer la disponibilité du service de test et de ses données.
2. Ouvrir l’application avec la connexion au catalogue distant, ou choisir « Réessayer » sur l’écran d’échec.
3. Observer si les six artisans apparaissent.
4. Comparer les informations de Gérard, Sophie et Pierre avec les valeurs de référence ci-dessous.
5. Ouvrir les fiches de Gérard et Sophie pour vérifier la continuité des informations.
6. Actualiser le catalogue puis vérifier à nouveau les résultats.

## Ce que l’on observe dans la version de départ

Le service peut répondre normalement tandis que l’application n’affiche pas le catalogue attendu. Après B06, cela peut se traduire par un message d’échec malgré la disponibilité confirmée du service.

## Résultat attendu

- Les six artisans sont affichés lors d’une réponse correcte.
- Les informations sont fidèles : Gérard / Plomberie / 65 €, Sophie / Électricité / 80 €, Pierre / Carrelage / 95 € par heure.
- Les accents et les caractères des noms et métiers sont lisibles.
- Les cartes et les fiches présentent les mêmes informations.
- L’utilisateur peut distinguer un catalogue obtenu par le réseau d’un catalogue conservé localement.

## Vérification : si je fais ceci, alors…

| Si je fais ceci… | Alors je dois observer… | Résultat |
| --- | --- | --- |
| Je charge depuis le service disponible, sans ancien catalogue. | Je vois six artisans, sans message d’échec ni attente permanente. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je lis les cartes de Gérard, Sophie et Pierre. | Les noms, métiers et tarifs correspondent aux valeurs de référence. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je lis « Gérard » et « Électricité ». | Les accents sont corrects, sans caractères de remplacement. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je recherche Sophie puis j’ouvre sa fiche. | Je retrouve Sophie, Électricité et 80 € par heure. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je rafraîchis avec un service toujours disponible. | Le catalogue reste correct et le chargement se termine. | ☐ OK / ☐ KO / ☐ Bloqué |
| Après un chargement réussi, le service devient indisponible et j’actualise. | Si un catalogue local est conservé, il reste lisible et son origine locale est indiquée. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je reprends le contrôle de reprise différé dans B06. | Une panne puis un retour du service peuvent être gérés sans redémarrage de l’application. | ☐ OK / ☐ KO / ☐ Bloqué |

## Quand considérer la fiche comme terminée ?

- [ ] Un chargement sans ancien catalogue a réussi.
- [ ] Les valeurs de référence ont été comparées sur les cartes et les fiches.
- [ ] Les contrôles différés de B06 ont été rejoués.
- [ ] J’ai conservé une preuve avant/après du scénario et indiqué le support utilisé.
- [ ] J’ai refait le scénario de reproduction complet après ma modification.


---

[Revenir au parcours](README.md) · [Fiche précédente](05_B06_erreur_et_nouvelle_tentative.md) · [Fiche suivante](07_B07_favoris_apres_relance.md)
