# Personal Snippets
## Overview
This is where all of my personal snippets go. This is a hybrid area that
supports both VS Code style snippets (where a `package.json` file gives a mapping from language to a json file that contains snippets) and LuaSnip lua snippets.

- We support VS Code style snippets because it is a standard that will allow us to use external snippets more easily
- We support LuaSnip lua based snippets because they are more powerful, easier to read and edit, and allow us to use the SnippetGenie plugin for nvim to generate them more easily

## Setting Up New Languages
To add support for a new language, please do the following:

1) Make a new directory with the name of the language
```mkdir $LANGUAGE_NAME```

2) Create three files in that directory from their template files
```
cp luasnip_snippets.lua.template $LANGUAGE_NAME/luasnip_snippets.lua
cp vscode_snippets.json.template $LANGUAGE_NAME/vscode_snippets.json
```
3) Update the VS Code style `packages.json` mapping file that give the mapping
between each language and where to find its snippets (Note that we have a `json` luasnip snippet for helping with this )

