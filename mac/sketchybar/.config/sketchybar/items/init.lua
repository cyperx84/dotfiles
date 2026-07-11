-- Full item loader — order mirrors the active `source` order in the old bash rc
-- so left/center/right placement matches exactly.

-- Left
require("items.apple")
require("items.spaces")
require("items.front_app")
require("items.ssh")
require("items.tmux")
require("items.docker")
require("items.agents")

-- Right
require("items.calendar")
require("items.brew")
require("items.wifi")
require("items.battery")
require("items.audio_output")
require("items.volume")
require("items.cpu")
require("items.memory")
require("items.temperature")
require("items.disk")
require("items.network")

-- Brackets over already-added members
require("brackets")
