# dotfiles

My configuration files for bash, tmux, vim, Neovim, git and the i3 window
manager, plus a folder of small helper scripts.

## Installing with setup.sh

Clone the repo anywhere you like and run the setup script from it:

```bash
git clone https://github.com/W0LAB/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

The script doesn't copy anything. It creates symbolic links from your home
directory back into this repo, so the repo stays the single source of truth:
edit a file here (or through its link) and the change is live immediately,
ready to commit.

It asks before installing each item:

| Repo path   | Linked to            |
|-------------|----------------------|
| `bashrc`    | `~/.bashrc`          |
| `tmux.conf` | `~/.tmux.conf`       |
| `i3/`       | `~/.config/i3`       |
| `gitconfig` | `~/.gitconfig`       |
| `nvim/`     | `~/.config/nvim`     |
| `vimrc`     | `~/.vimrc`           |
| `local/bin/`| `~/.local/bin`       |

For each one, answer `y` to install it or press any other key to skip it.
Then:

- **Already linked here:** it's left alone, so running the script again is safe.
- **Something else already there:** you're asked whether to overwrite it.
  Saying `y` **deletes** the existing file or directory (`rm -rf`) before
  creating the link. Back up anything you want to keep first.
- **Missing parent folders**, such as `~/.config`, are created automatically.

The script finds its own location, so it works from wherever you cloned the
repo, not only `~/dotfiles`.

### Things to know

- **`~/.local/bin` is replaced as a whole folder.** If you already have
  programs in it, overwriting removes them. Afterwards, anything a tool
  installs into `~/.local/bin` lands inside this repo; check `git status`
  before committing. Machine-specific links can go in `.gitignore`.
- **`gitconfig` sets the commit identity to W0LAB.** If you're not me, skip
  it or change `name` and `email` before using it.
- **`bashrc` starts tmux automatically** in every new interactive shell, and
  sources `~/.local/bin/git-prompt.sh`, so install `local/bin` along with it.

## What's in local/bin

Small scripts, each with a one-line description at the top. Highlights:

- `dps`, `dex`, `drm`, `dup`, `down`, `dim`, `freewilly`: Docker shortcuts
- `ginfo`, `gitgetcontributors`, `pullallrepos`, `update_tools`: git helpers
- `finfo`, `hashdir`, `getlargefiles`: file information and checksums
- `myip`, `headers`, `webspeed`, `ports`, `geocoder`: network lookups
- `gitcreds`: scan the current folder for leaked credentials with trufflehog
