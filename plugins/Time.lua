--By : @Sherider
function sheri(msg, matches)
local url , res = http.request('http://probot.000webhostapp.com/api/time.php/')
if res ~= 200 then return "No connection" end
local jdat = json:decode(url)
local text = 'ساعت :  '..jdat.FAtime..'\n\nتاریخ :  '..jdat.FAdate..'\n\nتعداد روزهای جاری ماه : '..jdat.t..'\n\nعدد روز در هفته : '..jdat.w..'\n\nشماره ی این هفته در سال : '..jdat.W..'\n\nنام باستانی ماه : '..jdat.p..'\n\nشماره ی ماه از سال : '..jdat.b..'\n\nنام فصل : '..jdat.f..'\n\nشماره ی فصل از سال : '..jdat.n..'\n\nتعداد روز های گذشته از سال : '..jdat.z..'\n\nدرصد گذشته از سال : '..jdat.K..'\n\nتعداد روز های باقی مانده از سال : '..jdat.Q..'\n\nدرصد باقی مانده از سال : '..jdat.k..'\n\nنام حیوانی سال : '..jdat.q..'\n\nشماره ی قرن هجری شمسی : '..jdat.C..'\n\nسال کبیسه : خیر\n\nمنطقه ی زمانی تنظیم شده : '..jdat.e..'\n\nاختلاف ساعت جهانی : '..jdat.P..'\n\nاختلاف ساعت جهانی به ثانیه : '..jdat.Z..'\n\n'
  tdcli.sendMessage(msg.chat_id_, 0, 1, text, 1, 'md')
end
return {
  patterns = {
  "^[/!]([Dd][Aa][Tt][Ee])$",
  "^([Dd][Aa][Tt][Ee])$",
  "^(ساعت)$"
  }, 
run = sheri
}
--Good Luck:)
--Date-Pro.lua
