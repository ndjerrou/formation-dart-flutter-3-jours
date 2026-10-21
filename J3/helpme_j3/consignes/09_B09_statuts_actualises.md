# B09 - Voir les demandes et leurs statuts s’actualiser

## Objectif

Les informations affichées doivent suivre les créations et les décisions effectuées pendant l’utilisation, sans demander à l’utilisateur de se reconnecter pour voir le résultat.

## Avant de commencer

- B08 validé : les demandes distinctes sont correctement conservées.
- Commencer en mode local sur une seule instance de l’application.
- Le compte client peut créer des demandes ; le compte « prestataire » de démonstration reçoit celles de Gérard.
- Créer deux demandes pour Gérard avec des motifs reconnaissables, puis se connecter prestataire pour commencer l’essai.

## Processus pour reproduire le problème

1. Ouvrir « Mes demandes » avec le compte prestataire : le titre attendu est « Demandes reçues ».
2. Repérer une demande en attente et cliquer sur « Accepter ».
3. Rester sur cet écran : observer le statut et les actions sans changer d’onglet ni se déconnecter.
4. Repérer l’autre demande en attente et cliquer sur « Refuser ».
5. Observer de la même manière le résultat de ce refus.
6. Revenir ensuite au compte client et vérifier les deux décisions.
7. Créer une nouvelle demande et regarder si elle apparaît après l’envoi, sans reconnexion de contrôle.

## Ce que l’on observe dans la version de départ

Une demande ou son statut peuvent rester figés sur l’écran alors que l’action a été effectuée. Une reconnexion peut révéler le résultat, mais cette manipulation ne doit pas être nécessaire pour actualiser l’affichage courant.

## Résultat attendu

- Le prestataire voit immédiatement la décision qu’il vient de prendre.
- Une demande acceptée est affichée comme acceptée ; une demande refusée est affichée comme refusée.
- Les actions d’acceptation et de refus ne restent pas proposées sur une demande déjà traitée.
- Le client retrouve ces décisions et voit une nouvelle demande après son envoi.
- Une action sur une demande ne modifie pas une autre demande.

## Vérification : si je fais ceci, alors…

| Si je fais ceci… | Alors je dois observer… | Résultat |
| --- | --- | --- |
| J’accepte une demande en restant sur l’écran prestataire. | Son statut devient « Acceptée » sans reconnexion ni rafraîchissement manuel. | ☐ OK / ☐ KO / ☐ Bloqué |
| J’observe cette demande après acceptation. | Les actions permettant de l’accepter ou de la refuser ne sont plus proposées. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je refuse une autre demande en attente. | Cette seconde demande devient « Refusée » sans modifier la première. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je reviens ensuite au compte client. | Je retrouve les deux statuts correspondant aux décisions prises. | ☐ OK / ☐ KO / ☐ Bloqué |
| Comme client, j’envoie une nouvelle demande valide. | Elle apparaît dans « Mes demandes » à la fin de l’envoi, sans devoir me reconnecter. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je consulte les demandes avec le compte client. | Les actions réservées au prestataire ne sont pas proposées. | ☐ OK / ☐ KO / ☐ Bloqué |
| Avec Firebase préparé uniquement, un prestataire traite une demande pendant que le client garde sa session ouverte sur un autre appareil. | Le statut s’actualise chez le client sans rechargement manuel. | ☐ OK / ☐ KO / ☐ Bloqué |

## Quand considérer la fiche comme terminée ?

- [ ] L’acceptation et le refus sont visibles sur l’écran où l’action a été faite.
- [ ] La création côté client est visible sans reconnexion.
- [ ] Le dernier contrôle n’est validé qu’avec Firebase préparé : deux fenêtres du mode local ne constituent pas ce test.
- [ ] J’ai conservé une preuve avant/après du scénario et indiqué le support utilisé.
- [ ] J’ai refait le scénario de reproduction complet après ma modification.


---

[Revenir au parcours](README.md) · [Fiche précédente](08_B08_plusieurs_demandes.md) · [Fiche suivante](10_B10_notification_et_bonne_demande.md)
