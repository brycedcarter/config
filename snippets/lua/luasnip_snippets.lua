local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node

local snippets = {
  s(
    {
      trig = "luasnip-snippet",
      desc = "A snippet in the luasnip format"
    },
    fmt([==[
s({{
  trig = "{1}",
  desc = "{2}"
}},
    fmt([=[

]=], {{
      i(1, "{3}"),
    }},
    {{repeat_duplicates = true}}
    )
),
]==],
      { i(1, "trigger"),
        i(2, "description"),
        i(3, "field_name"),
      })
  ),


  ------------------------------------------------------ SNIPPET GENIE LOC
  -- At this line ^^ is where the SnippetGenie plugin will place its generated
  -- snippets
}

local autosnippets = {}

return snippets, autosnippets
