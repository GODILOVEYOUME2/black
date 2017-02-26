--Begin Expire.lua By @MahDiRoO
local day = 86400
local function modrem(msg)
    local data = load_data(_config.moderation.data)
    data[tostring(msg.to.id)] = nil
    save_data(_config.moderation.data, data)
        local groups = 'groups'
        if not data[tostring(groups)] then
            data[tostring(groups)] = nil
            save_data(_config.moderation.data, data)
        end
        data[tostring(groups)][tostring(msg.to.id)] = nil
        save_data(_config.moderation.data, data)
    tdcli.sendMessage(msg.to.id, "", 0, "_This Is Not One Of My Groups_*", 0, "md")
    redis:del("chargedtest:"..msg.to.id)
    tdcli.changeChatMemberStatus(msg.to.id, our_id, 'Left', dl_cb, nil)
end

local function pre_process(msg)
    local data = load_data(_config.moderation.data)
    if msg.content_.text_ then
        local add_cmd = msg.content_.text_:match("/add") or msg.content_.text_:match("!add") or msg.content_.text_:match("#add")
        if add_cmd and is_sudo(msg) then
            redis:set("charged:"..msg.to.id,true)
        end
        local gpid_cmd = msg.content_.text_:match("/gid") or msg.content_.text_:match("!gid") or msg.content_.text_:match("#gid")
        if gpid_cmd and is_sudo(msg) then
	        tdcli.sendMessage(msg.to.id, msg.id, 1, '*'..msg.to.id..'*', 1,'md')
        end
    end
    if gp_type(msg.to.id) == 'channel' or gp_type(msg.to.id) == 'chat' then
        if not redis:get("chargedtest:"..msg.to.id) then
            redis:set("chargedtest:"..msg.to.id,true)
            redis:setex("charged:"..msg.to.id,60,true)
            return tdcli.sendMessage(msg.to.id, "", 0, "<i>زمان یک دقیقه برای افرودن گروه در نظر گرفته شد</i>", 1, 'html')
        end
            if not redis:get("charged:"..msg.to.id) and not is_sudo(msg) then
                local sudo = 377450049
                local t1 = "شارژ این گروه به اتمام رسید \n\nID : "..msg.to.id..'\n\nدر صورتی که میخواهید ربات این گروه را ترک کند از دستور زیر استفاده کنید\n\n/leave '..msg.to.id..'\nبرای جوین دادن توی این گروه میتونی از دستور زیر استفاده کنی:\n/join91752'..msg.to.id..'\n_________________\nدر صورتی که میخواهید گروه رو دوباره شارژ کنید میتوانید از کد های زیر استفاده کنید...\n\n<code>برای شارژ 1 ماهه:</code>\n/plan1'..msg.to.id..'\n\n<code>برای شارژ 3 ماهه:</code>\n/plan2'..msg.to.id..'\n\n<code>برای شارژ نامحدود:</code>\n/plan3'..msg.to.id
                local t2 = "شارژ این گروه به اتمام رسید و ربات از گروه خارج میشود...\nبرای تمدید کردن ربات به @MahDiRoO پیام دهید."
                tdcli.sendMessage(sudo, 0, 1, t1, 1, 'html')
                tdcli.sendMessage(msg.to.id, 0, 1, t2, 1, 'html')
                modrem(msg)
        end
    end
end
local function run(msg, matches)
    if gp_type(msg.to.id) == 'channel' or gp_type(msg.to.id) == 'chat' then
        if matches[1] == "setexpire" and matches[2] and not matches[3] and is_sudo(msg) or  matches[1] == "Setexpire" and matches[2] and not matches[3] and is_sudo(msg) then
            local time = matches[2] * day
            redis:setex("charged:"..msg.to.id,time,true)
            tdcli.sendMessage(msg.to.id, msg.id, 1, 'ربات با موفقیت تنظیم شد\nمدت فعال بودن ربات در گروه به '..matches[2]..' روز دیگر تنظیم شد...', 1, 'html')
        end
        if matches[1] == 'expire' and not matches[2] or matches[1] == 'Expire' and not matches[2] then
            local ex = redis:ttl("charged:"..msg.to.id)
            if ex == -1 then
                return "نامحدود!"
            else
                local d = math.floor(ex / day ) + 1
                return d.." روز تا انقضا گروه باقی مانده"
            end
        end
        if matches[1] == 'expire' and is_sudo(msg) and matches[2] or matches[1] == 'Expire' and is_sudo(msg) and matches[2] then
            local ex = redis:ttl("charged:"..matches[2])
            if ex == -1 then
                return "نامحدود!"
            else
                local d = math.floor(ex / day ) + 1
                return d.." روز تا انقضا گروه باقی مانده"
            end
        end
    end
	if is_sudo(msg) then
        if matches[1] == 'leave' and matches[2] or  matches[1] == 'Leave' and matches[2] then
            tdcli.sendMessage(matches[2], 0, 1, "ربات به دلایلی گروه را ترک میکند\nبرای اطلاعات بیشتر میتوانید با @Tele_Sudo در ارتباط باشید.\nدر صورت ریپورت بودن میتوانید با ربات زیر به ما پیام دهید\n\n\nChannel> @LuaError", 1, 'html')
            tdcli.changeChatMemberStatus(matches[2], our_id, 'Left', dl_cb, nil)
            return tdcli.sendMessage(msg.to.id, msg.id, 1, 'ربات با موفقیت از گروه '..matches[2]..' خارج شد.', 1,'html')
        end
        if matches[1] == 'plan' and matches[2] == '1' and matches[3] or  matches[1] == 'Plan' and matches[2] == '1' and matches[3] then
            local timeplan1 = 2592000
            redis:setex("charged:"..matches[3],timeplan1,true)
            tdcli.sendMessage(msg.to.id, msg.id, 1, 'پلن 1 با موفقیت برای گروه '..matches[3]..' فعال شد\nاین گروه تا 30 روز دیگر اعتبار دارد! ( 1 ماه )', 1, 'html')
            tdcli.sendMessage(matches[3], 0, 1, "ربات با موفقیت فعال شد و تا 30 روز دیگر اعتبار دارد!", 1, 'html')
        end
        if matches[1] == 'plan' and matches[2] == '2' and matches[3] or  matches[1] == 'Plan' and matches[2] == '2' and matches[3] then
            local timeplan2 = 7776000
            redis:setex("charged:"..matches[3],timeplan2,true)
            tdcli.sendMessage(msg.to.id, msg.id, 1, 'پلن 2 با موفقیت برای گروه '..matches[3]..' فعال شد\nاین گروه تا 90 روز دیگر اعتبار دارد! ( 3 ماه )', 1, 'html')
            tdcli.sendMessage(matches[3], 0, 1, "ربات با موفقیت فعال شد و تا 90 روز دیگر اعتبار دارد! ( 3 ماه )", 1, 'html')
        end
        if matches[1] == 'plan' and matches[2] == '3' and matches[3] or matches[1] == 'Plan' and matches[2] == '3' and matches[3] then
            redis:set("charged:"..matches[3],true)
            tdcli.sendMessage(msg.to.id, msg.id, 1, 'پلن 3 با موفقیت برای گروه '..matches[3]..' فعال شد\nاین گروه به صورت نامحدود شارژ شد!', 1, 'html')
            tdcli.sendMessage(matches[3], 0, 1, "ربات بدون محدودیت فعال شد ! ( نامحدود )", 1, 'html')
        end
        if matches[1] == 'join' and matches[2] == '91752' and matches[3] or matches[1] == 'Join' and matches[2] == '91752' and matches[3] then
            local sudo = 377450049 --ID SUDO
            tdcli.sendMessage(sudo, msg.id, 1, 'با موفقیت تورو به گروه '..matches[3]..' اضافه کردم.', 1, 'html')
            tdcli.sendMessage(matches[3], 0, 1, "Admin Joined!🌚", 1, 'html')
            tdcli.addChatMember(matches[3], sudo, 0, dl_cb, nil)
        end
        if matches[1] == "setexpire" and matches[2] and matches[3] or  matches[1] == "Setexpire" and matches[2] and matches[3]then
            local time = matches[3] * day
            redis:setex("charged:"..matches[2],time,true)
            local gp = matches[2]
            tdcli.sendMessage(msg.to.id, msg.id, 1, 'ربات با موفقیت تنظیم شد\nمدت فعال بودن ربات در گروه به '..matches[3]..' روز دیگر تنظیم شد...', 1, 'html')
            tdcli.sendMessage(gp, 0, 1, "ربات توسط ادمین به مدت <code>"..matches[3].."</code> روز شارژ شد\nبرای فعال شدن ربات در گروه از دستور /check استفاده کنید...", 1, 'html')
            tdcli.sendMessage(gp, 0, 1, "ربات توسط ادمین به مدت <code>"..matches[3].."</code> روز شارژ شد\nبرای فعال شدن ربات در گروه از دستور /check استفاده کنید...",1 , 'html')
        end
    else
        return  tdcli.sendMessage(msg.to.id, msg.id,'<code>فقط سازنده ربات میتواند از دستورات مدیریتی گروه های دیگر استفاده کند!</code>', 1, 'html')
    end
    if matches[1] == "rem" and is_admin(msg) then
        redis:del("charged:"..msg.to.id)
    end
end


return {
patterns = {
"^[!/#]([Ee]xpire)$",
"^([Ee]xpire)$",
"^[!/#]([Ee]xpire) (.*)$",
"^([Ee]xpire) (.*)$",
"^[!/#]([Ss]etexpire) (.*) (%d+)$",
"^([Ss]etexpire) (.*) (%d+)$",
"^[!/#]([Ss]etexpire) (%d+)$",
"^([Ss]etexpire) (%d+)$",
"^[!/#]([Jj]oin)(91752)(.*)$",
"^([Jj]oin)(91752)(.*)$",
"^[!/#]([Ll]eave) (.*)$",
"^([Ll]eave) (.*)$",
"^[!/#]([Pp]lan)([123])(.*)$",
"^([Pp]lan)([123])(.*)$",
"^[!/#]([Rr]em)$",
"^([Rr]em)$"
},
run = run,
pre_process = pre_process
}
--EnD Expire.lua--