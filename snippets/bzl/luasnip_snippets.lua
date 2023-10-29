local ls = require("luasnip")
local extras = require("luasnip.extras")
local s = ls.snippet
local i = ls.insert_node
local fmt =  require("luasnip.extras.fmt").fmt

local snippets = {

s({
  trig = "py_binary",
  desc = "Python binary bazel target"
},
    fmt([=[
py_binary(
    name = "{1}",
    main = "{1}.py",
    srcs = [
    "{1}.py",
    ],
    deps = [
        "//{2}",
    ],
)
]=], {
      i(1, "name"),
      i(2, "dep")
    },
    {repeat_duplicates = true})
),

s({
  trig = "py_library",
  desc = "Python library bazel target"
},
    fmt([=[
py_library(
    name = "{1}",
    srcs = ["{1}.py"],
    deps = [
        "//{2}",
    ],
)
]=], {
      i(1, "name"),
      i(2, "dep")
    },
    {repeat_duplicates = true})
),




  ------------------------------------------------------ SNIPPET GENIE LOC
  -- At this line ^^ is where the SnippetGenie plugin will place its generated
  -- snippets
}

local autosnippets = {}

return snippets, autosnippets
