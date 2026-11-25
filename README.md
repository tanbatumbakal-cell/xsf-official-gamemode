# xSF official gamemode

This is the public release of xSF gamemode, which was hosted under www.xsfserver.com.
It is released under the MIT license, please read the license before you continue.

## IMPORTANT NOTICE!!
- Script is currently using a very weak, un-salted **SHA1** encryption for user passwords. This hash is easily reversed/brute forced. [Read here](https://www.computerworld.com/article/3173616/the-sha1-hash-function-is-now-completely-unsafe.html)
- Not changing this to something else like bcrypt is considered unethical, and truly dangerous in cases where the database gets leaked.
- xSF was planned closed already when this was noticed, hence it was not taken care of.
- A future update to the code will resolve this issue.

## How to use
- xSF has always been built to run on a Linux environment. The repository has some of the Windows plugins, however the Linux (Debian 8) plugins from the production server has been included in the `plugins` folder in the repo. We recommend you running Debian to avoid UDP packet issues due to kernel issues on Ubuntu distros. If you run Windows based host OS's, there is no guarantee it works, but it should really not be a problem. (PS: I did not try that myself.)
- Insert mysql and IRC information as you wish and need in `gamemodes/base/server/server_config.inc` (Passwords, IP's and usernames along with channels, bot names and channel names)
- change the RCON password in `server.cfg` --> and don't forget to change the URL for website, etc.
- The current `server.cfg` is identical to how the production server used its plugins (order is important.)
- The `database_structure.sql` file contains all the tables from build 60. There is no data in the sql file.
- Replace "Server"  with your server name. There are variables in the script to change this on the fly. Please do not use xSF as your name.


## Other
- If you find bugs or issues, you can still report them here, and I can patch these issues as they appear.
- All instances of the word "xsf" has been removed and replaced with a variable you can set the name at. **Do not use xSF's name (please).**
- The gamemode and server scripts are very unoptimised and may (or may not) look terrible to you. It was a true pain to work on it, as it does require quite some work to work optimally. There are also several types of identation in the code, as there has been around 10 developers working on the code up through the years, none of which has followed any form for standards.
- Any changes bugs or issues should be reported here: https://git.ducky.rocks/denNorske/xsf-official-gamemode/issues
- player data is not included in this release, to keep PII and data away from others. GDPR and other laws are essential in this decision.
- No direct support is given. Do not ask me to be a co-owner, scripter or hoster for this. You are free to use any part of xSF's code in your projects, and a simple credit dedicated to xSF would be greatly appreciated.

## Credits
Big shoutout to all previous developers in this project. xSF was a big server around 2013-2016, and had worse periods after until it closed 5th of May 2019. xSF belongs to me (denNorske) and is now publicly released for SA-MP and open.mp.
 
