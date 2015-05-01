print("Initialised")
monitor=fs.open("monitor","r")
if monitor then monitor = peripheral.wrap(h.readAll())
else monitor = peripheral.find("monitor") end
command = fs.open("command,"r")
if command then command = peripheral.wrap(command.readAll())
else command = peripheral.find("command") end
show = fs.open("show","r")
if show then show = show.readAll()
else show = "&7Default hover event" end
show = show:gsub("&","\\u00A7")
show = show:gsub("%%n","\\n")
pr = fs.open("pr","r")
if pr then pr = pr.readAll()
else pr = "&7[Default Prefix] " end
wl = fs.open("wl","r")
if wl then wl = textutils.unserialize(wl.readAll())
else wl = {} end
print("All wrapped")
m = monitor
c = command

function runCommand(command)
c.setCommand(command)
c.runCommand()
end
_modes = {["-s"] = "bSilent",["-d"] = "bDebug"}
for k,v in ipairs(modes) do
  if _modes[v] then _G[_modes[v]] = true end
end

if bSilent then
say = function(txt)
txt = pr..txt
txt = txt:gsub("&","\\u00A7")
for k,v in ipairs(wl) do
  runCommand("tellraw "..v.." {hoverEvent:{action:\"show_text\",value:\""..show.."\"},text:\""..txt.."\"}")
end
end
else
say = function(txt)
txt = pr..txt
txt = txt:gsub("&","\\u00A7")
runCommand("tellraw @a {hoverEvent:{action:\"show_text\",value:\""..show.."\"},text:\""..txt.."\"}")
end
end

say("Initialised")
