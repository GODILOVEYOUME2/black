# [MahDiRoO](https://telegram.me/MahDiRoO)


* * *


# Installation

```sh
# Let's install the bot.
cd $HOME
git clone https://github.com/mahdiroo/MaTaDoR.git
cd MaTaDoR
chmod +x matador.sh
./matador.sh install
./matador.sh 
# Enter a phone number & confirmation code.
```
### One command
To install everything in one command, use:
```sh
cd $HOME && git clone https://github.com/mahdiroo/MaTaDoR.git && cd MaTaDoR && chmod +x matador.sh && ./matador.sh install && ./matador.sh
```

* * *

### launch Bot

```
killall -9 bash
cd MaTaDoR && killall screen && screen ./matador.sh
```

* * *


### auto launch 
```
bi pv :)
@MahDiRoO
```

* * *


### Sudo

Open ./bot/bot.lua and add your ID to the "sudo_users" section in the following format:
```
    sudo_users = {
    377450049,
    0,
    YourID
  }
