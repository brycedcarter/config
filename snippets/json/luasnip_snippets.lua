local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node

local snippets = {

  s(
    {
      trig = "vscode-snippet-lang-mapping",
      desc = "Language entry in vscode style snippets pacakge.json file"
    },
    fmt([=[
{{
    "language": [ "{1}" ],
    "path": "./{}/vscode_snippets.json"
}}
]=], {
      i(1, "lang"),
      rep(1)
    })
  ),

  ------------------------------------------------------ SNIPPET GENIE LOC
  -- At this line ^^ is where the SnippetGenie plugin will place its generated
  -- snippets
}

local autosnippets = {}

return snippets, autosnippets
