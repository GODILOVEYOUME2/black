--Begin Ping.lua By @MahDiRoO
local datebase = {
   "Bot Online❤️",
  }
local function run(msg, matches) 
return datebase[math.random(#datebase)]
end
return {
  patterns = {
    "^([Pp][Ii][Nn][Gg])",
	"^[!/#]([Pp][Ii][Nn][Gg])",
	"^(انلاینی)"
  },
  run = run
}
--End Ping.lua--