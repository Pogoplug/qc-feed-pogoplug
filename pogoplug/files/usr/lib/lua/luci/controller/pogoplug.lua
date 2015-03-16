
module("luci.controller.pogoplug", package.seeall)

function index()
	if not nixio.fs.access("/etc/init.d/hbplug") then
		return
	end
	
	local page

	page = entry({"admin", "services", "pogoplug"}, cbi("pogoplug/pogoplug"), _("Pogoplug"))
	page.dependent = true
end
