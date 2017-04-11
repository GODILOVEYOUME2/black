--Start By@Tele_Sudo
local function get_arz()
  local url = 'http://exchange.nalbandan.com/api.php?action=json'
  local jstr, res = http.request(url)
  local arz = json:decode(jstr)
  return '📊 نرخ ارز ، طلا و سکه در:'..arz.dollar.date..'\n\n〽️ هر گرم طلای 18 عیار:'..arz.gold_per_geram.value..' تومان\n\n🌟 سکه طرح جدید:'..arz.coin_new.value..' تومان\n\n⭐️ سکه طرح قدیم:'..arz.coin_old.value..' تومان\n\n💵 دلار آمریکا:'..arz.dollar.value..' تومان\n\n💵 دلـار رسمی:'..arz.dollar_rasmi.value..' تومان\n\n💶 یورو:'..arz.euro.value..' تومان\n\n💷 پوند:'..arz.pond.value..' تومان\n\n💰 درهم:'..arz.derham.value..'تومان\n'
end

local function run(msg, matches)
  local text
  if matches[1] == 'arz' then
  text = get_arz() 
elseif matches[1] == 'gold' then
  text = get_gold() 
elseif matches[1] == 'coin' then
  text = get_coin() 
  end
  return text
end
return {
  description = "arz in now", 
  usage = "arz",
  patterns = {
    "^[!/#](arz)$"
  }, 
  run = run 
}

--End By@Tele_Sudo
--Channel @luaError