do

local function run(msg, matches)
if matches[1]=="من کیم" and is_sudo(msg) then 
return  "😘😘😘😍😍عشق منی خخخ سازندمی سودومی "
elseif matches[1]=="من کیم" and is_admin(msg) then 
return  "😎😎😎😎شما سازنده من نیستی ولی باید دستور رعایت منم "
elseif matches[1]=="من کیم" and is_owner(msg) then 
return  "😎😎😎تو مدیر و سازنده ای ولی برای من هیچی نیستی"
elseif matches[1]=="من کیم" and is_mod(msg) then 
return  "😂😂مدیری مدیر "
else
return  "😂😀😁تو هیچی نیستی هیچی"
end

end

return {
  patterns = {
    "^(من کیم)$",
    },
  run = run
}
end


--By @GODILOVEYOUME2
-- @GODILOVEYOUME