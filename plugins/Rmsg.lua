--Begin Rmsg.lua By @MahDiRoO
local function delmsg (arg,data)
    for k,v in pairs(data.messages_) do
        tdcli.deleteMessages(v.chat_id_,{[0] = v.id_}, dl_cb, cmd)
    end
end
local function run(msg, matches)
    local chat_id = msg.chat_id_
    local msg_id = msg.id_
    if matches[1] == 'rmsg' or matches[1] == 'حذف' or matches[1] == 'Rmsg' then
        if tostring(chat_id):match("^-100") then 
            if is_owner(msg) then
                if tonumber(matches[2]) > 100 or tonumber(matches[2]) < 1 then
                    return  '🚫 *100*> _تعداد پیام های قابل حذف هر دفعه_ >*1* 🚫'
                else
                    tdcli.getChatHistory(chat_id, msg_id, 0, tonumber(matches[2]), delmsg, nil)
                    return '*'..matches[2]..'* _پیام اخیر پاک شدند_'
                end
            end
        else
            return '_این قابلیت فقط در سوپرگروه ممکن است_'
        end
    end
end

return {patterns = {
        '^[!#/]([Rr]msg) (%d*)$',
        '^([Rr]msg) (%d*)$',
        '^(حذف) (%d*)$',
    },
    run = run}
--End Rmsg.lua--
