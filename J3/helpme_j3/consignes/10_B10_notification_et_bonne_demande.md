# B10 - Ouvrir la demande liée à une notification

## Objectif

Quand un utilisateur touche une notification associée à une demande, l’application doit lui présenter cette demande, sous réserve de ses droits d’accès.

## Avant de commencer

- B08 et B09 validés.
- Séance préparée par le professeur : application connectée au projet Firebase de formation et installée sur l’iPhone physique prévu pour les notifications.
- Permission de notification accordée et réception d’un message de contrôle déjà vérifiée.
- Deux demandes distinctes du même client sont disponibles : A et B. Le professeur prépare deux notifications, l’une associée à A et l’autre à B.
- Le client concerné est connecté. Un message de notification ne remplace pas la connexion à son compte.

## Processus pour reproduire le problème

1. Ouvrir l’application et confirmer le compte client connecté.
2. Passer l’application en arrière-plan, sans se déconnecter.
3. Faire envoyer la notification associée à la demande A.
4. Toucher cette notification et relever l’écran affiché.
5. Comparer le motif, l’artisan et le statut avec la demande A.
6. Recommencer avec la notification B.
7. Refaire l’essai après fermeture complète de l’application, puis vérifier le retour vers une navigation normale.

## Ce que l’on observe dans la version de départ

La notification peut ouvrir l’application mais laisser l’utilisateur sur le catalogue au lieu de présenter la demande concernée. La réception du message, seule, ne prouve donc pas que le parcours est correct.

## Résultat attendu

- Une notification associée à A ouvre A ; une notification associée à B ouvre B.
- Le contenu affiché correspond à la demande ciblée : motif, artisan et statut.
- L’ouverture fonctionne depuis l’arrière-plan et après un démarrage de l’application.
- L’utilisateur peut ensuite continuer à utiliser l’application.
- Une notification sans demande exploitable ou visant une demande non accessible n’expose pas les données d’un autre utilisateur.

## Vérification : si je fais ceci, alors…

| Si je fais ceci… | Alors je dois observer… | Résultat |
| --- | --- | --- |
| Je touche la notification A pendant que l’application est en arrière-plan. | Je vois le détail de A, pas seulement le catalogue. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je touche la notification B. | Je vois B ; les informations de A ne sont pas réutilisées à sa place. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je ferme complètement l’application puis je touche une nouvelle notification A. | Après le démarrage et la restauration du compte, je vois A. | ☐ OK / ☐ KO / ☐ Bloqué |
| J’ouvre une notification pour une demande à laquelle ce compte n’a pas accès. | Je ne vois pas son contenu privé ; un état compréhensible est présenté. | ☐ OK / ☐ KO / ☐ Bloqué |
| Un message reçu ne permet pas de désigner une demande. | L’application reste utilisable sans afficher une demande choisie au hasard. | ☐ OK / ☐ KO / ☐ Bloqué |
| Je termine la consultation de la demande ouverte. | Je peux rejoindre le catalogue, les demandes ou les réglages sans être bloqué. | ☐ OK / ☐ KO / ☐ Bloqué |

## Quand considérer la fiche comme terminée ?

- [ ] La réception réelle du message et l’ouverture de sa demande ont été distinguées.
- [ ] Deux demandes différentes ont été testées.
- [ ] Les essais arrière-plan et démarrage ont été faits sur le téléphone préparé.
- [ ] Sans cet environnement, noter « Bloqué : préparation des notifications requise » ; ne pas valider par une simple ouverture manuelle de l’application.
- [ ] J’ai conservé une preuve avant/après du scénario et indiqué le support utilisé.
- [ ] J’ai refait le scénario de reproduction complet après ma modification.


---

[Revenir au parcours](README.md) · [Fiche précédente](09_B09_statuts_actualises.md)
