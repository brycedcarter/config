local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node

local snippets = {

s(
    "argparse positional",
    fmt([=[
parser.add_argument("{}", type={}, help="{}")
]=], {
        i(1, "position"),
        i(2, "type"),
        i(3, "help text"),
    })
),

s(
    "argparse flag",
    fmt([=[
parser.add_argument("-f", "--{}", action="store_true", type={}, help="{}")
]=], {
        i(1, "flag"),
        i(2, "type"),
        i(2, "help text"),
    })
),

s(
    "argparse choices",
    fmt([=[
parser.add_argument("--{}", choices=[], help="{}")
]=], {
        i(1, "choice"),
        i(2, "help text"),
    })
),

s(
    "parse args",
    fmt([=[
def parse_args():
    parser = argparse.ArgumentParser()
    parser.description = __doc__

    {}

    args = parser.parse_args()
    return args
]=], {
        i(1, "# Arguments go here"),
    })
),

s(
    "argparse named",
    fmt([=[
parser.add_argument("--{}", default={}, type={}, help="{}")
]=], {
        i(1, "named"),
        i(2, "default"),
        i(3, "type"),
        i(4, "help text"),
    })
),

s(
    "basic logger config",
    fmt([=[
import logging

logging.basicConfig(
    level=logging.INFO, format="%(asctime)s - %(name)s - %(levelname)s - %(message)s"
)
logger = logging.getLogger(__name__)
]=], {
        
    })
),

  --------------------------------- SNIPPET GENIE LOC -------------------------
  -- At this line ^^ is where the SnippetGenie plugin will place its generated
  -- snippets
}

local autosnippets = {}

return snippets, autosnippets
