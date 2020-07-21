-- RCG GG Memory Utils
local rcg = {} local JAVA_HEAP = 2 local C_HEAP = 1 local C_ALLOC = 4 local C_DATA = 8 local C_BSS = 10 local A_ANONYMOUS = 32 local JAVA = 65536 local STACK = 64 local ASHMEM = 524288 local V_VIDEO = 1048576
local B_BAD = 131072
local CODE_APP = 16384
local CODE_SYSTEM = 32768
local BYTE = 1
local WORD = 2
local DWORD = 4
local XOR = 8
local FLOAT = 16
local QWORD = 32
local DOUBLE = 64
local AUTO = 127
function rcg.memoryUtils(succesMessage, notSuccessMessage, memoryRanges, memorySearch, memoryWrite, clearResults)
    gg.clearResults()
    gg.setVisible(false)
    gg.setRanges(memoryRanges)
    local valueType = memorySearch[1][3]
    local valueTypeModify = memoryWrite[1][3]
    gg.searchNumber(memorySearch[1][1], valueType)
    local valueCount = gg.getResultCount()
    local valueResult = gg.getResults(valueCount)
    gg.clearResults()
    local valueData = {} 
    local valueBase = memorySearch[1][2]
    if (valueCount > 0) then
        for i, v in ipairs(valueResult) do
            v.isUseful = true 
        end
        for k=2, #memorySearch do
            local valueTmp = {}
            local valueOffset = memorySearch[k][2] - valueBase 
            local valueNum = memorySearch[k][1] 
            for i, v in ipairs(valueResult) do
                valueTmp[#valueTmp+1] = {} 
                valueTmp[#valueTmp].address = v.address + valueOffset
                valueTmp[#valueTmp].flags = v.flags  
            end       
            valueTmp = gg.getValues(valueTmp)  
            for i, v in ipairs(valueTmp) do
                if ( tostring(v.value) ~= tostring(valueNum) ) then 
                    valueResult[i].isUseful = false 
                end
            end
        end
        for i, v in ipairs(valueResult) do
            if (v.isUseful) then 
                valueData[#valueData+1] = v.address
            end
        end
        if (#valueData > 0) then    
           local t = {}
           local valueBase = memorySearch[1][2]
           for i=1, #valueData do
               for k, w in ipairs(memoryWrite) do
                   valueOffset = w[2] - valueBase
                   t[#t+1] = {}
                   t[#t].address = valueData[i] + valueOffset
                   t[#t].flags = valueTypeModify
                   t[#t].value = w[1]           
                   if (w[4] == true) then
                       local valueItem = {}
                       valueItem[#valueItem+1] = t[#t]
                       valueItem[#valueItem].freeze = true
                       gg.addListItems(valueItem)
                   end         
               end
           end
           gg.setValues(t)
           gg.clearResults()
           if (succesMessage == nil ) then
           else
           Alert(succesMessage)
           end
        else
            if (notSuccessMessage == nil ) then
            else
            Alert(notSuccessMessage, false)
            end
            return false
        end
    else
            if (notSuccessMessage == nil ) then
            else
            Alert(notSuccessMessage)
            end
        return false
    end
end
function Toast(msg)
gg.toast(tostring(msg))
end
function Alert(msg)
gg.alert(tostring(msg))
end
function rcg.setMemoryRanges(ranges)
return ranges
end
function rcg.memorySearch(valueSearch)
return valueSearch
end
function rcg.memoryWrite(valueWrite)
return valueWrite
end
function rcg.clearResults()
gg.clearResults()
end
function succesMessage(msg)
return msg
end
function notSuccessMessage(msg)
return msg
end
-- RCG GG Memory Utils

function Main()
  MENU = gg.choice({
"V1",
"V2",
"V3",
"V4",
"V5",
"V6",
"V7",
"V8",
"Exit"},
nil,("MyAimbot"))
  if MENU == 1 then
rcg.memoryUtils(
succesMessage(nil),
notSuccessMessage(nil) ,
rcg.setMemoryRanges(A_ANONYMOUS),
rcg.memorySearch({{3.5, 0, FLOAT}, {1, 4, FLOAT}, {1, 8, FLOAT}, {1, 12, FLOAT}, {1, 16, FLOAT}, {0.5, 20, FLOAT}, {0.10000000149, 24, FLOAT}, }),
rcg.memoryWrite({{99999, 0, FLOAT, false}, {99999, 4, FLOAT, false}, {99999, 8, FLOAT, false}, {99999, 12, FLOAT, false}, {99999, 16, FLOAT, false}, {99999, 20, FLOAT, false}, {99999, 24, FLOAT, false}, }),
rcg.clearResults()
)
rcg.memoryUtils(
succesMessage(nil),
notSuccessMessage(nil) ,
rcg.setMemoryRanges(A_ANONYMOUS),
rcg.memorySearch({{3.5, 0, FLOAT}, {1, 4, FLOAT}, {0.5, 8, FLOAT}, {0.5, 12, FLOAT}, {0.25, 16, FLOAT}, {41, 20, FLOAT}, {100000, 24, FLOAT}, }),
rcg.memoryWrite({{99999, 0, FLOAT, false}, {99999, 4, FLOAT, false}, {99999, 8, FLOAT, false}, {99999, 12, FLOAT, false}, }),
rcg.clearResults()
)
rcg.memoryUtils(
succesMessage(nil),
notSuccessMessage(nil) ,
rcg.setMemoryRanges(A_ANONYMOUS),
rcg.memorySearch({{0.10000000149, 0, FLOAT}, {2, -4, FLOAT}, {2.25, -8, FLOAT}, {1.4012985e-45, -108, FLOAT}, {1, -112, FLOAT}, {0.44999998808, 4, FLOAT}, }),
rcg.memoryWrite({{99999, 0, FLOAT, false}, {99999, -112, FLOAT, false}, }),
rcg.clearResults()
)
rcg.memoryUtils(
succesMessage(nil),
notSuccessMessage(nil) ,
rcg.setMemoryRanges(A_ANONYMOUS),
rcg.memorySearch({{0.5, 0, FLOAT}, {0.80000001192, 4, FLOAT}, {0.80000001192, 8, FLOAT}, {200, 24, FLOAT}, }),
rcg.memoryWrite({{99999, 0, FLOAT, false}, {99999, 24, FLOAT, false}, {99999, 48, FLOAT, false}, {99999, 52, FLOAT, false}, {99999, 56, FLOAT, false}, {99999, 60, FLOAT, false}, {99999, 64, FLOAT, false}, {99999, 68, FLOAT, false}, {99999, 72, FLOAT, false}, }),
rcg.clearResults()
)
  end
  if MENU == 2 then
  rcg.memoryUtils(
succesMessage(nil),
notSuccessMessage(nil) ,
rcg.setMemoryRanges(A_ANONYMOUS),
rcg.memorySearch({{30, 0, FLOAT}, {3, 4, FLOAT}, {15, 8, FLOAT}, {1, 12, FLOAT}, }),
rcg.memoryWrite({{101, 12, FLOAT, false}, }),
rcg.clearResults()
)
  end
  if MENU == 3 then
  rcg.memoryUtils(
succesMessage(nil),
notSuccessMessage(nil) ,
rcg.setMemoryRanges(A_ANONYMOUS),
rcg.memorySearch({{2, 0, FLOAT}, {3, 4, FLOAT}, {2, 8, FLOAT}, {1, 12, FLOAT}, }),
rcg.memoryWrite({{101, 12, FLOAT, false}, }),
rcg.clearResults()
)
end
  if MENU == 4 then
rcg.memoryUtils(
succesMessage(nil),
notSuccessMessage(nil) ,
rcg.setMemoryRanges(A_ANONYMOUS),
rcg.memorySearch({{2, 0, FLOAT}, {3, 4, FLOAT}, {1, 8, FLOAT}, {7.352613e-42, 12, FLOAT}, }),
rcg.memoryWrite({{101, 8, FLOAT, false}, }),
rcg.clearResults()
)
end
  if MENU == 5 then 
rcg.memoryUtils(
succesMessage(nil),
notSuccessMessage(nil) ,
rcg.setMemoryRanges(A_ANONYMOUS),
rcg.memorySearch({{0.80000001192, 0, FLOAT}, {6.28308105469, 4, FLOAT}, {2.1019477e-44, 8, FLOAT}, {1.4012985e-45, 20, FLOAT}, }),
rcg.memoryWrite({{101, 24, FLOAT, false}, {101, 28, FLOAT, false}, {101, 32, FLOAT, false}, {101, 36, FLOAT, false}, }),
rcg.clearResults()
)
end
if MENU == 6 then 
rcg.memoryUtils(
succesMessage(nil),
notSuccessMessage(nil) ,
rcg.setMemoryRanges(A_ANONYMOUS),
rcg.memorySearch({{2, 0, FLOAT}, {32, 4, FLOAT}, {800, 8, FLOAT}, {5.72957754135, 12, FLOAT}, }),
rcg.memoryWrite({{101, 20, FLOAT, false}, {101, 28, FLOAT, false}, {101, 32, FLOAT, false}, {101, 36, FLOAT, false}, {101, 84, FLOAT, false}, {101, 92, FLOAT, false}, {101, 96, FLOAT, false}, {101, 100, FLOAT, false}, }),
rcg.clearResults()
)
end
if MENU == 7 then 

end
if MENU == 8 then 
rcg.memoryUtils(
succesMessage(nil),
notSuccessMessage(nil) ,
rcg.setMemoryRanges(A_ANONYMOUS),
rcg.memorySearch({{2.1019477e-44, 0, FLOAT}, {-5.9772977e-27, 4, FLOAT}, {6.4410544e-40, 8, FLOAT}, {3.9381366e-37, 12, FLOAT}, }),
rcg.memoryWrite({{101, 16, FLOAT, false}, }),
rcg.clearResults()
)
end
  if MENU == 9 then os.exit() end
XGCK = -1
end

while true do
  if gg.isVisible(true) then
    XGCK = 1
    gg.setVisible(false)
  end
  gg.clearResults()
  if XGCK == 1 then
    Main()
  end
end