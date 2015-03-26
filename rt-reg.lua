-- done = function(summary, latency, requests)
--    io.write("------------------------------\n")
--    for _, p in pairs({ 50, 90, 99, 99.999 }) do
--       n = latency:percentile(p)
--       io.write(string.format("%g%%,%d\n", p, n))
--    end
-- end

local counter = 1
local threads = {}

function setup(thread)
   thread:set("id", counter)
   table.insert(threads, thread)
   counter = counter + 1
end

local i = 0
local threadname = 'scrnzbot'

-- init = function(args)
--    local r = {}
--    local headers = {}
--
--    for i=1,10000 do
--       local postdata = '{"module":"rs","userName":"scrnzbot'
--          .. i
--          .. '","password":123,"devicePlatform":"ios","deviceType":"type","name":"scrnzbot'
--          .. i
--          .. '","sex":"male","birthday":"123"}'
--       r[i] = wrk.format("POST", "/user/1/add-custom-user", headers, postdata)
--    end
--
--    req = table.concat(r)
-- end

function init(args)
   local msg = "thread %d created"
   threadname = id..threadname
   print(msg:format(id))
end

request = function()
   i = i + 1
   local r
   local headers = {}
   local postdata = '{"module":"rs","userName":"' .. threadname
      .. i
      .. '","password":123,"devicePlatform":"ios","deviceType":"type","name":"' .. threadname
      .. i
      .. '","sex":"male","birthday":"123", "benchUser":900}'
   r = wrk.format("POST", "/user/1/add-custom-user", headers, postdata)
   return r
end

-- example script that demonstrates use of thread:stop()

local counter = 1

function response()
   -- if counter >= 5000 then
   --    io.write("thread finish\n")
   --    wrk.thread:stop()
   -- end
   -- counter = counter + 1
end
