
local uci = require "luci.model.uci"
local myIsEnabled = false


m = Map("pogoplug", translate("Pogoplug"),
	translate("Pogoplug allows you to attach a hard drive to your router and make the " ..
	"photos, videos, music and documents on all your devices instantly accessible " ..
	"anywhere you go. Protect photos with automatic backups and share them easily with " ..
	"friends and family, stream music and movies to your mobile devices and unlock the " ..
	"potential of your very own personal cloud with Pogoplug."))

s = m:section(TypedSection, "service", "")
s.addremove = false
s.anonymous = false

e = s:option(Flag, "enabled", translate("Enable"), translate("To finish setting up your Pogoplug account click &quot;Save &amp; Apply&quot;, then visit pogoplug.com/activate. If you have already activated your account, please visit my.pogoplug.com/signin to begin using Pogoplug."))

if os.execute("/etc/init.d/hbplug enabled") == 0 then
	myIsEnabled = true
else
	myIsEnabled = false
end


function e.cfgvalue(self, section)
	if myIsEnabled then
		return "1"
	else
		return "0"
	end	
end

function e.parse(self, section)
	if e:formvalue(section) then
		myIsEnabled = true
	else
		myIsEnabled = false
	end
end

function m.on_after_commit(self)
	if myIsEnabled then
		if os.execute("/etc/init.d/hbplug enable") == 0 then
			os.execute("/etc/init.d/hbplug start")
		end
	else
		os.execute("/etc/init.d/hbplug stop")
		os.execute("/etc/init.d/hbplug disable")
	end
end

return m
