local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node

local snippets = {
s(
    "test",
    fmt([=[
from vehicle.deploy.build_assets.products.build_cache import build_cache_enable  # noqa: E402
from vehicle.deploy.build_assets.products.build_product import (  # noqa: E402
    BuildAssetGroup,
    ProductBuilder,
)
from vehicle.deploy.build_assets.publishers import (  # noqa: E402
    BuildPublisher,
    FilesystemBuildPublisher,
    S3BuildPublisher,
)
from vehicle.deploy.lib.caches import ASSET_CACHE_PATH  # noqa: E402
from vehicle.deploy.lib.driving_os.lib import compute_imaging_source_checksum  # noqa: E402

]=], {
        
    })
),

s(
    "",
    fmt([=[
logging.basicConfig(
    format="[%(asctime)s] %(levelname)s [%(name)s.%(filename)s:%(lineno)d] %(message)s",
    level=logging.INFO,
)
log = logging.getLogger("driving_build")
]=], {
        
    })
),

  --------------------------------- SNIPPET GENIE LOC -------------------------
  -- At this line ^^ is where the SnippetGenie plugin will place its generated
  -- snippets
}

local autosnippets = {}

return snippets, autosnippets
