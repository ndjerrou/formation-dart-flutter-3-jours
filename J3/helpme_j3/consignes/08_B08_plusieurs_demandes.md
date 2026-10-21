# B08 - Conserver plusieurs demandes distinctes

## Objectif

Chaque nouvelle demande doit rester consultable sans remplacer une demande déjà créée.

## Avant de commencer

- B01 à B07 traités.
- Utiliser le mode de démonstration locale et se connecter avec « Entrer comme client ». Les demandes ne sont pas envoyées à de vrais artisans.
- Compter les demandes déjà présentes : ce nombre sera appelé N.
- Pour cette fiche, se déconnecter puis se reconnecter comme client avant chaque lecture de contrôle. L’actualisation sans reconnexion sera étudiée dans B09.

## Processus pour reproduire le problème

1. Ouvrir Gérard et envoyer une demande avec le motif « A-J3 : fuite dans la cuisine ».
2. Se déconnecter puis se reconnecter comme client ; consulter « Mes demandes » et repérer ce motif.
3. Revenir au catalogue, ouvrir Gérard et envoyer une autre demande avec le motif « B-J3 : fuite dans la salle de bain ».
4. Se déconnecter puis se reconnecter comme client ; consulter de nouveau « Mes demandes ».
5. Vérifier que les deux motifs sont présents et compter les nouvelles demandes.
6. Arrêter puis relancer l’application dans le même environnement, se reconnecter client et vérifier à nouveau l’historique.

## Ce que l’on observe dans la version de départ

Après plusieurs créations, une seule des nouvelles demandes peut rester présente : la plus récente prend la place d’une précédente. L’historique ne reflète plus toutes les actions du client.

## Résultat attendu

- Les deux nouvelles demandes apparaissent séparément et conservent chacune leur motif.
- L’historique contient N + 2 demandes après ces deux créations, si aucune autre opération n’a été faite.
- Créer une demande supplémentaire ne modifie pas les précédentes.
- Les demandes restent consultables après relance et reconnexion du même client.
- Un formulaire trop court ne crée pas de demande supplémentaire.

## Vérification : si je fais ceci, alors…

| Si je fais ceci… | Alors je dois observer… | Résultat |
| --- | --- | --- |
| J’envoie la demande A puis je me reconnecte client. | Je retrouve A avec son motif et Gérard comme artisan. | ☐ OK / ☐ KO / ☐ Bloqué |
| J’envoie B puis je me reconnecte client. | Je retrouve A et B séparément. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je compte les demandes après A et B. | J’en ai deux de plus qu’au début de l’essai. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je compare les deux demandes. | Le motif de A n’a pas été remplacé par celui de B. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je relance l’application puis je me reconnecte client. | Les deux demandes sont toujours présentes. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je tente un envoi avec un motif de moins de cinq caractères. | Une explication est affichée et aucune nouvelle demande n’est créée. | ☐ OK / ☐ KO / ☐ Bloqué |

## Quand considérer la fiche comme terminée ?

- [ ] Les deux motifs distincts ont été retrouvés après reconnexion.
- [ ] La conservation a été vérifiée après relance.
- [ ] La réaction immédiate de la liste après envoi sera validée avec B09.
- [ ] J’ai conservé une preuve avant/après du scénario et indiqué le support utilisé.
- [ ] J’ai refait le scénario de reproduction complet après ma modification.


---

[Revenir au parcours](README.md) · [Fiche précédente](07_B07_favoris_apres_relance.md) · [Fiche suivante](09_B09_statuts_actualises.md)
