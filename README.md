# portal

## Map of the README ##

- Map
- Introduction to Portal and its basic installation
- The various functionalities
- The hidden part of Portal


## Introduction to Portal and its basic installation ##

### General informations ###

This program uses the Draconic Portal from `Draconic Evolution` and the mods `ComputerCraft`, `OpenPeripherals Addons`.

![charm](https://ftbwiki.org/images/8/89/Item_Charm_of_Dislocation.png)

### Installation ###

For a simple use of the program, I invite you to follow these instructions with the help of the diagram to understand how the portal works and reproduce it in your own base:

1. Build a Draconic Infused Obsidian portal and place the Draconic Receptacle at one of the corners of the portal
2. Place a chest (the nature of the chest must be mentioned in the initialization of the program) so that one of the faces is in contact with the Receptacle and that no block prevents the opening of the chest.
3. Connect the devices to a network of Networking Cables using the Peripheral Proxies from `OpenPeripherals Addons`.
4. Place a Computer in which you type this command: [pastebin run Xa4Bucuf](https://pastebin.com/Xa4Bucuf)

Here is a diagram of the different blocks used for the installation:

![Warn me if the image is not displayed](https://i.ibb.co/fSKPDyj/2021-04-04-17-06-03.jpg)

And here is what the interface can look like once installed:

![Notify me if the image does not appear](https://forum.mineaurion.com/assets/uploads/files/1590413050682-2020-05-25_15.22.24.png)

### Using Portal ###

W.I.P

## Introduction to the different features offered by Portal ##

All the features are configured as soon as the program is installed and can be find in the config.txt file :
This mass of code may seem complicated to understand but each line has its own function.


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

1. `chest_side` : this variable allows to indicate to the program the direction of the Draconic Receptacle from the main chest. To obtain this information, simply press the F3 key in-game and note the detail (SOUTH, WEST, EAST, or NORTH) which is displayed in brackets.
2. `chest_type`: which can also be called `chest_name` since the function used accepts both (peripheral.find(...)). If it is a Draconic chest, it should be written as `draconic_chest` and if it is a vanilla chest, as `chest`. **NOTE: the use of a ME network as a directory has not yet been tried and requires modifications in some of the code blocks anyway. But if you're good at Computercraft, you are free to try.**.
3. `public_settings_access` : is an option to display or not the options button where you can change the interface settings. If you are a server administrator and you want to operate the program in such a way that players do not have access to the public interface options, then I recommend that you write 'false' to this line.
4. `use_soundAPI`: another option which has no impact on the proper functioning of the interface. It is simply used to play sounds with a `note_block`.
5. `use_monitor` : to specify the use of a monitor
6. `monitor_scale` : the monitor pixel scale (0.5 / 1 / 2 / 3 / 4 / 5)
7. `moderator_chest` : 'moderator.lua' is a subroutine which allows to automacticly manage the incoming charms in the system. This subroutine can be useful if the portal is used in a public place. In this manner, you won't have to manually put the charms in the main chest, which allows unknown players to share their coordinates.

## Presentation of the hidden part of Portal: the code

The Portal module consists of an organized directory labeled '/Portal' in which we find these files:

```
> /portal
>> /lib
>>> /f
>>> /API
>>> /soundAPI
>> /launch
>> /moderator
>> /setup
>> /config.txt
```
