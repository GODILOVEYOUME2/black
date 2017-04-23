local function run(msg, matches)
  local url , res = http.request('http://probot.000webhostapp.com/api/time.php/')
  if res ~= 200 then return tdcli.sendMessage(msg.chat_id_, msg.id_, 1, '<b>No Connection</b>', 1, 'html') end
  local jdat = json:decode(url)
   if jdat.L == "0" then
   jdat_L = 'خیر'
   elseif jdat.L == "1" then
   jdat_L = 'بله'
   end
  local text = '⌚️ساعت : <code>'..jdat.Stime..'</code>\n\n📆تاریخ : <code>'..jdat.FAdate..'</code>\n\n🌙تعداد روز های ماه جاری : <code>'..jdat.t..'</code>\n\n📍عدد روز در هفته : <code>'..jdat.w..'</code>\n\n📍شماره ی این هفته در سال : <code>'..jdat.W..'</code>\n\n💠نام باستانی ماه : <code>'..jdat.p..'</code>\n\n✨شماره ی ماه از سال : <code>'..jdat.n..'</code>\n\n🍃نام فصل : <code>'..jdat.f..'</code>\n\n🎆شماره ی فصل از سال : <code>'..jdat.b..'</code>\n\n💫تعداد روز های گذشته از سال : <code>'..jdat.z..'</code>\n\n💫در صد گذشته از سال : <code>'..jdat.K..'</code>\n\n📍تعداد روز های باقیمانده از سال : <code>'..jdat.Q..'</code>\n\n📍در صد باقیمانده از سال : <code>'..jdat.k..'</code>\n\n💎نام حیوانی سال : <code>'..jdat.q..'</code>\n\n📍شماره ی قرن هجری شمسی : <code>'..jdat.C..'</code>\n\n💎سال کبیسه : <code>'..jdat_L..'</code>\n\nمنطقه ی زمانی تنظیم شده : <code>'..jdat.e..'</code>\n\n💎اختلاف ساعت جهانی : <code>'..jdat.P..'</code>\n\n💎اختلاف ساعت جهانی به ثانیه : <code>'..jdat.A..'</code>\n'
  tdcli.sendMessage(msg.chat_id_, msg.id_, 1, text, 1, 'html')
end
-- By @GODILOVEYOUME2
return {
  patterns ={
"^[!/#]([Tt][Ii][Mm][Ee])$"
"^(ساعت)$"
 },
  run = run
}
