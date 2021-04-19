# portal

## Avant-propos : ##

W.I.P

![charm](https://ftbwiki.org/images/8/89/Item_Charm_of_Dislocation.png)

## Plan du README ##

- Avant-propos
- Plan
- Introduction à Portal et son installation de base
- Introduction aux différentes fonctionnalités offertes par Portal
- Présentation de la face cachée de Portal : le code
- L'organisation des versions


## Introduction à Portal et son installation de base ##

### Infos générales ###

Ce programme utilise le portail du mod `Draconic Evolution` et les mods `ComputerCraft`, `OpenPeripherals Addons`.


### Installation ###

Pour une utilisation simple du programme, je vous invite à suivre ces instructions en vous aidant du schéma pour comprendre le fonctionnement du portail et le reproduire dans votre base :

1. Construire un portail de Draconic Infused Obsidian et placer le Draconic Receptacle à un des sommets du portail
2. Placer un coffre (la nature du coffre devra être mentionnée dans l'initialisation du programme) de manière à ce qu'une des faces soit en contact avec le Receptacle et qu'aucun bloc n'empêche pas l'ouverture du coffre.
3. Connecter les périphériques à un réseau de Networking Cables à l'aide des Peripheral Proxys offerts par `OpenPeripherals Addons`
4. Placer un Computer dans lequel vous taperez cette commande : [pastebin run Xa4Bucuf](https://pastebin.com/Xa4Bucuf)

Voici un schéma des différents blocs utilisés pour l'installation :

![Me prévenir si l'image ne s'affiche pas](https://i.ibb.co/fSKPDyj/2021-04-04-17-06-03.jpg)

Et voici à quoi peut ressembler l'interface une fois installée :

![Me prévenir si l'image ne s'affiche pas](https://i.ibb.co/RHTm46m/2020-06-05-21-24-11.png)

**NOTE: Nous pouvons voir à gauche un dépositoir pour les charms qui peut être automatisé par le même programme qui affiche l'interface**

### Utilisation de Portal ###

W.I.P

## Introduction aux différentes fonctionnalités offertes par Portal ##

Toutes les fonctionnalités se configurent dès l'installation du programme et se présentent sous cette forme dans le fichier config.txt.
Cette masse de code peut paraître compliquée à comprendre mais chaque ligne a sa propre fonction, il suffit de mettre du sens sur le nom de chaque variable.


```
  chest_side = "west",
  chest_type = "draconic_chest",
  public_settings_access = "true",
  use_soundAPI = "true",
  use_monitor = "true",
  monitor_scale = "1",
  moderator_chest = "false",
  leave_event = "/door close",
  launch_event = "/door open",
  group1_color = "gold",
  group2_color = "lime",
```

1. `chest_side` : cette variable permet d'indiquer au programme la direction du Draconic Receptacle par rapport au coffre répertoriant toutes les charms. Pour obtenir cette information, il suffit d'appuyer, en jeu, sur la touche F3 et de noter le détail (SOUTH, WEST, EAST, ou NORTH) qui s'affiche entre paranthèses.
2. `chest_type` : qui peut également s'appeller `chest_name` puisque la fonction utilisée accepte les deux (peripheral.find(...)). S'il s'agit d'un coffre Draconic, il faudra noter 'draconic_chest' et s'il s'agit d'un coffre vanilla, 'chest'. **NOTE : l'utilisation d'un réseau ME comme répertoire n'a pas encore été essayé et nécessite de toute manière des modifications dans certains blocs du code. Mais si vous êtes calés en Computercraft, vous êtes bien évidemment libres d'essayer.**
3. `public_settings_access` : est une option qui permet d'afficher ou non le bouton des options dans lequel on peut changer les configurations de l'interface. Si vous êtes l'administrateur d'un serveur et que vous voulez exploiter le programme de manière à ce que les joueurs n'accèdent pas aux options d'une interface publique, alors je vous recommande d'écrire 'false' à cette ligne.
4. `use_soundAPI` : une autre option qui elle n'a pas d'impacte sur le bon fonctionnement de l'interface. Elle sert simplement à jouer des sons avec un `note_bloc`
5. `use_monitor` : pour spécifier l'usage d'un moniteur
6. `monitor_scale` : l'échelle de pixels du moniteur (0.5 / 1 / 2 / 3 / 4 / 5)
7. `moderator_chest` : 'moderator.lua' est un sous-programme qui permet de gérer les Charms entrantes dans le systèmes. Ce sous-programme peut être pratique dans un lieu où tout le monde peut partager ses coordonnées afin d'éviter de devoir approuver les Charms manuellement.

## Présentation de la face cachée de Portal : le code ##

Le module Portal consiste en un répértoire organisé labelisé '/Portal' dans lequel on retrouve ces fichiers :

```
> /portal
>> /lib
>>> /f
>>> /API
>>> /soundAPI
>> /launch
>> /config.txt
```


## L'organisation des mises à jour ##

W.I.P

### TAGS ###

draconic portal, computercraft, draconic evolution, interface, charm of dislocation, automatic, design
