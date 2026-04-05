# AGENTS.md

## Read README.md

- When making changes, use a hierarchical approach and read all README from the
  project root all the way down to the change level.
  - For example, if a change is related to `repo/src/lib/code.py`, then you need
    to first read any README you can find from `repo/README.md`,
    `repo/src/README.md`, and `repo/src/lib/README.md`.
  - Child, granular README instructions override parental, global ones.
  - If the README refers you to other resources to better understand the code,
    read them too.

## Commit messages

- Each commit message should look like this: `[tag] short one-liner`. For
  example: `[chess] support hexagonal board`. There could be multiple tags.
