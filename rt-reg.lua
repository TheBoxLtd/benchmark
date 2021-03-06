-- ../wrk/wrk -s rt-checkin.lua -c 100 -d 30 -t 4 http://localhost:4000 -- $USER 10000


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
local hostname = "unkn"
local threadname = "bot"

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

local counterReq = 0

function init(args)
   hostname = args[1]
   howMany = tonumber(args[2])

   threadname = 'bot' .. hostname
   -- wrk bug, first request wrk.format ignored by wrk and not counted
   if id == 1 then
      counterReq = -1
   end
   
   local msg = "thread %d created on host "..hostname
   threadname = id..threadname
   print(msg:format(id))
end

request = function()
   counterReq = counterReq + 1
   if counterReq > howMany then
      return nil
   end
   
   i = i + 1
   local headers = {}
   local postdata = '{"module":"rs","userName":"' .. threadname
      .. i
      .. '","password":123,"devicePlatform":"ios","deviceType":"type","name":"' .. threadname
      .. i
      .. '","sex":"male","birthday":"123", "benchUser":900}'
   return wrk.format("POST", "/user/1/add-custom-user", headers, postdata)
end

-- example script that demonstrates use of thread:stop()

local counterRes = 0

function response()
   counterRes = counterRes + 1
   if counterRes >= howMany then
      io.write("thread " .. id .. " finish\n")
      wrk.thread:stop()
   end
end
