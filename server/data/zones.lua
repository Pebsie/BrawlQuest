zone = {}

zone["Swordbreak"] = "map-swordbreak.txt"
zone["Hunters"] = "map-hunters.txt"
zone["West"] = "map-west.txt"

function initZones()
  loadOverworld("Swordbreak")
  loadOverworld("Hunters")
  loadOverworld("West")
end
