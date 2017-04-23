--Begin GroupManager.lua By @MahDiRoO
local function modadd(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
    if not is_admin(msg) then
   if not lang then
        return '_You are not bot admin_'
else
     return 'شما مدیر ربات نمیباشید'
    end
end
    local data = load_data(_config.moderation.data)
  if data[tostring(msg.to.id)] then
if not lang then
   return '_Group is already added_'
else
return 'گروه در لیست گروه های مدیریتی ربات هم اکنون موجود است'
  end
end
        -- create data array in moderation.json
      data[tostring(msg.to.id)] = {
              owners = {},
      mods ={},
      banned ={},
      is_silent_users ={},
      filterlist ={},
      settings = {
          set_name = msg.to.title,
          lock_link = 'yes',
          lock_tag = 'yes',
          lock_spam = 'yes',
          lock_webpage = 'no',
          lock_markdown = 'no',
		  lock_mention = 'no',
		  lock_arabic = 'no',
		  lock_edit = 'yes',
          flood = 'yes',
          lock_bots = 'yes',
          lock_pin = 'no',
          welcome = 'no',
				   english = 'no',
				   views = 'no',
				   emoji ='no',
				   ads = 'no',
				   fosh = 'no'
				   
          },
		  mute = {
		    mute_fwd = 'no',
                  mute_audio = 'no',
                  mute_video = 'no',
                  mute_contact = 'no',
                  mute_text = 'no',
                  mute_photos = 'no',
                  mute_gif = 'no',
                  mute_loc = 'no',
                  mute_doc = 'no',
                  mute_sticker = 'no',
                  mute_voice = 'no',
                   mute_all = 'no',
				   mute_keyboard = 'no'
		  }
      }
  save_data(_config.moderation.data, data)
      local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = {}
        save_data(_config.moderation.data, data)
      end
      data[tostring(groups)][tostring(msg.to.id)] = msg.to.id
      save_data(_config.moderation.data, data)
    if not lang then
  return '*Group has been added*'
else
  return 'گروه با موفقیت به لیست گروه های مدیریتی ربات افزوده شد'
end
end

local function modrem(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    -- superuser and admins only (because sudo are always has privilege)
      if not is_admin(msg) then
     if not lang then
        return '_You are not bot admin_'
   else
        return 'شما مدیر ربات نمیباشید'
    end
   end
    local data = load_data(_config.moderation.data)
    local receiver = msg.to.id
  if not data[tostring(msg.to.id)] then
  if not lang then
    return '_Group is not added_'
else
    return 'گروه به لیست گروه های مدیریتی ربات اضافه نشده است'
   end
  end

  data[tostring(msg.to.id)] = nil
  save_data(_config.moderation.data, data)
     local groups = 'groups'
      if not data[tostring(groups)] then
        data[tostring(groups)] = nil
        save_data(_config.moderation.data, data)
      end data[tostring(groups)][tostring(msg.to.id)] = nil
      save_data(_config.moderation.data, data)
 if not lang then
  return '*Group has been removed*'
 else
  return 'گروه با موفیت از لیست گروه های مدیریتی ربات حذف شد'
end
end

local function filter_word(msg, word)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
if data[tostring(msg.to.id)]['filterlist'][(word)] then
   if not lang then
         return "_Word_ *"..word.."* _is already filtered_"
            else
         return "_کلمه_ *"..word.."* _از قبل فیلتر بود_"
    end
end
   data[tostring(msg.to.id)]['filterlist'][(word)] = true
     save_data(_config.moderation.data, data)
   if not lang then
         return "_Word_ *"..word.."* _added to filtered words list_"
            else
         return "_کلمه_ *"..word.."* _به لیست کلمات فیلتر شده اضافه شد_"
    end
end

local function unfilter_word(msg, word)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 local data = load_data(_config.moderation.data)
  if not data[tostring(msg.to.id)]['filterlist'] then
    data[tostring(msg.to.id)]['filterlist'] = {}
    save_data(_config.moderation.data, data)
    end
      if data[tostring(msg.to.id)]['filterlist'][word] then
      data[tostring(msg.to.id)]['filterlist'][(word)] = nil
       save_data(_config.moderation.data, data)
       if not lang then
         return "_Word_ *"..word.."* _removed from filtered words list_"
       elseif lang then
         return "_کلمه_ *"..word.."* _از لیست کلمات فیلتر شده حذف شد_"
     end
      else
       if not lang then
         return "_Word_ *"..word.."* _is not filtered_"
       elseif lang then
         return "_کلمه_ *"..word.."* _از قبل فیلتر نبود_"
      end
   end
end

local function modlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.chat_id_)] then
  if not lang then
    return "_Group is not added_"
 else
    return "گروه به لیست گروه های مدیریتی ربات اضافه نشده است"
  end
 end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['mods']) == nil then --fix way
  if not lang then
    return "_No_ *moderator* _in this group_"
else
   return "در حال حاضر هیچ مدیری برای گروه انتخاب نشده است"
  end
end
if not lang then
   message = '*List of moderators :*\n'
else
   message = '*لیست مدیران گروه :*\n'
end
  for k,v in pairs(data[tostring(msg.to.id)]['mods'])
do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function ownerlist(msg)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
    local data = load_data(_config.moderation.data)
    local i = 1
  if not data[tostring(msg.to.id)] then
if not lang then
    return "_Group is not added_"
else
return "گروه به لیست گروه های مدیریتی ربات اضافه نشده است"
  end
end
  -- determine if table is empty
  if next(data[tostring(msg.to.id)]['owners']) == nil then --fix way
 if not lang then
    return "_No_ *owner* _in this group_"
else
    return "در حال حاضر هیچ مالکی برای گروه انتخاب نشده است"
  end
end
if not lang then
   message = '*List of moderators :*\n'
else
   message = '*لیست مالکین گروه :*\n'
end
  for k,v in pairs(data[tostring(msg.to.id)]['owners']) do
    message = message ..i.. '- '..v..' [' ..k.. '] \n'
   i = i + 1
end
  return message
end

local function action_by_reply(arg, data)
local hash = "gp_lang:"..data.chat_id_
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
if not tonumber(data.sender_user_id_) then return false end
    if data.sender_user_id_ then
  if not administration[tostring(data.chat_id_)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "_Group is not added_", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_گروه به لیست گروه های مدیریتی ربات اضافه نشده است_", 0, "md")
     end
  end
if cmd == "setowner" then
local function owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *group owner*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل صاحب گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now the_ *group owner*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *به مقام صاحب گروه منتصب شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "promote" then
local function promote_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *moderator*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل مدیر گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *promoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *به مقام مدیر گروه منتصب شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, promote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
     if cmd == "remowner" then
local function rem_owner_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *group owner*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *از قبل صاحب گروه نبود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer a_ *group owner*", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از مقام صاحب گروه برکنار شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, rem_owner_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "demote" then
local function demote_cb(arg, data)
    local administration = load_data(_config.moderation.data)
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *moderator*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل مدیر گروه نبود*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *demoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از مقام مدیر گروه برکنار شد*", 0, "md")
   end
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, demote_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
    if cmd == "id" then
local function id_cb(arg, data)
    return tdcli.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
tdcli_function ({
    ID = "GetUser",
    user_id_ = data.sender_user_id_
  }, id_cb, {chat_id=data.chat_id_,user_id=data.sender_user_id_})
  end
else
    if lang then
  return tdcli.sendMessage(data.chat_id_, "", 0, "__", 0, "md")
   else
  return tdcli.sendMessage(data.chat_id_, "", 0, "**", 0, "md")
      end
   end
end

local function action_by_username(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "_Group is not added_", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_گروه به لیست گروه های مدیریتی ربات اضافه نشده است_", 0, "md")
     end
  end
if not arg.username then return false end
   if data.id_ then
if data.type_.user_.username_ then
user_name = '@'..check_markdown(data.type_.user_.username_)
else
user_name = check_markdown(data.title_)
end
if cmd == "setowner" then
if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *group owner*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل صاحب گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now the_ *group owner*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *به مقام صاحب گروه منتصب شد*", 0, "md")
   end
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *moderator*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل مدیر گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *promoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *به مقام مدیر گروه منتصب شد*", 0, "md")
   end
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *group owner*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *از قبل صاحب گروه نبود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer a_ *group owner*", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از مقام صاحب گروه برکنار شد*", 0, "md")
   end
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *moderator*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل مدیر گروه نبود*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *demoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از مقام مدیر گروه برکنار شد*", 0, "md")
   end
end
   if cmd == "id" then
    return tdcli.sendMessage(arg.chat_id, "", 0, "*"..data.id_.."*", 0, "md")
end
    if cmd == "res" then
    if not lang then
     text = "Result for [ "..check_markdown(data.type_.user_.username_).." ] :\n"
    .. ""..check_markdown(data.title_).."\n"
    .. " ["..data.id_.."]"
  else
     text = "اطلاعات برای [ "..check_markdown(data.type_.user_.username_).." ] :\n"
    .. "".. check_markdown(data.title_) .."\n"
    .. " [".. data.id_ .."]"
         end
       return tdcli.sendMessage(arg.chat_id, 0, 1, text, 1, 'md')
   end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر یافت نشد_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*User Not Found*", 0, "md")
      end
   end
end

local function action_by_id(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
local cmd = arg.cmd
    local administration = load_data(_config.moderation.data)
  if not administration[tostring(arg.chat_id)] then
  if not lang then
    return tdcli.sendMessage(data.chat_id_, "", 0, "_Group is not added_", 0, "md")
else
    return tdcli.sendMessage(data.chat_id_, "", 0, "_گروه به لیست گروه های مدیریتی ربات اضافه نشده است_", 0, "md")
     end
  end
if not tonumber(arg.user_id) then return false end
   if data.id_ then
if data.first_name_ then
if data.username_ then
user_name = '@'..check_markdown(data.username_)
else
user_name = check_markdown(data.first_name_)
end
  if cmd == "setowner" then
  if administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *group owner*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل صاحب گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is now the_ *group owner*", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *به مقام صاحب گروه منتصب شد*", 0, "md")
   end
end
  if cmd == "promote" then
if administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is already a_ *moderator*", 0, "md")
else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل مدیر گروه بود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = user_name
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *promoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *به مقام مدیر گروه منتصب شد*", 0, "md")
   end
end
   if cmd == "remowner" then
if not administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] then
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *group owner*", 0, "md")
   else
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* *از قبل صاحب گروه نبود*", 0, "md")
      end
   end
administration[tostring(arg.chat_id)]['owners'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is no longer a_ *group owner*", 0, "md")
    else
return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از مقام صاحب گروه برکنار شد*", 0, "md")
   end
end
   if cmd == "demote" then
if not administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] then
    if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _is not a_ *moderator*", 0, "md")
    else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از قبل مدیر گروه نبود*", 0, "md")
   end
  end
administration[tostring(arg.chat_id)]['mods'][tostring(data.id_)] = nil
    save_data(_config.moderation.data, administration)
   if not lang then
    return tdcli.sendMessage(arg.chat_id, "", 0, "_User_ "..user_name.." *"..data.id_.."* _has been_ *demoted*", 0, "md")
   else
    return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر_ "..user_name.." *"..data.id_.."* *از مقام مدیر گروه برکنار شد*", 0, "md")
   end
end
    if cmd == "whois" then
if data.username_ then
username = '@'..check_markdown(data.username_)
else
if not lang then
username = 'not found'
 else
username = 'ندارد'
  end
end
     if not lang then
       return tdcli.sendMessage(arg.chat_id, 0, 1, 'Info for [ '..data.id_..' ] :\nUserName : '..username..'\nName : '..data.first_name_, 1)
   else
       return tdcli.sendMessage(arg.chat_id, 0, 1, 'اطلاعات برای [ '..data.id_..' ] :\nیوزرنیم : '..username..'\nنام : '..data.first_name_, 1)
      end
   end
 else
    if not lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_User not founded_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر یافت نشد_", 0, "md")
    end
  end
else
    if lang then
  return tdcli.sendMessage(arg.chat_id, "", 0, "_کاربر یافت نشد_", 0, "md")
   else
  return tdcli.sendMessage(arg.chat_id, "", 0, "*User Not Found*", 0, "md")
      end
   end
end


---------------Lock Link-------------------
local function lock_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_link = data[tostring(target)]["settings"]["lock_link"] 
if lock_link == "yes" then
if not lang then
 return "#Link _Posting Is Already Locked_"
elseif lang then
 return "ارسال #لینک در گروه هم اکنون ممنوع است🔒"
end
else
data[tostring(target)]["settings"]["lock_link"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "#Link _Posting Has Been Locked_"
else
 return "ارسال #لینک در گروه ممنوع شد🔒"
end
end
end

local function unlock_link(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local lock_link = data[tostring(target)]["settings"]["lock_link"]
 if lock_link == "no" then
if not lang then
return "#Link _Posting Is Not Locked_" 
elseif lang then
return "ارسال #لینک در گروه ممنوع نمیباشد🔓"
end
else 
data[tostring(target)]["settings"]["lock_link"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "#Link _Posting Has Been Unlocked_" 
else
return "ارسال #لینک در گروه آزاد شد🔓"
end
end
end

---------------Lock Tag-------------------
local function lock_tag(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"] 
if lock_tag == "yes" then
if not lang then
 return "#Tag _Posting Is Already Locked_"
elseif lang then
 return "ارسال #تگ در گروه هم اکنون ممنوع است🔒"
end
else
 data[tostring(target)]["settings"]["lock_tag"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "#Tag _Posting Has Been Locked_"
else
 return "ارسال #تگ در گروه ممنوع شد🔒"
end
end
end

local function unlock_tag(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end 
end

local lock_tag = data[tostring(target)]["settings"]["lock_tag"]
 if lock_tag == "no" then
if not lang then
return "#Tag _Posting Is Not Locked_" 
elseif lang then
return "ارسال #تگ در گروه ممنوع نمیباشد🔓"
end
else 
data[tostring(target)]["settings"]["lock_tag"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "#Tag _Posting Has Been Unlocked_" 
else
return "ارسال #تگ در گروه آزاد شد🔓"
end
end
end

---------------Lock Vewis-------------------
local function lock_views(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_views = data[tostring(target)]["settings"]["views"] 
if lock_views == "yes" then
if not lang then
 return "#Views _Posting Is Already Locked_"
elseif lang then
 return "ارسال #پست ویو دار در گروه هم اکنون ممنوع است🔒"
end
else
 data[tostring(target)]["settings"]["views"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "#Views _Posting Has Been Locked_"
else
 return "ارسال #پست ویو دار در گروه ممنوع شد🔒"
end
end
end

local function unlock_views(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end 
end

local lock_views = data[tostring(target)]["settings"]["views"]
 if lock_views == "no" then
if not lang then
return "#Views _Posting Is Not Locked_" 
elseif lang then
return "ارسال #پست ویو دار در گروه ممنوع نمیباشد🔓"
end
else 
data[tostring(target)]["settings"]["views"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "#Views _Posting Has Been Unlocked_" 
else
return "ارسال #پست ویو دار در گروه آزاد شد🔓"
end
end
end


---------------Lock English-------------------
local function lock_english(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_english = data[tostring(target)]["settings"]["english"] 
if lock_english == "yes" then
if not lang then
 return "#English _Posting Is Already Locked_"
elseif lang then
 return "ارسال #نوشته انگلیسی در گروه هم اکنون ممنوع است🔒"
end
else
 data[tostring(target)]["settings"]["english"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "#English _Posting Has Been Locked_"
else
 return "ارسال #نوشته انگلیسی در گروه ممنوع شد🔒"
end
end
end

local function unlock_english(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end 
end

local lock_english = data[tostring(target)]["settings"]["english"]
 if lock_english == "no" then
if not lang then
return "#English _Posting Is Not Locked_" 
elseif lang then
return "ارسال #نوشته انگلیسی در گروه ممنوع نمیباشد🔓"
end
else 
data[tostring(target)]["settings"]["english"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "#English _Posting Has Been Unlocked_" 
else
return "ارسال #نوشته انگلیسی در گروه آزاد شد🔓"
end
end
end

---------------Lock Ads-------------------
local function lock_ads(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_ads = data[tostring(target)]["settings"]["ads"] 
if lock_ads == "yes" then
if not lang then
 return "#Ads _Posting Is Already Locked_"
elseif lang then
 return "ارسال #تبلیغات در گروه هم اکنون ممنوع است🔒"
end
else
 data[tostring(target)]["settings"]["ads"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "#Ads _Posting Has Been Locked_"
else
 return "ارسال #تبلیغات در گروه ممنوع شد🔒"
end
end
end

local function unlock_ads(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end 
end

local lock_ads = data[tostring(target)]["settings"]["ads"]
 if lock_ads == "no" then
if not lang then
return "#ads _Posting Is Not Locked_" 
elseif lang then
return "ارسال #تبلیغات در گروه ممنوع نمیباشد🔓"
end
else 
data[tostring(target)]["settings"]["ads"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "#Ads _Posting Has Been Unlocked_" 
else
return "ارسال #تبلیغات در گروه آزاد شد🔓"
end
end
end

---------------Lock Fosh-------------------
local function lock_fosh(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_fosh = data[tostring(target)]["settings"]["fosh"] 
if lock_fosh == "yes" then
if not lang then
 return "#Fosh _Posting Is Already Locked_"
elseif lang then
 return "ارسال #کلمات رکیک در گروه هم اکنون ممنوع است🔒"
end
else
 data[tostring(target)]["settings"]["fosh"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "#Fosh _Posting Has Been Locked_"
else
 return "ارسال #کلمات رکیک در گروه ممنوع شد🔒"
end
end
end

local function unlock_fosh(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end 
end

local lock_fosh = data[tostring(target)]["settings"]["english"]
 if lock_fosh == "no" then
if not lang then
return "#Fosh _Posting Is Not Locked_" 
elseif lang then
return "ارسال #کلمات رکیک در گروه ممنوع نمیباشد🔓"
end
else 
data[tostring(target)]["settings"]["fosh"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "#Fosh _Posting Has Been Unlocked_" 
else
return "ارسال #کلمات رکیک در گروه آزاد شد🔓"
end
end
end

---------------Lock Emoji-------------------
local function lock_emoji(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_emoji = data[tostring(target)]["settings"]["emoji"] 
if lock_emoji == "yes" then
if not lang then
 return "#Emoji _Posting Is Already Locked_"
elseif lang then
 return "ارسال #نوشته امجودار در گروه هم اکنون ممنوع است🔒"
end
else
 data[tostring(target)]["settings"]["emoji"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "#Emoji _Posting Has Been Locked_"
else
 return "ارسال #نوشته امجودار در گروه ممنوع شد🔒"
end
end
end

local function unlock_emoji(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end 
end

local lock_emoji = data[tostring(target)]["settings"]["emoji"]
 if lock_emoji == "no" then
if not lang then
return "#Emoji _Posting Is Not Locked_" 
elseif lang then
return "ارسال #نوشته امجودار در گروه ممنوع نمیباشد🔓"
end
else 
data[tostring(target)]["settings"]["emoji"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "#Emoji _Posting Has Been Unlocked_" 
else
return "ارسال #نوشته امجودار در گروه آزاد شد🔓"
end
end
end

---------------Lock Mention-------------------
local function lock_mention(msg, data, target)
 local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_mention = data[tostring(target)]["settings"]["lock_mention"] 
if lock_mention == "yes" then
if not lang then
 return "#Mention _Posting Is Already Locked_"
elseif lang then
 return "ارسال #فراخوانی افراد هم اکنون ممنوع است🔒"
end
else
 data[tostring(target)]["settings"]["lock_mention"] = "yes"
save_data(_config.moderation.data, data)
if not lang then 
 return "#Mention _Posting Has Been Locked_"
else 
 return "ارسال #فراخوانی افراد در گروه ممنوع شد🔒"
end
end
end

local function unlock_mention(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local lock_mention = data[tostring(target)]["settings"]["lock_mention"]
 if lock_mention == "no" then
if not lang then
return "#Mention _Posting Is Not Locked_" 
elseif lang then
return "ارسال #فراخوانی افراد در گروه ممنوع نمیباشد🔓"
end
else 
data[tostring(target)]["settings"]["lock_mention"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "#Mention _Posting Has Been Unlocked_" 
else
return "ارسال #فراخوانی افراد در گروه آزاد شد🔓"
end
end
end

---------------Lock Arabic--------------
local function lock_arabic(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_arabic = data[tostring(target)]["settings"]["lock_arabic"] 
if lock_arabic == "yes" then
if not lang then
 return "#Arabic.Persian _Posting Is Already Locked_"
elseif lang then
 return "ارسال #کلمات عربی/فارسی در گروه هم اکنون ممنوع است🔒"
end
else
data[tostring(target)]["settings"]["lock_arabic"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "#Arabic.Persian _Posting Has Been Locked_"
else
 return "ارسال #کلمات عربی/فارسی در گروه ممنوع شد🔒"
end
end
end

local function unlock_arabic(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local lock_arabic = data[tostring(target)]["settings"]["lock_arabic"]
 if lock_arabic == "no" then
if not lang then
return "#Arabic.Persian _Posting Is Not Locked_" 
elseif lang then
return "ارسال #کلمات عربی/فارسی در گروه ممنوع نمیباشد🔓"
end
else 
data[tostring(target)]["settings"]["lock_arabic"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "#Arabic.Persian _Posting Has Been Unlocked_" 
else
return "ارسال #کلمات عربی/فارسی در گروه آزاد شد🔓"
end
end
end

---------------Lock Edit-------------------
local function lock_edit(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_edit = data[tostring(target)]["settings"]["lock_edit"] 
if lock_edit == "yes" then
if not lang then
 return "#Editing _Is Already Locked_"
elseif lang then
 return "ویرایش پیام هم اکنون ممنوع است🔒"
end
else
 data[tostring(target)]["settings"]["lock_edit"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "#Editing _Has Been Locked_"
else
 return "ویرایش پیام در گروه ممنوع شد🔒"
end
end
end

local function unlock_edit(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local lock_edit = data[tostring(target)]["settings"]["lock_edit"]
 if lock_edit == "no" then
if not lang then
return "#Editing _Is Not Locked_" 
elseif lang then
return "ویرایش پیام در گروه ممنوع نمیباشد🔓"
end
else 
data[tostring(target)]["settings"]["lock_edit"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "#Editing _Has Been Unlocked_" 
else
return "ویرایش پیام در گروه آزاد شد🔓"
end
end
end

---------------Lock spam-------------------
local function lock_spam(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_spam = data[tostring(target)]["settings"]["lock_spam"] 
if lock_spam == "yes" then
if not lang then
 return "#Spam _Is Already Locked_"
elseif lang then
 return "ارسال #هرزنامه در گروه هم اکنون ممنوع است🔒"
end
else
 data[tostring(target)]["settings"]["lock_spam"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "#Spam _Has Been Locked_"
else
 return "ارسال #هرزنامه در گروه ممنوع شد🔒"
end
end
end

local function unlock_spam(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local lock_spam = data[tostring(target)]["settings"]["lock_spam"]
 if lock_spam == "no" then
if not lang then
return "#Spam _Posting Is Not Locked_" 
elseif lang then
 return "ارسال #هرزنامه در گروه ممنوع نمیباشد🔓"
end
else 
data[tostring(target)]["settings"]["lock_spam"] = "no" 
save_data(_config.moderation.data, data)
if not lang then 
return "#Spam _Posting Has Been Unlocked_" 
else
 return "ارسال #هرزنامه در گروه آزاد شد🔓"
end
end
end

---------------Lock Flood-------------------
local function lock_flood(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_flood = data[tostring(target)]["settings"]["flood"] 
if lock_flood == "yes" then
if not lang then
 return "#Flooding _Is Already Locked_"
elseif lang then
 return "ارسال #پیام مکرر در گروه هم اکنون ممنوع است🔒"
end
else
 data[tostring(target)]["settings"]["flood"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "#Flooding _Has Been Locked_"
else
 return "ارسال #پیام مکرر در گروه ممنوع شد🔒"
end
end
end

local function unlock_flood(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local lock_flood = data[tostring(target)]["settings"]["flood"]
 if lock_flood == "no" then
if not lang then
return "#Flooding _Is Not Locked_" 
elseif lang then
return "ارسال #پیام مکرر در گروه ممنوع نمیباشد🔓"
end
else 
data[tostring(target)]["settings"]["flood"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "#Flooding _Has Been Unlocked_" 
else
return "ارسال #پیام مکرر در گروه آزاد شد🔓"
end
end
end

---------------Lock Bots-------------------
local function lock_bots(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"] 
if lock_bots == "yes" then
if not lang then
 return "#Bots _Protection Is Already Enabled_"
elseif lang then
 return "محافظت از گروه در برابر #ربات ها هم اکنون فعال است🔒"
end
else
 data[tostring(target)]["settings"]["lock_bots"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "#Bots _Protection Has Been Enabled_"
else
 return "محافظت از گروه در برابر #ربات ها فعال شد🔒"
end
end
end

local function unlock_bots(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end 
end

local lock_bots = data[tostring(target)]["settings"]["lock_bots"]
 if lock_bots == "no" then
if not lang then
return "#Bots _Protection Is Not Enabled_" 
elseif lang then
return "محافظت از گروه در برابر #ربات ها غیر فعال است🔓"
end
else 
data[tostring(target)]["settings"]["lock_bots"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "#Bots _Protection Has Been Disabled_" 
else
return "محافظت از گروه در برابر #ربات ها غیر فعال شد🔓"
end
end
end

---------------Lock Markdown-------------------
local function lock_markdown(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"] 
if lock_markdown == "yes" then
if not lang then 
 return "#Markdown _Posting Is Already Locked_"
elseif lang then
 return "ارسال #پیام های دارای فونت در گروه هم اکنون ممنوع است🔒"
end
else
 data[tostring(target)]["settings"]["lock_markdown"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "#Markdown _Posting Has Been Locked_"
else
 return "ارسال #پیام های دارای فونت در گروه ممنوع شد🔒"
end
end
end

local function unlock_markdown(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end 
end

local lock_markdown = data[tostring(target)]["settings"]["lock_markdown"]
 if lock_markdown == "no" then
if not lang then
return "#Markdown _Posting Is Not Locked_"
elseif lang then
return "ارسال #پیام های دارای فونت در گروه ممنوع نمیباشد🔓"
end
else 
data[tostring(target)]["settings"]["lock_markdown"] = "no" save_data(_config.moderation.data, data) 
if not lang then
return "#Markdown _Posting Has Been Unlocked_"
else
return "ارسال #پیام های دارای فونت در گروه آزاد شد🔓"
end
end
end

---------------Lock Webpage-------------------
local function lock_webpage(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"] 
if lock_webpage == "yes" then
if not lang then
 return "#Webpage _Is Already Locked_"
elseif lang then
 return "ارسال #صفحات وب در گروه هم اکنون ممنوع است🔒"
end
else
 data[tostring(target)]["settings"]["lock_webpage"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "#Webpage _Has Been Locked_"
else
 return "ارسال #صفحات وب در گروه ممنوع شد🔒"
end
end
end

local function unlock_webpage(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end 
end

local lock_webpage = data[tostring(target)]["settings"]["lock_webpage"]
 if lock_webpage == "no" then
if not lang then
return "#Webpage _Is Not Locked_" 
elseif lang then
return "ارسال #صفحات وب در گروه ممنوع نمیباشد🔓"
end
else 
data[tostring(target)]["settings"]["lock_webpage"] = "no"
save_data(_config.moderation.data, data) 
if not lang then
return "#Webpage _Has Been Unlocked_" 
else
return "ارسال #صفحات وب در گروه آزاد شد🔓"
end
end
end

---------------Lock Pin-------------------
local function lock_pin(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"] 
if lock_pin == "yes" then
if not lang then
 return "#Pinned Message _Is Already Locked_"
elseif lang then
 return "سنجاق کردن پیام در گروه هم اکنون ممنوع است🔒"
end
else
 data[tostring(target)]["settings"]["lock_pin"] = "yes"
save_data(_config.moderation.data, data) 
if not lang then
 return "#Pinned Message _Has Been Locked_"
else
 return "سنجاق کردن پیام در گروه ممنوع شد🔒"
end
end
end

local function unlock_pin(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end 
end

local lock_pin = data[tostring(target)]["settings"]["lock_pin"]
 if lock_pin == "no" then
if not lang then
return "#Pinned Message _Is Not Locked_" 
elseif lang then
return "سنجاق کردن پیام در گروه ممنوع نمیباشد🔓"
end
else 
data[tostring(target)]["settings"]["lock_pin"] = "no"
save_data(_config.moderation.data, data) 
if not lang then
return "#Pinned Message _Has Been Unlocked_" 
else
return "سنجاق کردن پیام در گروه آزاد شد🔓"
end
end
end

--------Mutes---------
--------Mute all--------------------------
local function mute_all(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then 
if not lang then
return "_You're Not_ *Moderator*" 
else
return "شما مدیر گروه نمیباشید"
end
end

local mute_all = data[tostring(target)]["settings"]["mute_all"] 
if mute_all == "yes" then 
if not lang then
return "#Mute All _Is Already Enabled_" 
elseif lang then
return "بیصدا کردن #همه فعال است🔇"
end
else 
data[tostring(target)]["settings"]["mute_all"] = "yes"
 save_data(_config.moderation.data, data) 
if not lang then
return "#Mute All _Has Been Enabled_" 
else
return "بیصدا کردن #همه فعال شد🔇"
end
end
end

local function unmute_all(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then 
if not lang then
return "_You're Not_ *Moderator*" 
else
return "شما مدیر گروه نمیباشید"
end
end

local mute_all = data[tostring(target)]["settings"]["mute_all"] 
if mute_all == "no" then 
if not lang then
return "#Mute All _Is Already Disabled_" 
elseif lang then
return "بیصدا کردن #همه غیر فعال است🔊"
end
else 
data[tostring(target)]["settings"]["mute_all"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "#Mute All _Has Been Disabled_" 
else
return "بیصدا کردن #همه غیر فعال شد🔊"
end 
end
end

---------------Mute Gif-------------------
local function mute_gif(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_gif = data[tostring(target)]["settings"]["mute_gif"] 
if mute_gif == "yes" then
if not lang then
 return "#Mute Gif _Is Already Enabled_"
elseif lang then
 return "بیصدا کردن #تصاویر متحرک فعال است🔇"
end
else
 data[tostring(target)]["settings"]["mute_gif"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then 
 return "#Mute Gif _Has Been Enabled_"
else
 return "بیصدا کردن #تصاویر متحرک فعال شد🔇"
end
end
end

local function unmute_gif(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local mute_gif = data[tostring(target)]["settings"]["mute_gif"]
 if mute_gif == "no" then
if not lang then
return "#Mute Gif _Is Already Disabled_" 
elseif lang then
return "بیصدا کردن #تصاویر متحرک غیر فعال بود🔊"
end
else 
data[tostring(target)]["settings"]["mute_gif"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "#Mute Gif _Has Been Disabled_" 
else
return "بیصدا کردن #تصاویر متحرک غیر فعال شد🔊"
end
end
end
---------------Mute Game-------------------
local function mute_game(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_game = data[tostring(target)]["settings"]["mute_game"] 
if mute_game == "yes" then
if not lang then
 return "#Mute Game _Is Already Enabled_"
elseif lang then
 return "بیصدا کردن #بازی های تحت وب فعال است🔇"
end
else
 data[tostring(target)]["settings"]["mute_game"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "#Mute Game _Has Been Enabled_"
else
 return "بیصدا کردن #بازی های تحت وب فعال شد🔇"
end
end
end

local function unmute_game(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end 
end

local mute_game = data[tostring(target)]["settings"]["mute_game"]
 if mute_game == "no" then
if not lang then
return "*Mute Game _Is Already Disabled_" 
elseif lang then
return "بیصدا کردن #بازی های تحت وب غیر فعال است🔊"
end
else 
data[tostring(target)]["settings"]["mute_game"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "#Mute Game _Has Been Disabled_" 
else
return "بیصدا کردن #بازی های تحت وب غیر فعال شد🔊"
end
end
end
---------------Mute Inline-------------------
local function mute_inline(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_inline = data[tostring(target)]["settings"]["mute_inline"] 
if mute_inline == "yes" then
if not lang then
 return "#Mute Inline _Is Already Enabled_"
elseif lang then
 return "بیصدا کردن #کیبورد شیشه ای فعال است🔇"
end
else
 data[tostring(target)]["settings"]["mute_inline"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "#Mute Inline _Has Been Enabled_"
else
 return "بیصدا کردن #کیبورد شیشه ای فعال شد🔇"
end
end
end

local function unmute_inline(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local mute_inline = data[tostring(target)]["settings"]["mute_inline"]
 if mute_inline == "no" then
if not lang then
return "#Mute Inline _Is Already Disabled_" 
elseif lang then
return "بیصدا کردن #کیبورد شیشه ای غیر فعال است🔊"
end
else 
data[tostring(target)]["settings"]["mute_inline"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "#Mute Inline _Has Been Disabled_" 
else
return "بیصدا کردن #کیبورد شیشه ای غیر فعال شد🔊"
end
end
end
---------------Mute Text-------------------
local function mute_text(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_text = data[tostring(target)]["settings"]["mute_text"] 
if mute_text == "yes" then
if not lang then
 return "#Mute Text _Is Already Enabled_"
elseif lang then
 return "بیصدا کردن #متن فعال است🔇"
end
else
 data[tostring(target)]["settings"]["mute_text"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "#Mute Text _Has Been Enabled_"
else
 return "بیصدا کردن #متن فعال شد🔇"
end
end
end

local function unmute_text(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end 
end

local mute_text = data[tostring(target)]["settings"]["mute_text"]
 if mute_text == "no" then
if not lang then
return "#Mute Text _Is Already Disabled_"
elseif lang then
return "بیصدا کردن #متن غیر فعال است🔊" 
end
else 
data[tostring(target)]["settings"]["mute_text"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "#Mute Text _Has Been Disabled_" 
else
return "بیصدا کردن متن غیر فعال شد🔊"
end
end
end
---------------Mute photo-------------------
local function mute_photo(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_photo = data[tostring(target)]["settings"]["mute_photo"] 
if mute_photo == "yes" then
if not lang then
 return "#Mute Photo _Is Already Enabled_"
elseif lang then
 return "بیصدا کردن #عکس فعال است🔇"
end
else
 data[tostring(target)]["settings"]["mute_photo"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "#Mute Photo _Has Been Enabled_"
else
 return "بیصدا کردن #عکس فعال شد🔇"
end
end
end

local function unmute_photo(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end
 
local mute_photo = data[tostring(target)]["settings"]["mute_photo"]
 if mute_photo == "no" then
if not lang then
return "#Mute Photo _Is Already Disabled_" 
elseif lang then
return "بیصدا کردن #عکس غیر فعال است🔊"
end
else 
data[tostring(target)]["settings"]["mute_photo"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "#Mute Photo _Has Been Disabled_" 
else
return "بیصدا کردن #عکس غیر فعال شد🔊"
end
end
end
---------------Mute Video-------------------
local function mute_video(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_video = data[tostring(target)]["settings"]["mute_video"] 
if mute_video == "yes" then
if not lang then
 return "#Mute Video _Is Already Enabled_"
elseif lang then
 return "بیصدا کردن #فیلم فعال است🔇"
end
else
 data[tostring(target)]["settings"]["mute_video"] = "yes" 
save_data(_config.moderation.data, data)
if not lang then 
 return "#Mute Video _Has Been Enabled_"
else
 return "بیصدا کردن #فیلم فعال شد🔇"
end
end
end

local function unmute_video(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local mute_video = data[tostring(target)]["settings"]["mute_video"]
 if mute_video == "no" then
if not lang then
return "#Mute Video _Is Already Disabled_" 
elseif lang then
return "بیصدا کردن #فیلم غیر فعال است🔊"
end
else 
data[tostring(target)]["settings"]["mute_video"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "#Mute Video _Has Been Disabled_" 
else
return "بیصدا کردن #فیلم غیر فعال شد🔊"
end
end
end
---------------Mute Audio-------------------
local function mute_audio(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_audio = data[tostring(target)]["settings"]["mute_audio"] 
if mute_audio == "yes" then
if not lang then
 return "#Mute Audio _Is Already Enabled_"
elseif lang then
 return "بیصدا کردن #آهنگ فعال است🔇"
end
else
 data[tostring(target)]["settings"]["mute_audio"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "#Mute Audio _Has Been Enabled_"
else 
return "بیصدا کردن #آهنگ فعال شد🔇"
end
end
end

local function unmute_audio(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local mute_audio = data[tostring(target)]["settings"]["mute_audio"]
 if mute_audio == "no" then
if not lang then
return "#Mute Audio _Is Already Disabled_" 
elseif lang then
return "بیصدا کردن #آهنک غیر فعال است🔊"
end
else 
data[tostring(target)]["settings"]["mute_audio"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "#Mute Audio _Has Been Disabled_"
else
return "بیصدا کردن #آهنگ غیر فعال شد🔊" 
end
end
end
---------------Mute Voice-------------------
local function mute_voice(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_voice = data[tostring(target)]["settings"]["mute_voice"] 
if mute_voice == "yes" then
if not lang then
 return "#Mute Voice _Is Already Enabled_"
elseif lang then
 return "بیصدا کردن #صدا فعال است🔇"
end
else
 data[tostring(target)]["settings"]["mute_voice"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "#Mute Voice _Has Been Enabled_"
else
 return "بیصدا کردن #صدا فعال شد🔇"
end
end
end

local function unmute_voice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local mute_voice = data[tostring(target)]["settings"]["mute_voice"]
 if mute_voice == "no" then
if not lang then
return "#Mute Voice _Is Already Disabled_" 
elseif lang then
return "بیصدا کردن #صدا غیر فعال است🔊"
end
else 
data[tostring(target)]["settings"]["mute_voice"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "#Mute Voice _Has Been Disabled_" 
else
return "بیصدا کردن #صدا غیر فعال شد🔊"
end
end
end
---------------Mute Sticker-------------------
local function mute_sticker(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_sticker = data[tostring(target)]["settings"]["mute_sticker"] 
if mute_sticker == "yes" then
if not lang then
 return "#Mute Sticker _Is Already Enabled_"
elseif lang then
 return "بیصدا کردن #برچسب فعال است🔇"
end
else
 data[tostring(target)]["settings"]["mute_sticker"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "#Mute Sticker _Has Been Enabled_"
else
 return "بیصدا کردن #برچسب فعال شد🔇"
end
end
end

local function unmute_sticker(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end 
end

local mute_sticker = data[tostring(target)]["settings"]["mute_sticker"]
 if mute_sticker == "no" then
if not lang then
return "#Mute Sticker _Is Already Disabled_" 
elseif lang then
return "بیصدا کردن #برچسب غیر فعال است🔊"
end
else 
data[tostring(target)]["settings"]["mute_sticker"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "#Mute Sticker _Has Been Disabled_"
else
return "بیصدا کردن #برچسب غیر فعال شد🔊"
end 
end
end
---------------Mute Contact-------------------
local function mute_contact(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_contact = data[tostring(target)]["settings"]["mute_contact"] 
if mute_contact == "yes" then
if not lang then
 return "#Mute Contact _Is Already Enabled_"
elseif lang then
 return "بیصدا کردن #مخاطب فعال است🔇"
end
else
 data[tostring(target)]["settings"]["mute_contact"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "#Mute Contact _Has Been Enabled_"
else
 return "بیصدا کردن #مخاطب فعال شد🔇"
end
end
end

local function unmute_contact(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local mute_contact = data[tostring(target)]["settings"]["mute_contact"]
 if mute_contact == "no" then
if not lang then
return "#Mute Contact _Is Already Disabled_" 
elseif lang then
return "بیصدا کردن #مخاطب غیر فعال است🔊"
end
else 
data[tostring(target)]["settings"]["mute_contact"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "#Mute Contact _Has Been Disabled_" 
else
return "بیصدا کردن #مخاطب غیر فعال شد🔊"
end
end
end
---------------Mute Forward-------------------
local function mute_forward(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_forward = data[tostring(target)]["settings"]["mute_forward"] 
if mute_forward == "yes" then
if not lang then
 return "#Mute Forward _Is Already Enabled_"
elseif lang then
 return "بیصدا کردن #نقل قول فعال است🔇"
end
else
 data[tostring(target)]["settings"]["mute_forward"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "#Mute Forward _Has Been Enabled_"
else
 return "بیصدا کردن #نقل قول فعال شد🔇"
end
end
end

local function unmute_forward(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local mute_forward = data[tostring(target)]["settings"]["mute_forward"]
 if mute_forward == "no" then
if not lang then
return "#Mute Forward _Is Already Disabled_"
elseif lang then
return "بیصدا کردن #نقل قول غیر فعال است🔊"
end 
else 
data[tostring(target)]["settings"]["mute_forward"] = "no"
 save_data(_config.moderation.data, data)
if not lang then 
return "#Mute Forward _Has Been Disabled_" 
else
return "بیصدا کردن #نقل قول غیر فعال شد🔊"
end
end
end
---------------Mute Location-------------------
local function mute_location(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_location = data[tostring(target)]["settings"]["mute_location"] 
if mute_location == "yes" then
if not lang then
 return "#Mute Location _Is Already Enabled_"
elseif lang then
 return "بیصدا کردن #موقعیت فعال است🔇"
end
else
 data[tostring(target)]["settings"]["mute_location"] = "yes" 
save_data(_config.moderation.data, data)
if not lang then
 return "#Mute Location _Has Been Enabled_"
else
 return "بیصدا کردن #موقعیت فعال شد🔇"
end
end
end

local function unmute_location(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local mute_location = data[tostring(target)]["settings"]["mute_location"]
 if mute_location == "no" then
if not lang then
return "#Mute Location _Is Already Disabled_" 
elseif lang then
return "بیصدا کردن #موقعیت غیر فعال است🔊"
end
else 
data[tostring(target)]["settings"]["mute_location"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "#Mute Location _Has Been Disabled_" 
else
return "بیصدا کردن #موقعیت غیر فعال شد🔊"
end
end
end
---------------Mute Document-------------------
local function mute_document(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end

local mute_document = data[tostring(target)]["settings"]["mute_document"] 
if mute_document == "yes" then
if not lang then
 return "#Mute Document _Is Already Enabled_"
elseif lang then
 return "بیصدا کردن #اسناد فعال لست🔇"
end
else
 data[tostring(target)]["settings"]["mute_document"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "#Mute Document _Has Been Enabled_"
else
 return "بیصدا کردن #اسناد فعال شد🔇"
end
end
end

local function unmute_document(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نمیباشید"
end
end 

local mute_document = data[tostring(target)]["settings"]["mute_document"]
 if mute_document == "no" then
if not lang then
return "#Mute Document _Is Already Disabled_" 
elseif lang then
return "بیصدا کردن #اسناد غیر فعال است🔊"
end
else 
data[tostring(target)]["settings"]["mute_document"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "#Mute Document _Has Been Disabled_" 
else
return "بیصدا کردن #اسناد غیر فعال شد🔊"
end
end
end
---------------Mute TgService-------------------
local function mute_tgservice(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_tgservice = data[tostring(target)]["settings"]["mute_tgservice"] 
if mute_tgservice == "yes" then
if not lang then
 return "#Mute TgService _Is Already Enabled_"
elseif lang then
 return "بیصدا کردن #خدمات تلگرام فعال است🔇v"
end
else
 data[tostring(target)]["settings"]["mute_tgservice"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "#Mute TgService _Has Been Enabled_"
else
return "بیصدا کردن #خدمات تلگرام فعال شد🔇"
end
end
end

local function unmute_tgservice(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نیستید"
end 
end

local mute_tgservice = data[tostring(target)]["settings"]["mute_tgservice"]
 if mute_tgservice == "no" then
if not lang then
return "#Mute TgService _Is Already Disabled_"
elseif lang then
return "بیصدا کردن خدمات تلگرام غیر فعال است🔊"
end 
else 
data[tostring(target)]["settings"]["mute_tgservice"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "#Mute TgService _Has Been Disabled_"
else
return "بیصدا کردن #خدمات تلگرام غیر فعال شد🔊"
end 
end
end

---------------Mute Keyboard-------------------
local function mute_keyboard(msg, data, target) 
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 return "_You're Not_ *Moderator*"
else
 return "شما مدیر گروه نمیباشید"
end
end

local mute_keyboard = data[tostring(target)]["settings"]["mute_keyboard"] 
if mute_keyboard == "yes" then
if not lang then
 return "#Mute Keyboard _Is Already Enabled_"
elseif lang then
 return "بیصدا کردن #صفحه کلید فعال است🔇"
end
else
 data[tostring(target)]["settings"]["mute_keyboard"] = "yes" 
save_data(_config.moderation.data, data) 
if not lang then
 return "#Mute Keyboard _Has Been Enabled_"
else
return "بیصدا کردن #صفحه کلید فعال شد🔇"
end
end
end

local function unmute_keyboard(msg, data, target)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 if not is_mod(msg) then
if not lang then
return "_You're Not_ *Moderator*"
else
return "شما مدیر گروه نیستید"
end 
end

local mute_keyboard = data[tostring(target)]["settings"]["mute_keyboard"]
 if mute_keyboard == "no" then
if not lang then
return "#Mute Keyboard _Is Already Disabled_"
elseif lang then
return "بیصدا کردن #صفحه کلید غیرفعال است🔊"
end 
else 
data[tostring(target)]["settings"]["mute_keyboard"] = "no"
 save_data(_config.moderation.data, data) 
if not lang then
return "#Mute TgService _Has Been Disabled_"
else
return "بیصدا کردن #صفحه کلید غیرفعال شد🔊"
end 
end
end
----------Settings---------
local function group_settings(msg, target) 	
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
if not is_mod(msg) then
if not lang then
 	return "_You're Not_ *Moderator*"	
else
 return "شما مدیر گروه نیستید"
end
end
local data = load_data(_config.moderation.data)
local target = msg.to.id 
if data[tostring(target)] then 	
if data[tostring(target)]["settings"]["num_msg_max"] then 	
NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['num_msg_max'])
	print('custom'..NUM_MSG_MAX) 	
else 	
NUM_MSG_MAX = 5
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_link"] then			
data[tostring(target)]["settings"]["lock_link"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_tag"] then			
data[tostring(target)]["settings"]["lock_tag"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["emoji"] then			
data[tostring(target)]["settings"]["emoji"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_mention"] then			
data[tostring(target)]["settings"]["lock_mention"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_arabic"] then			
data[tostring(target)]["settings"]["lock_arabic"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_edit"] then			
data[tostring(target)]["settings"]["lock_edit"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_spam"] then			
data[tostring(target)]["settings"]["lock_spam"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_flood"] then			
data[tostring(target)]["settings"]["lock_flood"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_bots"] then			
data[tostring(target)]["settings"]["lock_bots"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["english"] then			
data[tostring(target)]["settings"]["english"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["views"] then			
data[tostring(target)]["settings"]["views"] = "yes"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_markdown"] then			
data[tostring(target)]["settings"]["lock_markdown"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["ads"] then			
data[tostring(target)]["settings"]["ads"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["fosh"] then			
data[tostring(target)]["settings"]["fosh"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["lock_webpage"] then			
data[tostring(target)]["settings"]["lock_webpage"] = "no"		
end
end

if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["welcome"] then			
data[tostring(target)]["settings"]["welcome"] = "no"		
end
end

 if data[tostring(target)]["settings"] then		
 if not data[tostring(target)]["settings"]["lock_pin"] then			
 data[tostring(target)]["settings"]["lock_pin"] = "no"		
 end
 end
 
local data = load_data(_config.moderation.data)
local target = msg.to.id
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_all"] then			
data[tostring(target)]["settings"]["mute_all"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_gif"] then			
data[tostring(target)]["settings"]["mute_gif"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_text"] then			
data[tostring(target)]["settings"]["mute_text"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_photo"] then			
data[tostring(target)]["settings"]["mute_photo"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_video"] then			
data[tostring(target)]["settings"]["mute_video"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_audio"] then			
data[tostring(target)]["settings"]["mute_audio"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_voice"] then			
data[tostring(target)]["settings"]["mute_voice"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_sticker"] then			
data[tostring(target)]["settings"]["mute_sticker"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_contact"] then			
data[tostring(target)]["settings"]["mute_contact"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_forward"] then			
data[tostring(target)]["settings"]["mute_forward"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_location"] then			
data[tostring(target)]["settings"]["mute_location"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_document"] then			
data[tostring(target)]["settings"]["mute_document"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_tgservice"] then			
data[tostring(target)]["settings"]["mute_tgservice"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_inline"] then			
data[tostring(target)]["settings"]["mute_inline"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_game"] then			
data[tostring(target)]["settings"]["mute_game"] = "no"		
end
end
if data[tostring(target)]["settings"] then		
if not data[tostring(target)]["settings"]["mute_keyboard"] then			
data[tostring(target)]["settings"]["mute_keyboard"] = "no"		
end
end
 local expire_date = ''
local expi = redis:ttl('ExpireDate:'..msg.to.id)
if expi == -1 then
if lang then
	expire_date = 'نامحدود!'
else
	expire_date = 'Unlimited!'
end
else
	local day = math.floor(expi / 86400) + 1
if lang then
	expire_date = day..' روز'
else
	expire_date = day..' Days'
end
end
if not lang then
local settings = data[tostring(target)]["settings"] 
 text ="*⚙gяσυρ ѕєттιηgѕ⚙️👥:*\n🔹*ℓσcк є∂ιт :* "..settings.lock_edit.."\n🔸*ℓσcк ℓιηкѕ :* "..settings.lock_link.."\n🔹*ℓσcк тαgѕ :* "..settings.lock_tag.."\n🔸*ℓσcк ƒℓσσ∂ :* "..settings.flood.."\n🔹*ℓσcк ѕραм :* "..settings.lock_spam.."\n🔸*ℓσcк мєηтιση :* "..settings.lock_mention.."\n🔹*ℓσcк αяαвιc :* "..settings.lock_arabic.."\n🔸*ℓσcк ωєвραgє :* "..settings.lock_webpage.."\n🔹*ℓσcк мαяк∂σωη :* "..settings.lock_markdown.."\n🔸*ℓσcк єηgℓιѕн :* "..settings.english.."\n🔹*ℓσcк ƒσѕн :* "..settings.fosh.."\n🔸*ℓσcк α∂ѕ :* "..settings.ads.."\n🔹*ℓσcк νιєωѕ :* "..settings.views.."\n🔸*ℓσcк ємσנι :* "..settings.emoji.."\n🔹*gяσυρ ωєℓcσмє :* "..settings.welcome.."\n🔸*ℓσcк ριη мєѕѕαgє :* "..settings.lock_pin.."\n🔹*вσтѕ ρяσтєcтιση :* "..settings.lock_bots.."\n*🔸ƒℓσσ∂ ѕєηѕιтινιту:* *"..NUM_MSG_MAX.."*\n*____________________*\n*⚙gяσυρ мυтє ℓιѕт* :\n🔹*мυтє αℓℓ : * "..settings.mute_all.."\n🔸*мυтє gιƒ :* "..settings.mute_gif.."\n🔹*мυтє тєχт :* "..settings.mute_text.."\n🔸*мυтє ιηℓιηє :* "..settings.mute_inline.."\n🔹*мυтє gαмє :* "..settings.mute_game.."\n🔸*мυтє ρнσтσ :* "..settings.mute_photo.."\n🔹*мυтє νι∂єσ :* "..settings.mute_video.."\n🔸*мυтє αυ∂ισ :* "..settings.mute_audio.."\n🔹*мυтє νσιcє :* "..settings.mute_voice.."\n🔸*мυтє ѕтιcкєя :* "..settings.mute_sticker.."\n🔹*мυтє cσηтαcт :* "..settings.mute_contact.."\n🔸*мυтє ƒσяωαя∂ :* "..settings.mute_forward.."\n🔹*мυтє ℓσcαтιση :* "..settings.mute_location.."\n🔸*мυтє ∂σcυмєηт :* "..settings.mute_document.."\n🔹*мυтє тgѕєяνιcє :* "..settings.mute_tgservice.."\n🔸*мυтє кєувσαя∂ :* "..settings.mute_keyboard.."\n*____________________*\n*🌐gяσυρ ℓαηgυαgє* : english🇮🇸\n🗓*єχριя:* _"..expire_date.."_\n*🔮ѕυ∂σ вσт:* @GODILOVEYOUME2"
else
local exp = redis:get("charged:"..msg.chat_id_)
    local day = 86400
    local ex = redis:ttl("charged:"..msg.chat_id_)
       if not exp or ex == -1 then
        expirefa = " نامحدود"
       else
        local d = math.floor(ex / day ) + 1
       expirefa = " *"..d.."* _روز_"
   end
local settings = data[tostring(target)]["settings"] 
 text = "*⚙️👥تنظیمات گروه:*\n*🔹قفل ویرایش پیام :* "..settings.lock_edit.."\n*🔸قفل لینک :* "..settings.lock_link.."\n*🔹قفل تگ :* "..settings.lock_tag.."\n*🔸قفل پیام مکرر :* "..settings.flood.."\n*🔹قفل هرزنامه :* "..settings.lock_spam.."\n*🔸قفل فراخوانی :* "..settings.lock_mention.."\n*🔹قفل عربی :* "..settings.lock_arabic.."\n*🔸قفل صفحات وب :* "..settings.lock_webpage.."\n*🔹قفل فونت :* "..settings.lock_markdown.."\n*🔸قفل انگلیسی :* "..settings.english.."\n*🔹قفل فحش: * "..settings.fosh.."\n*🔸قفل تبلیفات:* "..settings.ads.."\n*🔹قفل پست ویودار:* "..settings.views.."\n*🔸قفل اموجی:* "..settings.emoji.."\n*🔹پیام خوشآمد گویی :* "..settings.welcome.."\n*🔸قفل سنجاق کردن :* "..settings.lock_pin.."\n*🔹محافظت در برابر ربات ها :* "..settings.lock_bots.."\n*🔸حداکثر پیام مکرر :* *"..NUM_MSG_MAX.."*\n*____________________*\n*لیست بیصدا ها* : \n*🔹بیصدا همه : * "..settings.mute_all.."\n*🔸بیصدا تصاویر متحرک :* "..settings.mute_gif.."\n*🔹بیصدا متن :* "..settings.mute_text.."\n*🔸بیصدا کیبورد شیشه ای :* "..settings.mute_inline.."\n*🔹بیصدا بازی های تحت وب :* "..settings.mute_game.."\n*🔸بیصدا عکس :* "..settings.mute_photo.."\n*🔹بیصدا فیلم :* "..settings.mute_video.."\n*🔸بیصدا آهنگ :* "..settings.mute_audio.."\n*🔹بیصدا صدا :* "..settings.mute_voice.."\n*🔸بیصدا برچسب :* "..settings.mute_sticker.."\n*🔹بیصدا مخاطب :* "..settings.mute_contact.."\n*🔸بیصدا نقل قول :* "..settings.mute_forward.."\n*🔹بیصدا موقعیت :* "..settings.mute_location.."\n*🔸بیصدا اسناد :* "..settings.mute_document.."\n*🔹بیصدا خدمات تلگرام :* "..settings.mute_tgservice.."\n*🔸بیصدا صفحه کلید :* "..settings.mute_keyboard.."\n*____________________*\n🌐_زبان سوپرگروه_ : *فارسی 🇮🇷*\n🗓*تاریخ انقضا گروه: * _"..expire_date.."_\n🔮*برنامه نویس:* @GODILOVEYOUME2"
end
if not lang then
text = string.gsub(text, "yes", "🔐")
text = string.gsub(text, "no", "🔓")
text =  string.gsub(text, "0", "0️⃣")
text =  string.gsub(text, "1", "1️⃣")
text =  string.gsub(text, "2", "2️⃣")
text =  string.gsub(text, "3", "3️⃣")
text =  string.gsub(text, "4", "4️⃣")
text =  string.gsub(text, "5", "5️⃣")
text =  string.gsub(text, "6", "6️⃣")
text =  string.gsub(text, "7", "7️⃣")
text =  string.gsub(text, "8", "8️⃣")
text =  string.gsub(text, "9", "9️⃣")
 else
 text = string.gsub(text, "yes", "🔐")
 text =  string.gsub(text, "no", "🔓")
 end

return text
end

local function run(msg, matches)
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
local data = load_data(_config.moderation.data)
local chat = msg.to.id
local user = msg.from.id
if msg.to.type ~= 'pv' then
if matches[1] == "id" or matches[1]=="آیدی" or matches[1]=="Id" or matches[1]=="ایدی"then
if not matches[2] and not msg.reply_id then
local function getpro(arg, data)
 if data.photos_[0] then
       if not lang then
            tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'Chat ID💠 : '..msg.to.id..'\nUser ID🆔 : '..msg.from.id,dl_cb,nil)
       elseif lang then
          tdcli.sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, data.photos_[0].sizes_[1].photo_.persistent_id_,'💠شناسه گروه : '..msg.to.id..'\nشناسه شما 🆔: '..msg.from.id,dl_cb,nil)
     end
   else
       if not lang then
      tdcli.sendMessage(msg.to.id, msg.id_, 1, "`You Have Not Profile Photo...🌌!`\n\n> *Chat ID📍 :* `"..msg.to.id.."`\n*User ID🆔 :* `"..msg.from.id.."`", 1, 'md')
       elseif lang then
      tdcli.sendMessage(msg.to.id, msg.id_, 1, "_شما هیچ عکسی ندارید...🌌!_\n\n> _📍شناسه گروه :_ `"..msg.to.id.."`\n_🆔شناسه شما :_ `"..msg.from.id.."`", 1, 'md')
            end
        end
end
	   tdcli_function ({
    ID = "GetUserProfilePhotos",
    user_id_ = msg.from.id,
    offset_ = 0,
    limit_ = 1
  }, getpro, nil)	
end
if msg.reply_id and not matches[2] then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="id"})
  end
if matches[2] then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="id"})
      end
   end
if matches[1] == "pin" and is_mod(msg) and msg.reply_id  or matches[1] == "سنجاق" and is_mod(msg) and msg.reply_id or matches[1] == "Pin" and is_mod(msg) and msg.reply_id then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == 'yes' then
if is_owner(msg) then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)
if not lang then
return "*Message Has Been Pinned*"
elseif lang then
return "پیام سجاق شد"
end
elseif not is_owner(msg) then
   return
 end
 elseif lock_pin == 'no' then
    data[tostring(chat)]['pin'] = msg.reply_id
	  save_data(_config.moderation.data, data)
tdcli.pinChannelMessage(msg.to.id, msg.reply_id, 1)
if not lang then
return "*Message Has Been Pinned*"
elseif lang then
return "پیام سجاق شد"
end
end
end
if matches[1] == 'unpin' and is_mod(msg) or matches[1] == 'برداشتن سنجاق' and is_mod(msg) or matches[1] == 'Unpin' and is_mod(msg) then
local lock_pin = data[tostring(msg.to.id)]["settings"]["lock_pin"] 
 if lock_pin == 'yes' then
if is_owner(msg) then
tdcli.unpinChannelMessage(msg.to.id)
if not lang then
return "*Pin message has been unpinned*"
elseif lang then
return "پیام سنجاق شده پاک شد"
end
elseif not is_owner(msg) then
   return 
 end
 elseif lock_pin == 'no' then
tdcli.unpinChannelMessage(msg.to.id)
if not lang then
return "*Pin message has been unpinned*"
elseif lang then
return "پیام سنجاق شده پاک شد"
end
end
end
if matches[1] == "add" or  matches[1] == "نصب" or matches[1] == "Add" then
return modadd(msg)
end
if matches[1] == "rem" or matches[1] == "لغو نصب" or matches[1] == "Rem" then
return modrem(msg)
end
if matches[1] == "setowner" and is_admin(msg) or  matches[1] == "تنظیم مالک" and is_admin(msg) or matches[1] == "Setowner" and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="setowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="setowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="setowner"})
      end
   end
if matches[1] == "remowner" and is_admin(msg) or matches[1] == "حذف مالک" and is_admin(msg) or matches[1] == "Remowner" and is_admin(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="remowner"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="remowner"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="remowner"})
      end
   end
if matches[1] == "promote" and is_owner(msg) or matches[1] == "ترفیع" and is_owner(msg) or matches[1] == "Promote" and is_owner(msg) then
if not matches[2] and msg.reply_id then
    tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="promote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="promote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
   tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="promote"})
      end
   end
if matches[1] == "demote" and is_owner(msg) or  matches[1] == "تنزل" and is_owner(msg) or matches[1] == "Demote" and is_owner(msg) then
if not matches[2] and msg.reply_id then
 tdcli_function ({
      ID = "GetMessage",
      chat_id_ = msg.to.id,
      message_id_ = msg.reply_id
    }, action_by_reply, {chat_id=msg.to.id,cmd="demote"})
  end
  if matches[2] and string.match(matches[2], '^%d+$') then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="demote"})
    end
  if matches[2] and not string.match(matches[2], '^%d+$') then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="demote"})
      end
   end

if matches[1] == "lock" and is_mod(msg) or  matches[1] == "قفل" and is_mod(msg) or matches[1] == "Lock" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "link" or matches[2]=="لینک" then
return lock_link(msg, data, target)
end
if matches[2] == "tag"  or matches[2]=="تگ" then
return lock_tag(msg, data, target)
end
if matches[2] == "mention"  or matches[2]=="فراخوانی" then
return lock_mention(msg, data, target)
end
if matches[2] == "arabic"  or matches[2]=="عربی" then
return lock_arabic(msg, data, target)
end
if matches[2] == "edit"  or matches[2]=="ویرایش" then
return lock_edit(msg, data, target)
end
if matches[2] == "spam"  or matches[2]=="اسپم" then
return lock_spam(msg, data, target)
end
if matches[2] == "flood"  or matches[2]=="حساسیت" then
return lock_flood(msg, data, target)
end
if matches[2] == "bots"  or matches[2]=="ربات" then
return lock_bots(msg, data, target)
end
if matches[2] == "markdown" or matches[2]=="مارکدون" then
return lock_markdown(msg, data, target)
end
if matches[2] == "webpage"  or matches[2]=="وب" then
return lock_webpage(msg, data, target)
end
if matches[2] == "pin" and is_owner(msg)  or matches[2]=="سنجاق" and is_owner(msg) then
return lock_pin(msg, data, target)
end
if matches[2] == "english"  or matches[2]=="انگلیسی"  then
return lock_english(msg, data, target)
end
if matches[2] == "views"  or matches[2]=="ویو" then
return lock_views(msg, data, target)
end
if matches[2] == "emoji"  or matches[2]=="امجو" then
return lock_emoji(msg, data, target)
end
if matches[2] == "fosh"  or matches[2]=="فحش" then
return lock_fosh(msg, data, target)
end
if matches[2] == "ads"  or matches[2]=="تبلیغات" then
return lock_ads(msg, data, target)
end
end

if matches[1] == "unlock" and is_mod(msg) or matches[1]=="بازکردن" and is_mod(msg) or matches[1] == "Unlock" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "link"  or matches[2]=="لینک" then
return unlock_link(msg, data, target)
end
if matches[2] == "tag"  or matches[2]=="تگ" then
return unlock_tag(msg, data, target)
end
if matches[2] == "mention"  or matches[2]=="فراخوانی" then
return unlock_mention(msg, data, target)
end
if matches[2] == "arabic"  or matches[2]=="عربی" then
return unlock_arabic(msg, data, target)
end
if matches[2] == "edit"  or matches[2]=="ویرایش" then
return unlock_edit(msg, data, target)
end
if matches[2] == "spam"  or matches[2]=="اسپم" then
return unlock_spam(msg, data, target)
end
if matches[2] == "flood" or matches[2]=="حساسیت" then
return unlock_flood(msg, data, target)
end
if matches[2] == "bots"  or matches[2]=="ربات" then
return unlock_bots(msg, data, target)
end
if matches[2] == "markdown"  or matches[2]=="مارکدون" then
return unlock_markdown(msg, data, target)
end
if matches[2] == "webpage" or matches[2]=="وب" then
return unlock_webpage(msg, data, target)
end
if matches[2] == "pin" and is_owner(msg)  or matches[2]=="سنجاق" and is_owner(msg)  then
return unlock_pin(msg, data, target)
end
if matches[2] == "english" or matches[2]=="انگلیسی"  then
return unlock_english(msg, data, target)
end
if matches[2] == "views" or matches[2]=="ویو" then
return unlock_views(msg, data, target)
end
if matches[2] == "emoji" or matches[2]=="امجو" then
return unlock_emoji(msg, data, target)
end
if matches[2] == "fosh"  or matches[2]=="فحش" then
return unlock_fosh(msg, data, target)
end
if matches[2] == "ads"  or matches[2]=="تبلیغات" then
return unlock_ads(msg, data, target)
end
end

if matches[1] == "mute" and is_mod(msg) or matches[1]== "بیصدا" and is_mod(msg) or matches[1] == "Mute" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "all"  or matches[2]=="همه" then
return mute_all(msg, data, target)
end
if matches[2] == "gif"  or matches[2]=="گیف" then
return mute_gif(msg, data, target)
end
if matches[2] == "text"  or matches[2]=="متن" then
return mute_text(msg ,data, target)
end
if matches[2] == "photo"  or matches[2]=="عکس" then
return mute_photo(msg ,data, target)
end
if matches[2] == "video"  or matches[2]=="ویدیو" then
return mute_video(msg ,data, target)
end
if matches[2] == "audio"  or matches[2]=="اهنگ" then
return mute_audio(msg ,data, target)
end
if matches[2] == "voice"  or matches[2]=="ویس" then
return mute_voice(msg ,data, target)
end
if matches[2] == "sticker"  or matches[2]=="استیکر" then
return mute_sticker(msg ,data, target)
end
if matches[2] == "contact"  or matches[2]=="مخاطب" then
return mute_contact(msg ,data, target)
end
if matches[2] == "forward"  or matches[2]=="فوروارد" then
return mute_forward(msg ,data, target)
end
if matches[2] == "location"  or matches[2]=="مکان" then
return mute_location(msg ,data, target)
end
if matches[2] == "document"  or matches[2]=="فایل" then
return mute_document(msg ,data, target)
end
if matches[2] == "tgservice"  or matches[2]=="سرویس تلگرام" then
return mute_tgservice(msg ,data, target)
end
if matches[2] == "inline" or matches[2]=="دکمه شیشه ای" then
return mute_inline(msg ,data, target)
end
if matches[2] == "game"  or matches[2]=="بازی" then
return mute_game(msg ,data, target)
end
if matches[2] == "keyboard"  or matches[2]=="کیبورد" then
return mute_keyboard(msg ,data, target)
end
end

if matches[1] == "unmute" and is_mod(msg) or matches[1]=="باصدا" and is_mod(msg) or matches[1] == "Unmute" and is_mod(msg) then
local target = msg.to.id
if matches[2] == "all"  or matches[2]=="همه" then
return unmute_all(msg, data, target)
end
if matches[2] == "gif"  or matches[2]=="گیف"then
return unmute_gif(msg, data, target)
end
if matches[2] == "text" or matches[2]=="متن" then
return unmute_text(msg, data, target)
end
if matches[2] == "photo" or matches[2]=="عکس" then
return unmute_photo(msg ,data, target)
end
if matches[2] == "video" or matches[2]=="ویدیو" then
return unmute_video(msg ,data, target)
end
if matches[2] == "audio" or matches[2]=="اهنگ" then
return unmute_audio(msg ,data, target)
end
if matches[2] == "voice" or matches[2]=="ویس" then
return unmute_voice(msg ,data, target)
end
if matches[2] == "sticker" or matches[2]=="استیکر" then
return unmute_sticker(msg ,data, target)
end
if matches[2] == "contact" or matches[2]=="مخاطب" then
return unmute_contact(msg ,data, target)
end
if matches[2] == "forward" or matches[2]=="فوروارد" then
return unmute_forward(msg ,data, target)
end
if matches[2] == "location"  or matches[2]=="مکان" then
return unmute_location(msg ,data, target)
end
if matches[2] == "document"  or matches[2]=="فایل" then
return unmute_document(msg ,data, target)
end
if matches[2] == "tgservice" or matches[2]=="سرویس تلگرام" then
return unmute_tgservice(msg ,data, target)
end
if matches[2] == "inline" or matches[2]=="دکمه شیشه ای" then
return unmute_inline(msg ,data, target)
end
if matches[2] == "game"  or matches[2]=="بازی" then
return unmute_game(msg ,data, target)
end
if matches[2] == "keyboard"   or matches[2]=="کیبورد" then
return unmute_keyboard(msg ,data, target)
end
end
if matches[1] == "gpinfo" and is_mod(msg) and msg.to.type == "channel" or matches[1] == "اطلاعات گروه" and is_mod(msg) and msg.to.type == "channel" or matches[1] == "Gpinfo" and is_mod(msg) and msg.to.type == "channel" then
local function group_info(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
if not lang then
ginfo = "*Group Info :*\n_Admin Count :_ *"..data.administrator_count_.."*\n_Member Count :_ *"..data.member_count_.."*\n_Kicked Count :_ *"..data.kicked_count_.."*\n_Group ID :_ *"..data.channel_.id_.."*"
print(serpent.block(data))
elseif lang then
ginfo = "*اطلاعات گروه :*\n_تعداد مدیران :_ *"..data.administrator_count_.."*\n_تعداد اعضا :_ *"..data.member_count_.."*\n_تعداد اعضای حذف شده :_ *"..data.kicked_count_.."*\n_شناسه گروه :_ *"..data.channel_.id_.."*"
print(serpent.block(data))
end
        tdcli.sendMessage(arg.chat_id, arg.msg_id, 1, ginfo, 1, 'md')
end
 tdcli.getChannelFull(msg.to.id, group_info, {chat_id=msg.to.id,msg_id=msg.id})
end
if matches[1] == 'newlink' and is_mod(msg) or  matches[1] == 'لینک جدید' and is_mod(msg) then
			local function callback_link (arg, data)
   local hash = "gp_lang:"..msg.to.id
   local lang = redis:get(hash)
    local administration = load_data(_config.moderation.data) 
				if not data.invite_link_ then
					administration[tostring(msg.to.id)]['settings']['linkgp'] = nil
					save_data(_config.moderation.data, administration)
       if not lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_Bot is not group creator_\n_set a link for group with using_ /setlink", 1, 'md')
       elseif lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_ربات سازنده گروه نیست_\n_با دستور_ setlink/ _لینک جدیدی برای گروه ثبت کنید_", 1, 'md')
    end
				else
					administration[tostring(msg.to.id)]['settings']['linkgp'] = data.invite_link_
					save_data(_config.moderation.data, administration)
        if not lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "*Newlink Created*", 1, 'md')
        elseif lang then
       return tdcli.sendMessage(msg.to.id, msg.id, 1, "_لینک جدید ساخته شد_", 1, 'md')
     end
					administration[tostring(msg.to.id)]['settings']['linkgp'] = data.invite_link_
					save_data(_config.moderation.data, administration)
				end
			end
 tdcli.exportChatInviteLink(msg.to.id, callback_link, nil)
		end
		if matches[1] == 'setlink' and is_owner(msg) or matches[1] == 'تنظیم لینک' and is_owner(msg) or matches[1] == 'Setlink' and is_owner(msg) then
			data[tostring(chat)]['settings']['linkgp'] = 'waiting'
			save_data(_config.moderation.data, data)
      if not lang then
			return '_Please send the new group_ *link* _now_'
    else 
         return 'لطفا لینک گروه خود را ارسال کنید'
       end
		end

		if msg.text then
   local is_link = msg.text:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") or msg.text:match("^([https?://w]*.?t.me/joinchat/%S+)$")
			if is_link and data[tostring(chat)]['settings']['linkgp'] == 'waiting' and is_owner(msg) then
				data[tostring(chat)]['settings']['linkgp'] = msg.text
				save_data(_config.moderation.data, data)
            if not lang then
				return "*Newlink* _has been set_"
           else
           return "لینک جدید ذخیره شد"
		 	end
       end
		end
    if matches[1] == 'link' and (msg) or  matches[1] == 'لینک' and (msg) or matches[1] == 'Link' and (msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "_First create a link for group with using_ /newlink\n_If bot not group creator set a link with using_ /setlink"
     else
        return "ابتدا با دستور newlink/ لینک جدیدی برای گروه بسازید\nو اگر ربات سازنده گروه نیس با دستور setlink/ لینک جدیدی برای گروه ثبت کنید"
      end
      end
     if not lang then
       text = "<b>Group Link :</b>\n"..linkgp
     else
      text = "<b>لینک گروه :</b>\n"..linkgp
         end
        return tdcli.sendMessage(chat, msg.id, 1, text, 1, 'html')
     end
if matches[1] == 'linkpv' and is_mod(msg) or matches[1] == 'Linkpv' and is_mod(msg) or matches[1] == 'لینک پیوی' and is_mod(msg) then
      local linkgp = data[tostring(chat)]['settings']['linkgp']
      if not linkgp then
      if not lang then
        return "_First create a link for group with using_ /newlink\n_If bot not group creator set a link with using_ /setlink"
     else
        return "ابتدا با دستور newlink/ لینک جدیدی برای گروه بسازید\nو اگر ربات سازنده گروه نیس با دستور setlink/ لینک جدیدی برای گروه ثبت کنید"
      end
      end
     if not lang then
     tdcli.sendMessage(user, "", 1, "<b>Group Link "..msg.to.title.." :</b>\n"..linkgp, 1, 'html')
     else
      tdcli.sendMessage(user, "", 1, "<b>لینک گروه "..msg.to.title.." :</b>\n"..linkgp, 1, 'html')
         end
      if not lang then
        return "*Group Link Was Send In Your Private Message*"
       else
        return "_لینک گروه به چت خصوصی شما ارسال شد_"
        end
     end
  if matches[1] == "setrules" and matches[2] and is_mod(msg) or matches[1] == "تنظیم قوانین" and matches[2] and is_mod(msg) or matches[1] == "Setrules" and matches[2] and is_mod(msg) then
    data[tostring(chat)]['rules'] = matches[2]
	  save_data(_config.moderation.data, data)
     if not lang then
    return "*Group rules* _has been set_"
   else 
  return "قوانین گروه ثبت شد"
   end
  end
  if matches[1] == "rules" or matches[1] == "قوانین" or matches[1] == "Rules" then
 if not data[tostring(chat)]['rules'] then
   if not lang then
     rules = "ℹ️ The Default Rules :\n1⃣ No Flood.\n2⃣ No Spam.\n3⃣ No Advertising.\n4⃣ Try to stay on topic.\n5⃣ Forbidden any racist, sexual, homophobic or gore content.\n➡️ Repeated failure to comply with these rules will cause ban."
    elseif lang then
       rules = "ℹ️ قوانین پپیشفرض:\n1⃣ ارسال پیام مکرر ممنوع.\n2⃣ اسپم ممنوع.\n3⃣ تبلیغ ممنوع.\n4⃣ سعی کنید از موضوع خارج نشید.\n5⃣ هرنوع نژاد پرستی, شاخ بازی و پورنوگرافی ممنوع .\n➡️ از قوانین پیروی کنید, در صورت عدم رعایت قوانین اول اخطار و در صورت تکرار مسدود."
 end
        else
     rules = "*Group Rules :*\n"..data[tostring(chat)]['rules']
      end
    return rules
  end
if matches[1] == "res" and matches[2] and is_mod(msg) or matches[1] == "Res" and matches[2] and is_mod(msg) or matches[1] == "رس" and matches[2] and is_mod(msg) then
    tdcli_function ({
      ID = "SearchPublicChat",
      username_ = matches[2]
    }, action_by_username, {chat_id=msg.to.id,username=matches[2],cmd="res"})
  end
if matches[1] == "whois" and matches[2] and is_mod(msg) or matches[1] == "Whois" and matches[2] and is_mod(msg) or matches[1] == "شخص" and matches[2] and is_mod(msg) then
tdcli_function ({
    ID = "GetUser",
    user_id_ = matches[2],
  }, action_by_id, {chat_id=msg.to.id,user_id=matches[2],cmd="whois"})
  end
  if matches[1] == 'setflood' and is_mod(msg) or matches[1] == 'حساسیت اسپم' and is_mod(msg) or matches[1] == 'Setflood' and is_mod(msg) then
			if tonumber(matches[2]) < 1 or tonumber(matches[2]) > 200 then
				return "_Wrong number, range is_ *[1-50]*"
      end
			local flood_max = matches[2]
			data[tostring(chat)]['settings']['num_msg_max'] = flood_max
			save_data(_config.moderation.data, data)
    return "_Group_ *flood* _sensitivity has been set to :_ *[ "..matches[2].." ]*"
       end
		if matches[1]:lower() == 'clean' and is_owner(msg) or matches[1]:lower() == 'پاک کردن' and is_owner(msg) or matches[1]:lower() == 'Clean' and is_owner(msg) then
			if matches[2] == 'mods' or  matches[2] == 'مدیران' then
				if next(data[tostring(chat)]['mods']) == nil then
            if not lang then
					return "_No_ *moderators* _in this group_"
             else
                return "هیچ مدیری برای گروه انتخاب نشده است"
				end
            end
				for k,v in pairs(data[tostring(chat)]['mods']) do
					data[tostring(chat)]['mods'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
            if not lang then
				return "_All_ *moderators* _has been demoted_"
          else
            return "تمام مدیران گروه تنزیل مقام شدند"
			end
         end
			if matches[2] == 'filterlist' or matches[2] == 'لیست فیلتر' or matches[2] == 'Filterlist' then
				if next(data[tostring(chat)]['filterlist']) == nil then
     if not lang then
					return "*Filtered words list* _is empty_"
         else
					return "_لیست کلمات فیلتر شده خالی است_"
             end
				end
				for k,v in pairs(data[tostring(chat)]['filterlist']) do
					data[tostring(chat)]['filterlist'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
       if not lang then
				return "*Filtered words list* _has been cleaned_"
           else
				return "_لیست کلمات فیلتر شده پاک شد_"
           end
			end
			if matches[2] == 'rules' or matches[2] == 'قوانین' or matches[2] == 'Rules' then
				if not data[tostring(chat)]['rules'] then
            if not lang then
					return "_No_ *rules* _available_"
             else
               return "قوانین برای گروه ثبت نشده است"
             end
				end
					data[tostring(chat)]['rules'] = nil
					save_data(_config.moderation.data, data)
             if not lang then
				return "*Group rules* _has been cleaned_"
          else
            return "قوانین گروه پاک شد"
			end
       end
			if matches[2] == 'welcome' or  matches[2] == 'ولکام' or matches[2] == 'Welcome' then
				if not data[tostring(chat)]['setwelcome'] then
            if not lang then
					return "*Welcome Message not set*"
             else
               return "پیام خوشآمد گویی ثبت نشده است"
             end
				end
					data[tostring(chat)]['setwelcome'] = nil
					save_data(_config.moderation.data, data)
             if not lang then
				return "*Welcome message* _has been cleaned_"
          else
            return "پیام خوشآمد گویی پاک شد"
			end
       end
			if matches[2] == 'about'  or matches[2] == 'درباره گروه' or matches[2] == 'About' then
        if msg.to.type == "chat" then
				if not data[tostring(chat)]['about'] then
            if not lang then
					return "_No_ *description* _available_"
            else
              return "پیامی مبنی بر درباره گروه ثبت نشده است"
          end
				end
					data[tostring(chat)]['about'] = nil
					save_data(_config.moderation.data, data)
        elseif msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, "", dl_cb, nil)
             end
             if not lang then
				return "*Group description* _has been cleaned_"
           else
              return "پیام مبنی بر درباره گروه پاک شد"
             end
		   	end
        end
		if matches[1]:lower() == 'clean' and is_admin(msg) or matches[1]:lower() == 'پاک کردن' and is_admin(msg) or matches[1]:lower() == 'Clean' and is_admin(msg) then
			if matches[2] == 'owners' or matches[2] == 'مالک' then
				if next(data[tostring(chat)]['owners']) == nil then
             if not lang then
					return "_No_ *owners* _in this group_"
            else
                return "مالکی برای گروه انتخاب نشده است"
            end
				end
				for k,v in pairs(data[tostring(chat)]['owners']) do
					data[tostring(chat)]['owners'][tostring(k)] = nil
					save_data(_config.moderation.data, data)
				end
            if not lang then
				return "_All_ *owners* _has been demoted_"
           else
            return "تمامی مالکان گروه تنزیل مقام شدند"
          end
			end
     end
if matches[1] == "setname" and matches[2] and is_mod(msg) or matches[1] == "تنظیم نام" and matches[2] and is_mod(msg) or matches[1] == "Setname" and matches[2] and is_mod(msg) then
local gp_name = matches[2]
tdcli.changeChatTitle(chat, gp_name, dl_cb, nil)
end
  if matches[1] == "setabout" and matches[2] and is_mod(msg) or  matches[1] == "تنظیم درباره گروه" and matches[2] and is_mod(msg) or matches[1] == "Setabout" and matches[2] and is_mod(msg) then
     if msg.to.type == "channel" then
   tdcli.changeChannelAbout(chat, matches[2], dl_cb, nil)
    elseif msg.to.type == "chat" then
    data[tostring(chat)]['about'] = matches[2]
	  save_data(_config.moderation.data, data)
     end
     if not lang then
    return "*Group description* _has been set_"
    else
     return "پیام مبنی بر درباره گروه ثبت شد"
      end
  end
  if matches[1] == "about" and msg.to.type == "chat" or matches[1] == "درباره گروه" and msg.to.type == "chat" or matches[1] == "About" and msg.to.type == "chat" then
 if not data[tostring(chat)]['about'] then
     if not lang then
     about = "_No_ *description* _available_"
      elseif lang then
      about = "پیامی مبنی بر درباره گروه ثبت نشده است"
       end
        else
     about = "*Group Description :*\n"..data[tostring(chat)]['about']
      end
    return about
  end
  if matches[1] == 'filter' and is_mod(msg) or matches[1] == 'فیلتر' and is_mod(msg) or  matches[1] == 'Filter' and is_mod(msg) then
    return filter_word(msg, matches[2])
  end
  if matches[1] == 'unfilter' and is_mod(msg) or matches[1] == 'حذف فیلتر' and is_mod(msg) or matches[1] == 'Unfilter' and is_mod(msg) then
    return unfilter_word(msg, matches[2])
  end
  if matches[1] == 'filterlist' and is_mod(msg) or  matches[1] == 'لیست فیلتر' and is_mod(msg) or matches[1] == 'Filterlist' and is_mod(msg) then
    return filter_list(msg)
  end
if matches[1] == "settings" or matches[1] == "تنظیمات" or matches[1] == "Settings" then
return group_settings(msg, target)
end
if matches[1] == "modlist" or matches[1] == "لیست ناظم" or matches[1] == "Modlist" then
return modlist(msg)
end
if matches[1] == "ownerlist" and is_owner(msg) or  matches[1] == "لیست مالکان" and is_owner(msg) or matches[1] == "Ownerlist" and is_owner(msg)  then
return ownerlist(msg)
end

if matches[1] == "setlang" and is_owner(msg) or matches[1] == "تنظیم زبان" and is_owner(msg) or matches[1] == "Setlang" and is_owner(msg) then
   if matches[2] == "en" or matches[2] == "انگلیسی" then
local hash = "gp_lang:"..msg.to.id
local lang = redis:get(hash)
 redis:del(hash)
return "_Group Language Set To:_ EN"
  elseif matches[2] == "fa" or matches[2] == "فارسی" then
redis:set(hash, true)
return "*زبان گروه تنظیم شد به : فارسی*"
end
end

if matches[1] == "help" and is_mod(msg) or matches[1] == "Help" and is_mod(msg) then
if not lang then
text = [[
📜Help of Black
#TG🏷
〰〰〰〰〰〰〰〰〰〰〰
☆》#دستورات تنظیم مدیر و معاون 

*Setowner* `[username , id , reply]`
🍃تنظیم فرد به عنوان مدیر ربات برای گروه

*Remowner* `[username , id , reply]`
🍁تنزل مقام فرد از مدریت ربات برای گروه

*Promote* `[username , id , reply]`
🍃تنظیم فرد به عنوان معاون ربات در گروه

*Demote* `[username , id , reply]`
🍁تنزل مقام فرد از معاون ربات برای گروه
〰〰〰〰〰〰〰〰〰〰〰
☆》#دستورات قفلی 

*Lock*  
`[link , tag , edit , arabic , webpage , bots , spam , flood , markdown , mention , emoji , ads , fosh]`

*Unlock* 
 `[link , tag , edit , arabic , webpage , bots , spam , flood , markdown , mention , emoji , ads , fosh]`
〰〰〰〰〰〰〰〰〰〰〰
☆》#دستورات بیصدا

*Mute* 
`[gif , photo , document , sticker , video , text , forward , location , audio , voice , contact ,tgservice , inline , all , keyboard]`

*Unmute*
 `[gif , photo , document , sticker , video , text , forward , location , audio , voice , contact, tgservice , inline , all , keybord]`
〰〰〰〰〰〰〰〰〰〰〰
☆》#دستورات مدیریتی

*Setlang* `[fa - en]`
🍃تنظیم زبان پاسخ گویی ربات به دستورات

*Silent* `[username , id , reply]`
🍁ساکت کردن فرد (هر پیامی که فرد بدهد پاک میشود(

*Unsilent* `[username , id , reply]`
🍃بازکردن ساکت بودن فرد 

*Kick* `[username , id , reply]`
🍁اخراج فرد از گروه

*Ban* `[username , id , reply]`
🍃مسدود کردن فرد و اجازه ورود مجدد ندادن

*Unban* `[username , id , reply]`
🍁خارج شدن فرد از حالت مسدود 

*Delall* `[username , id , reply]`
🍃پاک کردن تمام پیام هایی که فرد داده است در گروه

*Filter* `[text]`
🍁فیلتر کلمه مورد نظر و پاک شدن ان

*Unfilter* `[text]`
🍃حذف کلمه مورد نظر از لیست فیلتر

*Welcome* `[enable-disable]`
🍁روشن و خاموش کردن خوش امفعال
*Mt* [3 4]
🍃تنظیم بیصدا به صورت ساعت ودقیقه
*Unmt*
🍁بازکردن بیصدا زمان دار
〰〰〰〰〰〰〰〰〰〰〰
☆》#دستورات درخواست لیست 
*Settings*
🍃دریافت لیست تنظیمات
*Modelist*
🍁دریافت لیست معاون های گروه
*Ownerlist*
🍃دریافت لیست مدیران گروه 
*Silentlist*
🍁دریافت لیست ساکت ها
*Filterlist*
🍃دریافت لیست کلمات فیلتر
〰〰〰〰〰〰〰〰〰〰〰
☆》#دستورات تنظیم 

*Setflood* `[1-50]`
🍁تنظیم حساسیت پیام مکرر
*Set* `[rules , name , link , about]`
🍃تنظیم به ترتیب [قوانین ، اسم ، لینک ، درباره ، ] برای گروه

*Setwelcome* `[text]`
🍁تنظیم خوش امد برای گروه
*Setexpire* [day number]
تنظیم تاریخ انقضا به صورت روز 
〰〰〰〰〰〰〰〰〰〰〰
☆》#دستورات پاک کردن 

*Clean* `[rules , about , silentlist , filterlist , welcome]`
🍃پاک کردن به ترتیب [ربات ها ، معاون ها ، ربات ها ، قوانین ، درباره گروه ، لیست ساکت ها ، لیست فیلتر ، خوش امد گو]
〰〰〰〰〰〰〰〰〰〰〰
☆》#دستورات دیگر 
*Res* `[username]`
🍁نمایش اطلاعات یوزرنیم
*Whois* `[id]`
🍃نمایش اطلاعات برای ایدی عددی
*Pin* `[reply]`
🍁پین پیام مورد نظر در گروه
*Unpin* `[reply]`
🍃برداشتن پیام از حالت پین
*Rules* 
🍁نمایش قوانین گروه
*About*
🍃نمایش درباره گروه
*Gpinfo*
🍁نمایش اطلاعات گروه
*Link*
🍃دریافت لینک گروه

🍁دستورات تا این قسمت برای مدیران و معاون ها و سودو های ربات هست و امکان استفاده از ان برای افراد عادی نیست🔷
〰〰〰〰〰〰〰〰〰〰〰
☆》#دستورات عمومی

*Id*
🍃دریافت ایدی عددیه گروه و شما به همراه عکس شما
*Info*
🍁دریافت اطلاعات شما به همراه عکس
*Nerkh*
🍃دریافت نرخ جهت خرید ربات برای گروه
*Ping*
🍁اطمینان از انلاینی ربات به صورت فان
*Time*
🍃دریافت ساعت و تاریخ امروز
*Write* `[text]`
🍁نوشتن کلمه با 100 فونت مختلف
*Me*
نمایش مقام شما 
*Getpro* `[1-80]`
نمایش عکس شما 				
〰〰〰〰〰〰〰〰〰〰〰
🔶شما دوستان عزیز میتوانید از قرار دادن [!/#] در اول دستور استفاده نماید
🔷دستورات به زبان انگلیسی هست و جواب دستورات به دو شکل فارسی و انگلیسی قابل تغییر است❕
〰〰〰〰〰〰〰〰〰〰〰
➰Powered by :@GODILOVEYOUME2
〰〰〰〰〰〰〰〰〰〰〰]]

elseif lang then

text = [[
📜Help of Black
#TG🏷
〰〰〰〰〰〰〰〰〰〰〰
☆》#دستورات تنظیم مدیر و معاون 

*Setowner* `[username , id , reply]`
🍃تنظیم فرد به عنوان مدیر ربات برای گروه

*Remowner* `[username , id , reply]`
🍁تنزل مقام فرد از مدریت ربات برای گروه

*Promote* `[username , id , reply]`
🍃تنظیم فرد به عنوان معاون ربات در گروه

*Demote* `[username , id , reply]`
🍁تنزل مقام فرد از معاون ربات برای گروه
〰〰〰〰〰〰〰〰〰〰〰
☆》#دستورات قفلی 

*Lock*  
`[link , tag , edit , arabic , webpage , bots , spam , flood , markdown , mention , emoji , ads , fosh]`

*Unlock* 
 `[link , tag , edit , arabic , webpage , bots , spam , flood , markdown , mention , emoji , ads , fosh]`
〰〰〰〰〰〰〰〰〰〰〰
☆》#دستورات بیصدا

*Mute* 
`[gif , photo , document , sticker , video , text , forward , location , audio , voice , contact ,tgservice , inline , all , keyboard]`

*Unmute*
 `[gif , photo , document , sticker , video , text , forward , location , audio , voice , contact, tgservice , inline , all , keybord]`
〰〰〰〰〰〰〰〰〰〰〰
☆》#دستورات مدیریتی

*Setlang* `[fa - en]`
🍃تنظیم زبان پاسخ گویی ربات به دستورات

*Silent* `[username , id , reply]`
🍁ساکت کردن فرد (هر پیامی که فرد بدهد پاک میشود(

*Unsilent* `[username , id , reply]`
🍃بازکردن ساکت بودن فرد 

*Kick* `[username , id , reply]`
🍁اخراج فرد از گروه

*Ban* `[username , id , reply]`
🍃مسدود کردن فرد و اجازه ورود مجدد ندادن

*Unban* `[username , id , reply]`
🍁خارج شدن فرد از حالت مسدود 

*Delall* `[username , id , reply]`
🍃پاک کردن تمام پیام هایی که فرد داده است در گروه

*Filter* `[text]`
🍁فیلتر کلمه مورد نظر و پاک شدن ان

*Unfilter* `[text]`
🍃حذف کلمه مورد نظر از لیست فیلتر

*Welcome* `[enable-disable]`
🍁روشن و خاموش کردن خوش امفعال
*Mt* [3 4]
🍃تنظیم بیصدا به صورت ساعت ودقیقه
*Unmt*
🍁بازکردن بیصدا زمان دار
〰〰〰〰〰〰〰〰〰〰〰
☆》#دستورات درخواست لیست 
*Settings*
🍃دریافت لیست تنظیمات
*Modelist*
🍁دریافت لیست معاون های گروه
*Ownerlist*
🍃دریافت لیست مدیران گروه 
*Silentlist*
🍁دریافت لیست ساکت ها
*Filterlist*
🍃دریافت لیست کلمات فیلتر
〰〰〰〰〰〰〰〰〰〰〰
☆》#دستورات تنظیم 

*Setflood* `[1-50]`
🍁تنظیم حساسیت پیام مکرر
*Set* `[rules , name , link , about]`
🍃تنظیم به ترتیب [قوانین ، اسم ، لینک ، درباره ، ] برای گروه

*Setwelcome* `[text]`
🍁تنظیم خوش امد برای گروه
*Setexpire* [day number]
تنظیم تاریخ انقضا به صورت روز 
〰〰〰〰〰〰〰〰〰〰〰
☆》#دستورات پاک کردن 

*Clean* `[rules , about , silentlist , filterlist , welcome]`
🍃پاک کردن به ترتیب [ربات ها ، معاون ها ، ربات ها ، قوانین ، درباره گروه ، لیست ساکت ها ، لیست فیلتر ، خوش امد گو]
〰〰〰〰〰〰〰〰〰〰〰
☆》#دستورات دیگر 
*Res* `[username]`
🍁نمایش اطلاعات یوزرنیم
*Whois* `[id]`
🍃نمایش اطلاعات برای ایدی عددی
*Pin* `[reply]`
🍁پین پیام مورد نظر در گروه
*Unpin* `[reply]`
🍃برداشتن پیام از حالت پین
*Rules* 
🍁نمایش قوانین گروه
*About*
🍃نمایش درباره گروه
*Gpinfo*
🍁نمایش اطلاعات گروه
*Link*
🍃دریافت لینک گروه

🍁دستورات تا این قسمت برای مدیران و معاون ها و سودو های ربات هست و امکان استفاده از ان برای افراد عادی نیست🔷
〰〰〰〰〰〰〰〰〰〰〰
☆》#دستورات عمومی

*Id*
🍃دریافت ایدی عددیه گروه و شما به همراه عکس شما
*Info*
🍁دریافت اطلاعات شما به همراه عکس
*Nerkh*
🍃دریافت نرخ جهت خرید ربات برای گروه
*Ping*
🍁اطمینان از انلاینی ربات به صورت فان
*Time*
🍃دریافت ساعت و تاریخ امروز
*Write* `[text]`
🍁نوشتن کلمه با 100 فونت مختلف
*Me*
نمایش مقام شما
*Getpro* `[1-80]`
نمایش عکس شما 
〰〰〰〰〰〰〰〰〰〰〰
🔶شما دوستان عزیز میتوانید از قرار دادن [!/#] در اول دستور استفاده نماید
🔷دستورات به زبان انگلیسی هست و جواب دستورات به دو شکل فارسی و انگلیسی قابل تغییر است❕
〰〰〰〰〰〰〰〰〰〰〰
➰Powered by :@GODILOVEYOUME2
〰〰〰〰〰〰〰〰〰〰〰]]
end
return text
end
if matches[1] == "راهنما" and is_mod(msg) then
text = [[

📜راهنمای ربات بلک
#TG🏷
〰〰〰〰〰〰〰〰〰〰〰
☆》#دستورات تنظیم مدیر و معاون 

*تنظیم مالک* `[username , id , reply]`
🔥تنظیم فرد به عنوان مدیر ربات برای گروه

*حذف مالک* `[username , id , reply]`
⚡تنزل مقام فرد از مدریت ربات برای گروه

*ترفیع* `[username , id , reply]`
🔥تنظیم فرد به عنوان معاون ربات در گروه

*تنزل* `[username , id , reply]`
⚡تنزل مقام فرد از معاون ربات برای گروه
〰〰〰〰〰〰〰〰〰〰〰
☆》#دستورات قفلی 
🔥*قفل*
`{لینک ، تگ ، فراخوانی ، اسپم ، حساسیت ، ویرایش ، ربات ، مارکدون ، وب ، سنجاق ، انگلیسی ، عربی ، ویو ، امجو ، تبلیغات ، فحش}`
⚡*بازکردن* 
`{لینک ، تگ ، فراخوانی ، اسپم ، حساسیت ، ویرایش ، ربات ، مارکدون ، وب ، سنجاق ، انگلیسی ، عربی ، ویو ، امجو ، تبلیغات ، فحش}`
〰〰〰〰〰〰〰〰〰〰〰
☆》#دستورات بیصدا
🔥*بیصدا *
`{همه ، گیف ، متن ، عکس ، ویدیو ، آهنگ ، ویس ، استیکر ، مخاطب ، فورواد ، کیبورد ، فایل ، مکان ، سرویس تلگرام ، بازی ، دکمه شیشه ای}`
⚡*باصدا *
`{همه ، گیف ، متن ، عکس ، ویدیو ، آهنگ ، ویس ، استیکر ، مخاطب ، فورواد ، کیبورد ، فایل ، مکان ، سرویس تلگرام ، بازی ، دکمه شیشه ای}`
〰〰〰〰〰〰〰〰〰〰〰
☆》#دستورات مدیریتی

*تنظیم زبان* `[فارسی - انگلیسی]`
🔥تنظیم زبان پاسخ گویی ربات به دستورات

*خفه* `[username , id , reply]`
⚡ساکت کردن فرد (هر پیامی که فرد بدهد پاک میشود(

*ان خفه* `[username , id , reply]`
🔥بازکردن ساکت بودن فرد 

*کیک* `[username , id , reply]`
⚡اخراج فرد از گروه

*بن* `[username , id , reply]`
🔥مسدود کردن فرد و اجازه ورود مجدد ندادن

*ان بن* `[username , id , reply]`
⚡خارج شدن فرد از حالت مسدود 

*حذف همه* `[username , id , reply]`
🔥پاک کردن تمام پیام هایی که فرد داده است در گروه

*فیلتر* `[text]`
⚡فیلتر کلمه مورد نظر و پاک شدن ان

*حذف فیلتر* `[text]`
🔥حذف کلمه مورد نظر از لیست فیلتر

*ولکام* `[فعال-غیر فعال]`
⚡فعال و غیر فعال کردن خوش آمد گوی
*بیصدا* `[3 4]`
🔥تنظیم بیصدا به صورت ساعت ودقیقه
*باصدا*
⚡بازکردن بیصدا زمان دار
〰〰〰〰〰〰〰〰〰〰〰
☆》#دستورات درخواست لیست 
*تنظیمات*
🔥دریافت لیست تنظیمات
*لیست ناظم*
⚡دریافت لیست معاون های گروه
*لیست مالکان*
🔥دریافت لیست مدیران گروه 
*لیست خفه*
⚡دریافت لیست ساکت ها
*لیست فیلتر*
🔥دریافت لیست کلمات فیلتر
〰〰〰〰〰〰〰〰〰〰〰
☆》#دستورات تنظیم 
*حساسیت اسپم* `[1-50]`
⚡تنظیم حساسیت پیام مکرر
🔥*تنظیم* 
`[قوانین ، لینک ، درباره گروه، ]`
*تنظیم ولکام* `[text]`
⚡تنظیم خوش امد برای گروه
〰〰〰〰〰〰〰〰〰〰〰
☆》#دستورات پاک کردن 

🔥پاک کردن 
`[قوانین ، درباره گروه ، لیست فیلتر ، ولکام]`
حذف پیام
حذف  `[0 -100]`
〰〰〰〰〰〰〰〰〰〰〰
☆》#دستورات دیگر 
*رس* `[username]`
⚡نمایش اطلاعات یوزرنیم
*شخص* `[id]`
🔥نمایش اطلاعات برای ایدی عددی
*سنجاق* `[reply]`
⚡پین پیام مورد نظر در گروه
*برداشتن سنجاق* `[reply]`
🔥برداشتن پیام از حالت پین
*قوانین* 
⚡نمایش قوانین گروه
*اطلاعات گروه*
🔥نمایش اطلاعات گروه
*لینک*
⚡دریافت لینک گروه

🔥دستورات تا این قسمت برای مدیران و معاون ها و سودو های ربات هست و امکان استفاده از ان برای افراد عادی نیست🔷
〰〰〰〰〰〰〰〰〰〰〰
☆》#دستورات عمومی

*ایدی*
⚡دریافت ایدی عددیه گروه و شما به همراه عکس شما
*اطلاعات من*
🔥دریافت اطلاعات شما 
*نرخ*
⚡دریافت نرخ جهت خرید ربات برای گروه
*انلاینی*
🔥اطمینان از انلاینی ربات به صورت فان
*ساعت*
⚡دریافت ساعت و تاریخ امروز
*نوشتن* `[text]`
🔥نوشتن کلمه با 100 فونت مختلف
⚡*مقام من*
نمایش مقام شما
🔥*پرو فایل* `[1-80]`
نمایش عکس پروفایل از 1 تا 80
〰〰〰〰〰〰〰〰〰〰〰
🔷شما دوستان عزیز نمیتوانید از قرار دادن [!/#] در اول دستور استفاده نماید
🔶دستورات به زبان فارسی هست و جواب دستورات به دو شکل انگلیسی و فارسی قابل تغییر است❕
〰〰〰〰〰〰〰〰〰〰〰
➰Powered by :@GODILOVEYOUME2
〰〰〰〰〰〰〰〰〰〰〰
]]
return text
end
--------------------- Welcome -----------------------
	if matches[1] == "welcome" and is_mod(msg) or matches[1] == "Welcome" and is_mod(msg) or matches[1] == "ولکام" and is_mod(msg) then
		if matches[2] == "enable" or matches[2] == "فعال" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "yes" then
       if not lang then
				return "_Group_ *welcome* _is already enabled_"
       elseif lang then
				return "_خوشآمد گویی از قبل فعال بود_"
           end
			else
		data[tostring(chat)]['settings']['welcome'] = "yes"
	    save_data(_config.moderation.data, data)
       if not lang then
				return "_Group_ *welcome* _has been enabled_"
       elseif lang then
				return "_خوشآمد گویی فعال شد_"
          end
			end
		end
		
		if matches[2] == "disable" or matches[2] == "غیر فعال" then
			welcome = data[tostring(chat)]['settings']['welcome']
			if welcome == "no" then
      if not lang then
				return "_Group_ *Welcome* _is already disabled_"
      elseif lang then
				return "_خوشآمد گویی از قبل فعال نبود_"
         end
			else
		data[tostring(chat)]['settings']['welcome'] = "no"
	    save_data(_config.moderation.data, data)
      if not lang then
				return "_Group_ *welcome* _has been disabled_"
      elseif lang then
				return "_خوشآمد گویی غیرفعال شد_"
          end
			end
		end
	end
	if matches[1] == "setwelcome" and matches[2] and is_mod(msg) or matches[1] == "Setwelcome" and matches[2] and is_mod(msg) or matches[1] == "تنظیم ولکام" and matches[2] and is_mod(msg) then
		data[tostring(chat)]['setwelcome'] = matches[2]
	    save_data(_config.moderation.data, data)
       if not lang then
		return "_Welcome Message Has Been Set To :_\n*"..matches[2].."*\n\n*You can use :*\n_{gpname} Group Name_\n_{rules} ➣ Show Group Rules_\n_{name} ➣ New Member First Name_\n_{username} ➣ New Member Username_"
       else
		return "_پیام خوشآمد گویی تنظیم شد به :_\n*"..matches[2].."*\n\n*شما میتوانید از*\n_{gpname} نام گروه_\n_{rules} ➣ نمایش قوانین گروه_\n_{name} ➣ نام کاربر جدید_\n_{username} ➣ نام کاربری کاربر جدید_\n_استفاده کنید_"
        end
     end
	end
end
-----------------------------------------
local function pre_process(msg)
   local chat = msg.to.id
   local user = msg.from.id
 local data = load_data(_config.moderation.data)
	local function welcome_cb(arg, data)
local hash = "gp_lang:"..arg.chat_id
local lang = redis:get(hash)
		administration = load_data(_config.moderation.data)
    if administration[arg.chat_id]['setwelcome'] then
     welcome = administration[arg.chat_id]['setwelcome']
      else
     if not lang then
     welcome = "*Welcome Dude*"
    elseif lang then
     welcome = "_خوش آمدید_"
        end
     end
 if administration[tostring(arg.chat_id)]['rules'] then
rules = administration[arg.chat_id]['rules']
else
   if not lang then
     rules = "ℹ️ The Default Rules :\n1⃣ No Flood.\n2⃣ No Spam.\n3⃣ No Advertising.\n4⃣ Try to stay on topic.\n5⃣ Forbidden any racist, sexual, homophobic or gore content.\n➡️ Repeated failure to comply with these rules will cause ban."
    elseif lang then
       rules = "ℹ️ قوانین پپیشفرض:\n1⃣ ارسال پیام مکرر ممنوع.\n2⃣ اسپم ممنوع.\n3⃣ تبلیغ ممنوع.\n4⃣ سعی کنید از موضوع خارج نشید.\n5⃣ هرنوع نژاد پرستی, شاخ بازی و پورنوگرافی ممنوع .\n➡️ از قوانین پیروی کنید, در صورت عدم رعایت قوانین اول اخطار و در صورت تکرار مسدود."
 end
end
if data.username_ then
user_name = "@"..check_markdown(data.username_)
else
user_name = ""
end
		local welcome = welcome:gsub("{rules}", rules)
		local welcome = welcome:gsub("{name}", check_markdown(data.first_name_))
		local welcome = welcome:gsub("{username}", user_name)
		local welcome = welcome:gsub("{gpname}", arg.gp_name)
		tdcli.sendMessage(arg.chat_id, arg.msg_id, 0, welcome, 0, "md")
	end
	if data[tostring(chat)] and data[tostring(chat)]['settings'] then
	if msg.adduser then
		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "yes" then
			tdcli_function ({
	      ID = "GetUser",
      	user_id_ = msg.adduser
    	}, welcome_cb, {chat_id=chat,msg_id=msg.id,gp_name=msg.to.title})
		else
			return false
		end
	end
	if msg.joinuser then
		welcome = data[tostring(msg.to.id)]['settings']['welcome']
		if welcome == "yes" then
			tdcli_function ({
	      ID = "GetUser",
      	user_id_ = msg.joinuser
    	}, welcome_cb, {chat_id=chat,msg_id=msg.id,gp_name=msg.to.title})
		else
			return false
        end
		end
	end
-- return msg
 end
return {
patterns ={
"^[!/#]([Ii]d)$",
"^([Ii]d)$",
"^(آیدی)$",
"^(ایدی)$",
"^[!/#]([Ii]d) (.*)$",
"^([Ii]d) (.*)$",
"^(آیدی) (.*)$",
"^(ایدی) (.*)$",
"^[!/#]([Pp]in)$",
"^([Pp]in)$",
"^(سنجاق)$",
"^[!/#]([Uu]npin)$",
"^([Uu]npin)$",
"^(برداشتن سنجاق)$",
"^[!/#]([Gg]pinfo)$",
"^([Gg]pinfo)$",
"^(اطلاعات گروه)$",
"^[!/#]([Aa]dd)$",
"^([Aa]dd)$",
"^(نصب)$",
"^[!/#]([Rr]em)$",
"^([Rr]em)$",
"^(لغو نصب)$",
"^[!/#]([Ss]etowner)$",
"^([Ss]etowner)$",
"^(تنظیم مالک)$",
"^[!/#]([Ss]etowner) (.*)$",
"^([Ss]etowner) (.*)$",
"^(تنظیم مالک)$",
"^[!/#]([Rr]emowner)$",
"^([Rr]emowner)$",
"^(حذف مالک)$",
"^[!/#]([Rr]emowner) (.*)$",
"^([Rr]emowner) (.*)$",
"^(حذف مالک) (.*)$",
"^[!/#]([Pp]romote)$",
"^([Pp]romote)$",
"^(ترفیع)$",
"^[!/#]([Pp]romote) (.*)$",
"^([Pp]romote) (.*)$",
"^(ترفیع) (.*)$",
"^[!/#]([Dd]emote)$",
"^([Dd]emote)$",
"^(تنزل)$",
"^[!/#]([Dd]emote) (.*)$",
"^([Dd]emote) (.*)$",
"^(تنزل) (.*)$",
"^[!/#]([Mm]odlist)$",
"^([Mm]odlist)$",
"^(لیست ناظم)$",
"^[!/#]([Oo]wnerlist)$",
"^([Oo]wnerlist)$",
"^(لیست مالکان)$",
"^[!/#]([Ll]ock) (.*)$",
"^([Ll]ock) (.*)$",
"^(قفل) (.*)$",
"^[!/#]([Uu]nlock) (.*)$",
"^([Uu]nlock) (.*)$",
"^(بازکردن) (.*)$",
"^[!/#]([Ss]ettings)$",
"^([Ss]ettings)$",
"^(تنظیمات)$",
"^[!/#]([Mm]ute) (.*)$",
"^([Mm]ute) (.*)$",
"^(بیصدا) (.*)$",
"^[!/#]([Uu]nmute) (.*)$",
"^([Uu]nmute) (.*)$",
"^(باصدا) (.*)$",
"^[!/#]([Ll]ink)$",
"^([Ll]ink)$",
"^(لینک)$",
"^[!/#]([Ll]inkpv)$",
"^([Ll]inkpv)$",
"^(لینک پیوی)$",
"^[!/#]([Ss]etlink)$",
"^([Ss]etlink)$",
"^(تنظیم لینک)$",
"^[!/#]([Nn]ewlink)$",
"^([Nn]ewlink)$",
"^(لینک جدید)$",
"^[!/#]([Rr]ules)$",
"^([Rr]ules)$",
"^(قوانین)$",
"^[!/#]([Ss]etrules) (.*)$",
"^([Ss]etrules) (.*)$",
"^(تنظیم قوانین) (.*)$",
"^[!/#]([Aa]bout)$",
"^([Aa]bout)$",
"^(درباره گروه)$",
"^[!/#]([Ss]etabout) (.*)$",
"^([Ss]etabout) (.*)$",
"^(تنظیم درباره گروه) (.*)$",
"^[!/#]([Ss]etname) (.*)$",
"^([Ss]etname) (.*)$",
"^(تنظیم نام) (.*)$",
"^[!/#]([Cc]lean) (.*)$",
"^([Cc]lean) (.*)$",
"^(پاک کردن) (.*)$",
"^[!/#]([Ss]etflood) (%d+)$",
"^([Ss]etflood) (%d+)$",
"^(حساسیت اسپم) (%d+)$",
"^[!/#]([Rr]es) (.*)$",
"^([Rr]es) (.*)$",
"^(رس) (.*)$",
"^[!/#]([Ww]hois) (%d+)$",
"^([Ww]hois) (%d+)$",
"^(شخص) (%d+)$",
"^[!/#]([Hh]elp)$",
"^([Hh]elp)$",
"^(راهنما)$",
"^[!/#]([Ss]etlang) (.*)$",
"^([Ss]etlang) (.*)$",
"^(تنظیم زبان) (.*)$",
"^[#!/]([Ff]ilter) (.*)$",
"^([Ff]ilter) (.*)$",
"^(فیلتر) (.*)$",
"^[#!/]([Uu]nfilter) (.*)$",
"^([Uu]nfilter) (.*)$",
"^(حذف فیتلر) (.*)$",
"^[#!/]([Ff]ilterlist)$",
"^([Ff]ilterlist)$",
"^(لیست فیلتر)$",
"^([https?://w]*.?t.me/joinchat/%S+)$",
"^([https?://w]*.?telegram.me/joinchat/%S+)$",
"^[!/#]([Ss]etwelcome) (.*)",
"^([Ss]etwelcome) (.*)",
"^(تنظیم ولکام) (.*)",
"^[!/#]([Ww]elcome) (.*)$",
"^([Ww]elcome) (.*)$",
"^(ولکام) (.*)$"

},
run=run,
pre_process = pre_process
}
--End GroupManager.lua--
