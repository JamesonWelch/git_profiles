# Git Profiles
Simple configurations and scripts to simplify managing more than one git account

## Setup
Git configuration is stored in the `.gitconfig` file located in your home directory and can be seen by the command:
```bash
cat ~/.gitconfig
```
Creating more than one profile can be achieved by creating separate git congiguration files and having your `~/.gitconfig` file point to them.

ref: [How to Use Multiple Git Configs on One Computer](https://www.freecodecamp.org/news/how-to-handle-multiple-git-configurations-in-one-machine/)

### Profile Directories
Separating the repositories in different directories based on the profile is one way of accomplishing this.

For a personal git profile, have everything located in at `personal/` directory and point `~/.gitcongig` so it uses your personal configuration detailed in a `.gitconfig-personal` file by inserting the lines in yout `.gitconfig`:
```bash
[includeIf "gitdir:~/personal/"]
  path = ~/.gitconfig-personal
```
Make sure to place the `.gitconfig-personal` file in your home directory.

### git Config
git configuration files will have the followint text:
```bash
[user]
 name = personal_user
 email = personal_email
 ```
 Replace with your information