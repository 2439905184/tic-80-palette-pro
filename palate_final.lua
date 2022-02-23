
red=0
green=0
blue=0
--config each key-elements

number=
{"00","01","02","03","04","05",
"06","07","08","09","0A","0B",
"0C","0D","0E","0F","10","11",
"12","13","14","15","16","17",
"18","19","1A","1B","1C","1D",
"1E","1F","20","21","22","23",
"24","25","26","27","28","29",
"2A","2B","2C","2D","2E","2F",
"30","31","32","33","34","35",
"36","37","38","39","3A","3B",
"3C","3D","3E","3F","40","41",
"42","43","44","45","46","47",
"48","49","4A","4B","4C","4D",
"4E","4F","50","51","52","53",
"54","55","56","57","58","59",
"5A","5B","5C","5D","5E","5F",
"60","61","62","63","64","65",
"66","67","68","69","6A","6B",
"6C","6D","6E","6F","70","71",
"72","73","74","75","76","77",
"78","79","7A","7B","7C","7D",
"7E","7F","80","81","82","83",
"84","85","86","87","88","89",
"8A","8B","8C","8D","8E","8F",
"90","91","92","93","94","95",
"96","97","98","99","9A","9B",
"9C","9D","9E","9F","A0","A1",
"A2","A3","A4","A5","A6","A7",
"A8","A9","AA","AB","AC","AD",
"AE","AF","B0","B1","B2","B3",
"B4","B5","B6","B7","B8","B9",
"BA","BB","BC","BD","BE","BF",
"C0","C1","C2","C3","C4","C5",
"C6","C7","C8","C9","CA","CB",
"CC","CD","CE","CF","D0","D1",
"D2","D3","D4","D5","D6","D7",
"D8","D9","DA","DB","DC","DD",
"DE","DF","E0","E1","E2","E3",
"E4","E5","E6","E7","E8","E9",
"EA","EB","EC","ED","EE","EF",
"F0","F1","F2","F3","F4","F5",
"F6","F7","F8","F9","FA","FB",
"FC","FD","FE","FF"}
--define number for increase or decrease
--this value is to use as different bar selection
--44 is selcte bar1
--56 is selcte bar2
--68 is select bar3
db=44
--define bars
--define button x
barRed=61
barGreen=61
barBlue=61
--define length of bars
local bar_width=54
local bar1_y=95
local bar2_y=95+12
local bar3_y=95+24

--precent 61/115 x/115
local precent1=0
local precent2=0
local precent3=0
function mouse_pressed()
  --in line1
  if db==44
  then 
    barRed=x
    precent1=(x-61)/54
    red=math.floor(255*precent1)
  elseif db==56
  then
  		barGreen=x
    precent2=(x-61)/54 
    green=math.floor(255*precent2)
  elseif db==68
  then
  		barBlue=x
    precent3=(x-61)/54
    blue=math.floor(255*precent3)
  end
end
--unused
local v_red
local v_green
local v_blue
function TIC()
  cls()
--get regb from data
 -- red=peek(0x14E04)
 -- green=peek(0x14E05)
 -- blue=peek(0x14E06)
  print("COLOR:",100,30,12)
--print("cent1:"..tostring(precent1),0,0,4)
--darw color rect

--this need to use value from address
--this need to translate rgb to hex 
		rect(73,45,90,30,1)
--draw color border
	 rectb(72,44,91,31,12)
--define example list
--save value to color rect
--0x03FC0 is palete start address
  poke(0x03FC3,red)
  poke(0x03FC4,green)
  poke(0x03FC5,blue)

	--	green=peek(0x03FC4,green)
	--	blue =peek(0x03FC5,blue)
 x,y,mp=mouse()
--in bar1
if(61<=x and x<=61+bar_width and y==bar1_y)
  then
    print("in bar1",0,80,4)
    db=44
    --mouse
    if mp
    then
      mouse_pressed()
    end
end
--in bar2
if(61<=x and x<=61+bar_width and y==bar2_y)
then
  print("in bar2",0,80,4)
  db=56
  if mp
  then
    mouse_pressed()
  end
end
--in bar3
if(61<=x and x<=61+bar_width and y==bar3_y)
then
  print("in bar3",0,80,4)
  db=68
  if mp
  then
    mouse_pressed()
  end
end
--key control up down
sel_bar()
left_right()
--key left right
 print("-=>",38,db+49,3)
--draw 3 bars background
 line(61,95,115,95,12)
 line(61,95+12,115,95+12,12)
 line(61,95+24,115,95+24,12)
--define three lines
--fill button color
 rect(barRed,92,3,7,13)
 rect(barGreen,92+12,3,7,13)
 rect(barBlue,92+24,3,7,13)
--define three bars
--stroke button border
 rectb(barRed,92,3,7,12)
 rectb(barGreen,92+12,3,7,12)
 rectb(barBlue,92+24,3,7,12)
--define three bar bottoms

 print("Red: "..red.."  NUM: "..number[red+1],119,93,12)
 print("Green: "..green.."  NUM: "..number[green+1],119,93+12,12)
 print("Blue: "..blue.."  NUM: "..number[blue+1],119,93+24,12)
--define details for rgb number

	print("Press allow keys to control",
		45,10,10)
 print("use mouse can control too",
 45,20,4)
 save()
 load()
 v_red  =peek(0x14E04)
 v_green=peek(0x14E05)
 v_blue =peek(0x14E06)
 print("r:"..tostring(v_red),0,85,4)
 print("g:"..tostring(v_green),0,95,4)
 print("b:"..tostring(v_blue),0,105,4)
end
function left_right()
  if btn(3) then 
    if db==44 and red<255 then 
     barRed=barRed+0.2 red=red+1 
      elseif db==56 and green<255 then
             barGreen=barGreen+0.2 green=green+1 
           elseif db==68 and blue<255 then
                     barBlue=barBlue+0.2 blue=blue+1
 end
 
 elseif btn(2) then 
     if db==44 and red>0 then 
         barRed=barRed-0.2 red=red-1 
       elseif db==56 and green>0 then
                 barGreen=barGreen-0.2 green=green-1 
         elseif db==68 and blue>0 then
                         barBlue=barBlue-0.2 blue=blue-1
     end
 end
end
--use keyboard to select bar
function sel_bar()
--key down
if(btnp(1) and db<60) 
 then 
 	 db=db+12
--key up 
 elseif(btnp(0) and db>50)
 then 
  	db=db-12 
 end
end
--save rgb
function save()
  --key:Z pad:A
  if btnp(4) then
  --save data to date address
    poke(0x14E04,red)
    poke(0x14E05,green)
    poke(0x14E06,blue)
  --save buton x
    poke(0x14E07,barRed)
    poke(0x14E08,barGreen)
    poke(0x14E09,barBlue)
		end
end
--load rgb
function load()
  --key:x pad:B
  if btnp(5) then
    --rgb
    red  = v_red
    green= v_green
    blue = v_blue
    --button x
    barRed  =peek(0x14E07)
    barGreen=peek(0x14E08)
    barBlue =peek(0x14E09)
  end
end