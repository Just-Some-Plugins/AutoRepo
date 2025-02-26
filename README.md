# AutoRepo-Worker [![Parse and Process Trigger](https://github.com/Just-Some-Plugins/AutoRepo/actions/workflows/parse_trigger.yml/badge.svg)](https://github.com/Just-Some-Plugins/AutoRepo/actions/workflows/parse_trigger.yml)

This script is designed to get around the limitation in GitHub
building where an action in one repository cannot be
triggered by another repository.
This limitation combined with the inability to easily add
actions to a contribution-focused fork of a plugin (you would
have to constantly remove them pre-PR),
makes it difficult to auto-build your fork for tester's to use.

These Actions are ran from a comment on [an issue](https://github.com/Just-Some-Plugins/AutoRepo/issues/1),
created by [AutoRepo-worker](https://autorepo.justsome.site), and they do 
the actual building of the triggering repositories, and subsequent packaging and
publishing of the built plugin to the [AutoRepo-Web](https://autorepo.justsome.site/web)
repository, which is a private shell repo.
The shell has no actual code, it is only a destination for the build script to commit
to and is the repo for Cloudflare Pages website, so when the build script pushes 
to it, Cloudflare will pull and publish those changes to the website.

> [!TIP]
> For Usage, see [AutoRepo-worker](https://autorepo.justsome.site).

<details><summary>

# Setup

</summary>

## Repository Secrets

These Actions Variables are required to be present on
AutoRepo, the repository that the worker is triggering builds on.

Setup under `Secrets and Variables` > `Actions` > `Secrets` in
the repository settings.

| Secret Name             | Value                                                          | PAT Link                                                         |
|-------------------------|----------------------------------------------------------------|------------------------------------------------------------------|
| BOT_READ_REPOS_TOKEN    | Fine-Grained PAT with Repository: Variables: Read, on AutoRepo | [->](https://github.com/settings/personal-access-tokens/3693504) |
| BOT_INVITE_ACCEPT_TOKEN | Classic PAT with the full repo scope                           | [->](https://github.com/settings/tokens/1683235558)              |

### Local Running

Local running of Actions is vital for development and testing, and the only real
way to do this is via [nektos/act](https://github.com/nektos/act).

It's sort of a hassle to set up, but that's made a LOT easier if done through the
[GitHub Local Actions VS Code Extension](https://marketplace.visualstudio.com/items?itemName=SanjulaGanepola.github-local-actions).
Just install that, and go through the Component Setup process (if you need help, 
go [here](https://sanjulaganepola.github.io/github-local-actions-docs/usage/components/)),
run the action once to get the prompts to finish your setup, and you'll be ready to
run the actions locally via the `.idea/runConfigurations` script (once you make 
the `.secrets` file below, that is).

### .secrets

`payload.json` has been provided for local running with `act`, but you'll still need
the secrets.

Make a new file called `.secrets`, and in it you need to add the Repository Secrets
from above, in the following format:

```
BOT_INVITE_ACCEPT_TOKEN=ghp_.......
BOT_READ_REPOS_TOKEN=github_pat_.......
```
(replacing everything after the `=` with the actual secret values)

</details>

---

    AutoRepo: worker-triggered github actions to build plugins.
    Copyright (C) 2024  Ethan Henderson (zbee) <ethan@zbee.codes>

     This program is free software: you can redistribute it and/or modify
     it under the terms of the GNU Affero General Public License as published
     by the Free Software Foundation, either version 3 of the License, or
     (at your option) any later version.

     This program is distributed in the hope that it will be useful,
     but WITHOUT ANY WARRANTY; without even the implied warranty of
     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
     GNU Affero General Public License for more details.

     You should have received a copy of the GNU Affero General Public License
     along with this program. If not, see <https://www.gnu.org/licenses/>. 
