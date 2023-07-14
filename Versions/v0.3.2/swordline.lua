-- title:   swordline
-- author:  iustin
-- desc:    dungeon crawler game
-- version: 0.3.2
-- script:  lua

function init()
bt4=0
choose_t=0
passives={
[1]={id=256,name="Accuracy",e=false,t1="Increase your",t2="base attack",t3="speed",ch=false},
[2]={id=257,name="Scrapper",e=false,t1="You can scrap",t2="weapons for",t3="3 gold",ch=false},
[3]={id=258,name="Critical",e=false,t1="+15% Critical",t2="",t3="",ch=false},
[4]={id=259,name="Berserker",e=false,t1="Small extra",t2="knockback",t3="",ch=false}
}
passives_tc={}
passives_eq={}
commonch=80
choose=false
touchid=0
kanimo=nil
rarech=15
epicch=5
legch=1
camera=0
controls=1
inverted=false
idanim=nil
xianim=nil
yjanim=nil
cam={x=120,y=68}
particles={}
loadingc=0
lod=""
misc={}
anim=49
rm={}
rm2={}
rmd={}
rmt={}
for i=0,9 do
rm[i]={}
rmd[i]={}
rmt[i]={}
end
quake=0
is=0
chesto=false
js=0
normsp={
[1]={
[1]={type={1},timer=30,amount=20},
[2]={type={1},timer=10,amount=10}
},
[2]={
[1]={type={2},timer=25,amount=15},
[2]={type={1,2},timer=20,amount=15}
},
[3]={
[1]={type={3},timer=15,amount=15},
[2]={type={1,3},timer=20,amount=20},
[3]={type={1},timer=5,amount=15}
},
[4]={
[1]={type={1,2,3},timer=20,amount=25},
[2]={type={3},timer=15,amount=25}
},
[5]={
[1]={type={9},timer=60,amount=1}
},
[6]={
[1]={type={4},timer=35,amount=20},
[2]={type={11},timer=20,amount=25}
},
[7]={
[1]={type={10},timer=45,amount=15},
[2]={type={11,4},timer=35,amount=25}
},
[8]={
[1]={type={5},timer=15,amount=10},
[2]={type={10,5},timer=30,amount=20}
},
[9]={
[1]={type={4,5,10,11},timer=40,amount=30}
},
[10]={
[1]={type={12},timer=60,amount=1}
},
[11]={
[1]={type={13},timer=40,amount=15},
[2]={type={8},timer=30,amount=25}
},
[12]={
[1]={type={6},timer=40,amount=25},
[2]={type={14},timer=45,amount=10}
},
[13]={
[1]={type={7},timer=5,amount=100},
[2]={type={14,8},timer=50,amount=20}
},
[14]={
[1]={type={14,6,13,8},timer=50,amount=25}
}
}
extrasp={
[4]={type={3},timer=30,amount=5},
[5]={type={1},timer=60,amount=1000},
[7]={type={1},timer=40,amount=10},
[8]={type={5},timer=60,amount=5},
[9]={type={5},timer=60,amount=5},
[10]={type={5},timer=200,amount=1000},
[11]={type={7},timer=30,amount=20},
[12]={type={7},timer=30,amount=20},
[13]={type={7},timer=30,amount=20},
[14]={type={7},timer=30,amount=20}
}
locolor=15
dir=0
t=0
lv=0
walk=0
chests={}
equip=1 --write the code of the weapon
        --you want to start with
								--codes range from 1 to 29
        --find the codes in the weapons={} table (line 135)
mtiers={
[1]={}
}
wrarities={
[1]={1,2,10,11,15,16,17,18,19,23,27},
[2]={3,5,6,13,22,24,14},
[3]={4,9,20,25,28},
[4]={7,8,12,21,29}
}
weapons={
[0]={name="0",id=0,rarity=0,dmg=0,sp=0,d=0,c=0},
[1]={name="Sword",id=496,rarity=1,dmg=2,sp=2,d=3,c=15},
[2]={name="Dagger",id=497,rarity=1,dmg=3,sp=3,d=1,c=15},
[3]={name="Billhook",id=498,rarity=2,dmg=4,sp=2,d=1,c=15},
[4]={name="Axe",id=499,rarity=3,dmg=3,sp=1,d=4,c=15,t1="Heavy",heavy=true},
[5]={name="Maul",id=500,rarity=2,dmg=2,sp=1,d=4,c=15,heavy=true,maul=true,
t1="Knockback",t2="Heavy"},
[6]={name="Chakram",id=501,rarity=2,dmg=2,sp=3,d=1,c=15,chakram=true},
[7]={name="Electro",id=504,rarity=4,dmg=1,sp=4,d=2,c=13,electro=true,
t1="Sends bolts",t2="of lightning"},
[8]={name="Blood",id=505,rarity=4,dmg=1,sp=5,d=3,c=6,blood=true,
t1="7% Lifesteal"},
[9]={name="Lancea",id=507,rarity=3,dmg=1,sp=4,d=5,c=15},
[10]={name="Cutlass",id=511,rarity=1,dmg=2,sp=4,d=2,c=15},
[11]={name="Goldrin",id=508,rarity=1,dmg=1,sp=4,d=2,c=14,goldrin=true,
t1="13% Fortune"},
[12]={name="Frost",id=506,rarity=4,dmg=2,sp=3,d=3,c=13,
frost=true,t1="20% Freeze"},
[13]={name="Rapier",id=510,rarity=2,dmg=1,sp=3,d=3,c=15,
thrust=2,t1="2 Thrust"},
[14]={name="Spear",id=509,rarity=2,dmg=1,sp=1,d=5,c=15,
thrust=1,t1="1 Thrust"},
[15]={name="Scimitar",id=480,rarity=1,dmg=3,sp=1,d=2,c=15},
[16]={name="Wooden",id=481,rarity=1,dmg=1,sp=5,d=2,c=15,
maul=true,t1="Knockback"},
[17]={name="Ghostly",id=482,rarity=1,dmg=2,sp=3,d=3,c=3,
t1="Cannot see",t2="the line"},
[18]={name="Mace",id=502,rarity=1,dmg=2,sp=2,d=2,c=15,
critical=40,t1="40% Critical"},
[19]={name="P. Shiv",id=503,rarity=1,dmg=1,sp=3,d=2,c=5,
poison=3,t1="3 Poison"},
[20]={name="Scythe",id=483,rarity=3,dmg=2,sp=1,d=4,c=1,scythe=true},
[21]={name="P. Katana",id=484,rarity=4,dmg=1,sp=2,d=3,c=5,
poison=100,t1="Poisons",t2="permanently"},
[22]={name="Orbital",id=485,rarity=2,dmg=1,sp=2,d=2,c=15,orbital=true,
t1="4 extra",t2="swords"},
[23]={name="Shield",id=486,rarity=1,dmg=2,sp=2,d=0,c=15,
shield=true,maul=true,t1="Knockback"},
[24]={name="D. Glaive",id=487,rarity=2,dmg=2,sp=3,d=2,c=15,dual=true},
[25]={name="Curser",id=488,rarity=3,dmg=2,sp=2,d=3,c=12,curse=true,
t1="Curses enemy",t2="with a sword"},
[26]={name="Excalibur",id=489,rarity=0,dmg=3,sp=3,d=3,c=15},
[27]={name="Flail",id=490,rarity=1,dmg=3,sp=1,d=4,c=15,flail=true},
[28]={name="Javelin",id=491,rarity=3,dmg=2,sp=2,d=4,c=15,throw=true,
t1="Use Z/A to",t2="throw"},
[29]={name="Stellar",id=492,rarity=4,dmg=1,sp=4,d=1,c=15,stellar=true,
t1="6 extra",t2="swords"},
}
curses={}
spawns={}
spawni=0
spawnj=0
spawnk=-1
chats={}
items={}
wall={}
bolts={}
--room={t=1,i=1,j=1}
--rooms={
--[1]={[1]={[1]=3,[2]=4},[2]={[1]=2,[2]=5}}
--}
menu={}
for i=0,4 do
menu[i]=false
end
menu[1]=true
selected={x=1,y=1}
for i=0,511 do
wall[i]=false
end
wall[1]=true
wall[16]=true
wall[17]=true
wall[33]=true
wall[36]=true
wall[37]=true
wall[38]=true
wall[39]=true
p={x=120+3.5*30*8,y=68+3.5*17*8,hp=5,mhp=5,im=0,gold=0,speed=0,critical=0,scrapper=false,knockback=0
,worthy=true}
enemies={}
local i=math.random(0,1)
local j=math.random(0,1)
deg=0
rest=0
l={x=0,y=0}

if x1 and x2 and x3 then
pal(8,x1,x2,x3)
end
x1,x2,x3=pal(8)

--end init
end

function create_javelin(cx,cy,cdeg)
mx=(cx+(4*4+3+8)*math.cos(math.rad(cdeg))+0.5)
my=(cy+(4*4+3+8)*math.sin(math.rad(cdeg))+0.5)
v={x=cx,y=cy,i=mx,j=my,javelin=true,deg=cdeg,d=4,pi=p.x,pj=p.y}
table.insert(bolts,v)
end

function create_chat(str)
v={s=str,t=0}
table.insert(chats,v)
end

function create_beam(xm,ym)

if p.x<xm then
r=-1
else
r=1
end

if xm-p.x~=0 then
m=(ym-p.y)/(xm-p.x)
d=25
i=xm+r*d*(1/math.sqrt(1+m*m))
j=ym+r*d*m*(1/math.sqrt(1+m*m))
else
if p.y<ym then
r=-1
else
r=1
end
d=25
i=xm
j=ym+r*d
end
v={x=xm+3,y=ym+4,xv=i+3,yv=j+4,c0=15,id=241,t=10}
table.insert(bolts,v)
end

function create_goblin(x2,y2)
v={x=x2,y=y2,id=25,cd=60,t=1}
table.insert(misc,v)
end

function create_altar(x2,y2)
v={x=x2,y=y2,id=46,activated=true}
table.insert(misc,v)
end

function create_excalibur(x2,y2)
v={x=x2,y=y2,id=110,activated=true}
table.insert(misc,v)
end

function create_area(x2,y2)
v={id=0,x=x2,y=y2,t=0,area=true}
table.insert(misc,v)
end

function add_curse(vx,vy,index)
v={x=vx,y=vy,id=index}
table.insert(curses,v)
end

function pal(i,r,g,b)
	--sanity checks
	if i<0 then i=0 end
	if i>15 then i=15 end
	--returning color r,g,b of the color
	if r==nil and g==nil and b==nil then
		return peek(0x3fc0+(i*3)),peek(0x3fc0+(i*3)+1),peek(0x3fc0+(i*3)+2)
	else
		if r==nil or r<0 then r=0 end
		if g==nil or g<0 then g=0 end
		if b==nil or b<0 then b=0 end
		if r>255 then r=255 end
		if g>255 then g=255 end
		if b>255 then b=255 end
		poke(0x3fc0+(i*3)+2,b)
		poke(0x3fc0+(i*3)+1,g)
		poke(0x3fc0+(i*3),r)
	end
end

function next_dungeon()
lv=lv+1

if lv>0 then
pal(8,117,113,97)
pal(3,78,74,78)
commonch=80
rarech=15
epicch=5
legch=1
end
if lv>5 then
pal(3,77,40,59)
pal(8,165,55,55)
commonch=65
rarech=25
epicch=10
legch=1
end
if lv>10 then
pal(8,125,40,170)
pal(3,40,45,80)
commonch=55
rarech=30
epicch=15
legch=1
end

if lv>1 and p.worthy==true then
for i=1,8 do
for j=1,15 do
if rmt[i][j]==2 then
p.worthy=false
break
end
end
end
end

for i,v in pairs(misc) do
misc[i]=nil
end
for i,v in pairs(items) do
items[i]=nil
end

for i=0,239 do
for j=0,135 do
mset(i,j,0)
end
end

for i,v in pairs(rm2) do
rm2[i]=nil
end

for i=1,8 do
for j=1,15 do
rm[i][j]=0
rmd[i][j]=0
rmt[i][j]=0
end
end
for i=0,9 do
rm[i][0]=-1
rm[i][16]=-1
end
for i=0,16 do
rm[0][i]=-1
rm[9][i]=-1
end
rand=math.random(4,5)
rm[rand][8]=2
rmd[rand][8]=1
rmt[rand][8]=1
p.x=7*16*8+8*8
p.y=(rand-1)*16*8+8*8

mx=p.x+3+3+weapons[equip].d*4+8
my=p.y+4
mx2=p.x+3+3+(weapons[equip].d*4+8)/3
my2=p.y+4

mx3=p.x+3+3+(weapons[equip].d*4+8)/3*2
my3=p.y+4

add_room(rand,8)
rd=1

for k=1,50 do
if lv%5~=0 then
rd=math.random(1,#rm2)
end
wallo=math.random(0,3)
typ=math.random(1,2)
i2=rm2[rd].i
j2=rm2[rd].j

if wallo==0 and rm[i2-1][j2]~=-1 then
if typ==2 then
ok=1
for i=i2-2,i2 do
for j=j2-1,j2+1 do
if rm[i][j]==2 then
ok=0
break
end
end
end
if ok==1 then
rm[i2-1][j2]=2
add_room(i2-1,j2)
rmt[i2-1][j2]=2
if lv%5==0 then
k=80
break
end
end
elseif typ==1 then
ok=0
for i=i2-2,i2 do
for j=j2-1,j2+1 do
if rm[i][j]==1 then
ok=ok+1
end
end
end
if rm[i2-1][j2]==0 and ok<2 then
rm[i2-1][j2]=1
add_room(i2-1,j2)
rd=#rm2
end
end
end

if wallo==1 and rm[i2+1][j2]~=-1 then
if typ==2 then
ok=1
for i=i2,i2+2 do
for j=j2-1,j2+1 do
if rm[i][j]==2 then
ok=0
break
end
end
end
if ok==1 then
rm[i2+1][j2]=2
add_room(i2+1,j2)
rmt[i2+1][j2]=2
if lv%5==0 then
k=80
break
end
end
elseif typ==1 then
ok=0
for i=i2,i2+2 do
for j=j2-1,j2+1 do
if rm[i][j]==1 then
ok=ok+1
end
end
end
if rm[i2+1][j2]==0 and ok<2 then
rm[i2+1][j2]=1
add_room(i2+1,j2)
rd=#rm2
end
end
end

if wallo==2 and rm[i2][j2-1]~=-1 then
if typ==2 then
ok=1
for i=i2-1,i2+1 do
for j=j2-2,j2 do
if rm[i][j]==2 then
ok=0
break
end
end
end
if ok==1 then
rm[i2][j2-1]=2
add_room(i2,j2-1)
rmt[i2][j2-1]=2
if lv%5==0 then
k=80
break
end
end
elseif typ==1 then
ok=0
for i=i2-1,i2+1 do
for j=j2-2,j2 do
if rm[i][j]==1 then
ok=ok+1
end
end
end
if rm[i2][j2-1]==0 and ok<2 then
rm[i2][j2-1]=1
add_room(i2,j2-1)
rd=#rm2
end
end
end

if wallo==3 and rm[i2][j2+1]~=-1 then
if typ==2 then
ok=1
for i=i2-1,i2+1 do
for j=j2,j2+2 do
if rm[i][j]==2 then
ok=0
break
end
end
end
if ok==1 then
rm[i2][j2+1]=2
add_room(i2,j2+1)
rmt[i2][j2+1]=2
if lv%5==0 then
k=80
break
end
end
elseif typ==1 then
ok=0
for i=i2-1,i2+1 do
for j=j2,j2+2 do
if rm[i][j]==1 then
ok=ok+1
end
end
end
if rm[i2][j2+1]==0 and ok<2 then
rm[i2][j2+1]=1
add_room(i2,j2+1)
rd=#rm2
end
end
end

--end for
end

for i=1,8 do
for j=1,15 do
if rm[i][j]==1 then
k=0
if rm[i-1][j]==1 or rm[i-1][j]==2 then
k=k+1
end
if rm[i+1][j]==1 or rm[i+1][j]==2 then
k=k+1
end
if rm[i][j-1]==1 or rm[i][j-1]==2 then
k=k+1
end
if rm[i][j+1]==1 or rm[i][j+1]==2 then
k=k+1
end
if k<=1 then
wallo=0
while wallo<=3 do
if wallo==0 and rm[i-1][j]==0 and adjacent(i-1,j)==false then
rm[i-1][j]=2
add_room(i-1,j)
rmt[i-1][j]=2
break
end
if wallo==1 and rm[i+1][j]==0 and adjacent(i+1,j)==false then
rm[i+1][j]=2
add_room(i+1,j)
rmt[i+1][j]=2
break
end
if wallo==2 and rm[i][j-1]==0 and adjacent(i,j-1)==false then
rm[i][j-1]=2
add_room(i,j-1)
rmt[i][j-1]=2
break
end
if wallo==3 and rm[i][j+1]==0 and adjacent(i,j+1)==false then
rm[i][j+1]=2
add_room(i,j+1)
rmt[i][j+1]=2
break
end
wallo=wallo+1
end
if wallo==4 then
rm[i][j]=0
end
end
end
end
end

for i=1,8 do
for j=1,15 do
if rm[i][j]==1 then

wl={}
if rm[i-1][j]==1 then
wl[#wl+1]={i2=i-1,j2=j}
end
if rm[i+1][j]==1 then
wl[#wl+1]={i2=i+1,j2=j}
end
if rm[i][j-1]==1 then
wl[#wl+1]={i2=i,j2=j-1}
end
if rm[i][j+1]==1 then
wl[#wl+1]={i2=i,j2=j+1}
end
if #wl>2 then

end


end
end
end

maxi=0
i2=0
j2=0
rmpf={}
for i=0,9*16 do
rmpf[i]={}
end
rmm={}
for i=1,8 do
rmm[i]={}
for j=1,15 do
rmm[i][j]=0
end
end
rec(rand,8,1)
for i=1,8 do
for j=1,15 do
if rm[i][j]==2 and rmm[i][j]>maxi then
maxi=rmm[i][j]
i2=i
j2=j
end
end
end
rmt[i2][j2]=3
rmm[i2][j2]=0

rando=math.random(1,3)
if rando==1 and lv%5~=0 then
i2=0
j2=0
maxi=0
for i=1,8 do
for j=1,15 do
if rm[i][j]==2 and rmm[i][j]>maxi then
maxi=rmm[i][j]
i2=i
j2=j
end
end
end
rmt[i2][j2]=5
rmm[i2][j2]=0
create_goblin((j2-1)*16*8+8*8-2,(i2-1)*16*8+8*8-8)
for yo=-1,1 do
rando=math.random(1,100)
if rando<=5 then
rando2=wrarities[4][math.random(1,#wrarities[4])]
cost=math.random(35,45)
elseif rando<=20 then
rando2=wrarities[3][math.random(1,#wrarities[3])]
cost=math.random(25,30)
elseif rando<=50 then
rando2=wrarities[2][math.random(1,#wrarities[2])]
cost=math.random(12,17)
else
rando2=wrarities[1][math.random(1,#wrarities[1])]
cost=math.random(5,10)
end
create_item(rando2,(j2-1)*16*8+8*8+20*yo-4,(i2-1)*16*8+8*8+11,cost)
end
end

rando=math.random(1,3)
if rando==1 and lv%5~=0 then
i2=0
j2=0
maxi=0
for i=1,8 do
for j=1,15 do
if rm[i][j]==2 and rmm[i][j]>maxi then
maxi=rmm[i][j]
i2=i
j2=j
end
end
end
rmt[i2][j2]=5
rmm[i2][j2]=0
create_altar((j2-1)*16*8+8*8-2-4,(i2-1)*16*8+8*8-8)
end

rando=math.random(1,100)
if rando==1 and lv%5~=0 then
i2=0
j2=0
maxi=0
for i=1,8 do
for j=1,15 do
if rm[i][j]==2 and rmm[i][j]>maxi then
maxi=rmm[i][j]
i2=i
j2=j
end
end
end
rmt[i2][j2]=5
create_excalibur((j2-1)*16*8+8*8-2-4,(i2-1)*16*8+8*8-8)
end


for i=1,8 do
for j=1,15 do
if rm[i][j]==2 then
create_room(j*16-16,i*16-16,16,16)
if rmt[i][j]==2 or rmt[i][j]==3 and lv%5~=0 then
type=math.random(0,11)
local x=j*16-16
local y=i*16-16
if type==1 then
for i=4,10 do
mset(x+5,y+i,33)
end
mset(x+5,y+11,1)
for i=4,10 do
mset(x+10,y+i,33)
end
mset(x+10,y+11,1)
elseif type==2 then
for i=4,11 do
mset(x+i,y+5,1)
end
for i=4,11 do
mset(x+i,y+10,1)
end
elseif type==3 then
for i=0,10 do
mset(x+5,y+i,33)
end
mset(x+5,y+11,1)
for i=0,10 do
mset(x+10,y+i,33)
end
mset(x+10,y+11,1)
elseif type==4 then
for i=0,10 do
mset(x+5,y+i,33)
end
mset(x+5,y+11,1)
for i=5,14 do
mset(x+10,y+i,33)
end
elseif type==5 then
for i=5,14 do
mset(x+5,y+i,33)
end
for i=0,10 do
mset(x+10,y+i,33)
end
mset(x+10,y+11,1)
elseif type==6 then
for i=1,10 do
mset(x+i,y+5,1)
end
for i=1,10 do
mset(x+i,y+10,1)
end
elseif type==7 then
for i=4,11 do
mset(x+i,y+4,1)
mset(x+i,y+11,1)
end
for i=4,11 do
mset(x+4,y+i,33)
mset(x+11,y+i,33)
end
mset(x+4,y+11,1)
mset(x+11,y+11,1)
for i=7,8 do
mset(x+i,y+4,17)
end
elseif type==8 then
for i=3,12 do
mset(x+i,y+7,33)
end
for i=3,12 do
mset(x+i,y+8,1)
end
for i=3,11 do
mset(x+7,y+i,33)
end
for i=3,11 do
mset(x+8,y+i,33)
end
mset(x+7,y+12,1)
mset(x+8,y+12,1)
elseif type==9 then
for i=0,10 do
mset(x+5,y+i,33)
end
mset(x+5,y+11,1)
elseif type==10 then
for i=4,14 do
mset(x+10,y+i,33)
end
elseif type==11 then
for i=0,4 do
for j=0,4 do
mset(x+i,y+j,0)
end
end
for i=0,5 do
mset(x+5,y+i,33)
end
for i=0,5 do
mset(x+i,y+5,1)
end
for i=11,15 do
for j=0,4 do
mset(x+i,y+j,0)
end
end
for i=0,5 do
mset(x+10,y+i,33)
end
for i=10,15 do
mset(x+i,y+5,1)
end
for i=0,4 do
for j=11,15 do
mset(x+i,y+j,0)
end
end
for i=0,4 do
mset(x+i,y+10,1)
end
for i=10,15 do
mset(x+5,y+i,33)
end
for i=11,15 do
for j=11,15 do
mset(x+i,y+j,0)
end
end
for i=10,15 do
mset(x+i,y+10,1)
end
for i=10,15 do
mset(x+10,y+i,33)
end
if mget(x+0,y+6)==33 then
mset(x+0,y+5,33)
end
if mget(x+15,y+6)==33 then
mset(x+15,y+5,33)
end
if mget(x+6,y+15)==1 then
mset(x+5,y+15,1)
mset(x+10,y+15,1)
end

end
end
if rm[i-1][j]==1 or rm[i-1][j]==2 then
mset(j*16-16+7,i*16-16,2)
mset(j*16-16+8,i*16-16,2)
mset(j*16-16+6,i*16-16,2)
mset(j*16-16+9,i*16-16,2)
end
if rm[i+1][j]==1 or rm[i+1][j]==2 then
mset(j*16-16+7,i*16-16+15,2)
mset(j*16-16+8,i*16-16+15,2)
mset(j*16-16+6,i*16-16+15,2)
mset(j*16-16+9,i*16-16+15,2)
mset(j*16-16+5,i*16-16+15,33)
mset(j*16-16+10,i*16-16+15,33)
end
if rm[i][j-1]==1 or rm[i][j-1]==2 then
mset(j*16-16,i*16-16+7,2)
mset(j*16-16,i*16-16+8,2)
mset(j*16-16,i*16-16+6,2)
mset(j*16-16,i*16-16+9,2)
mset(j*16-16,i*16-16+5,1)
--mset(j*16-16,i*16-16+10,33)
end
if rm[i][j+1]==1 or rm[i][j+1]==2 then
mset(j*16-16+15,i*16-16+7,2)
mset(j*16-16+15,i*16-16+8,2)
mset(j*16-16+15,i*16-16+6,2)
mset(j*16-16+15,i*16-16+9,2)
mset(j*16-16+15,i*16-16+5,1)
--mset(j*16-16+15,i*16-16+10,33)
end
elseif rm[i][j]==1 then
create_room(j*16-16+5,i*16-16+5,6,6)

if rm[i-1][j]==1 or rm[i-1][j]==2 then
create_room(j*16-16+5,i*16-16,6,6)
mset(j*16-16+6,i*16-16,2)
mset(j*16-16+7,i*16-16,2)
mset(j*16-16+9,i*16-16,2)
mset(j*16-16+8,i*16-16,2)
mset(j*16-16+6,i*16-16+5,2)
mset(j*16-16+7,i*16-16+5,2)
mset(j*16-16+9,i*16-16+5,2)
mset(j*16-16+8,i*16-16+5,2)
mset(j*16-16+10,i*16-16+5,33)
mset(j*16-16+5,i*16-16+5,33)
end


if rm[i][j-1]==1 or rm[i][j-1]==2 then
create_room(j*16-16,i*16-16+5,6,6)
mset(j*16-16,i*16-16+7,2)
mset(j*16-16,i*16-16+6,2)
mset(j*16-16,i*16-16+8,2)
mset(j*16-16,i*16-16+9,2)
mset(j*16-16,i*16-16+5,1)
mset(j*16-16+5,i*16-16+7,2)
mset(j*16-16+5,i*16-16+6,2)
mset(j*16-16+5,i*16-16+8,2)
mset(j*16-16+5,i*16-16+9,2)
mset(j*16-16+5,i*16-16+5,1)
end
if rm[i][j+1]==1 or rm[i][j+1]==2 then
create_room(j*16-16+10,i*16-16+5,6,6)
mset(j*16-16+10,i*16-16+7,2)
mset(j*16-16+10,i*16-16+6,2)
mset(j*16-16+10,i*16-16+8,2)
mset(j*16-16+10,i*16-16+9,2)
mset(j*16-16+10,i*16-16+5,1)
mset(j*16-16+15,i*16-16+7,2)
mset(j*16-16+15,i*16-16+6,2)
mset(j*16-16+15,i*16-16+8,2)
mset(j*16-16+15,i*16-16+9,2)
mset(j*16-16+15,i*16-16+5,1)
end


if rm[i+1][j]==1 or rm[i+1][j]==2 then
create_room(j*16-16+5,i*16-16+10,6,6)
mset(j*16-16+6,i*16-16+15,2)
mset(j*16-16+7,i*16-16+15,2)
mset(j*16-16+9,i*16-16+15,2)
mset(j*16-16+8,i*16-16+15,2)
mset(j*16-16+6,i*16-16+10,2)
mset(j*16-16+5,i*16-16+15,33)
mset(j*16-16+10,i*16-16+15,33)
mset(j*16-16+7,i*16-16+10,2)
mset(j*16-16+9,i*16-16+10,2)
mset(j*16-16+8,i*16-16+10,2)

end

end
end
end
end

function create_stairs(x1,y1)
v={x=x1,y=y1,id=24}
table.insert(misc,v)
end

function create_gold(x1,y1)
v={id=21,x=x1,y=y1,ey=math.floor(y1),vx=math.random(-5,5)/10,
vy=math.random(-20,0)/10,t=60*60}
v.ey=math.random(v.ey+2,v.ey+4)
table.insert(misc,v)
end

function create_heart(x1,y1)
v={id=23,x=x1,y=y1,ey=math.floor(y1),vx=math.random(-5,5)/10,
vy=math.random(-20,0)/10,t=600*6}
v.ey=math.random(v.ey+2,v.ey+4)
table.insert(misc,v)
end

function create_explosion(x1,y1)
v={x=x1,y=y1,r=15,c=14,t=10}
table.insert(bolts,v)
end


function create_explosion2(x1,y1)
v={x=x1,y=y1,r=15,c=12,t=10}
table.insert(bolts,v)
end

function create_bomber(x1,y1)
v={id=181,t=30,x=x1,y=y1}
table.insert(misc,v)
end

function create_chest(x1,y1)
v={id=19,x=x1,y=y1,t=1200}
table.insert(misc,v)
end

function create_stairs(x1,y1)
v={id=24,x=x1,y=y1}
table.insert(misc,v)
end

function create_portal1(x1,y1,r1)
v={x=x1,y=y1,r=r1,id=40,t=0}
table.insert(misc,v)
end

function create_particle(x1,y1,c1,upa,t1)
v={x=x1,y=y1,ey=math.floor(y1),vx=math.random(-5,5)/10,
vy=math.random(-20,0)/10,c=c1,t=t1 or 60*5,up=upa}
v.ey=math.random(v.ey+2,v.ey+4)
table.insert(particles,v)
end

function create_spawn(i2,j2,type2,timer2,amount2)
v={type=type2,timer=timer2,cd=timer2,
i=i2,j=j2,amount=amount2}
table.insert(spawns,v)
end

function rec(i,j,k)
rmm[i][j]=k
local dir
for dir=0,3 do
if dir==0 and (rm[i-1][j]==1 or rm[i-1][j]==2) 
and (rmm[i-1][j]==0 or k+1<rmm[i-1][j]) then
rec(i-1,j,k+1)
end
if dir==2 and (rm[i+1][j]==1 or rm[i+1][j]==2) 
and (rmm[i+1][j]==0 or k+1<rmm[i+1][j]) then
rec(i+1,j,k+1)
end
if dir==3 and (rm[i][j-1]==1 or rm[i][j-1]==2) 
and (rmm[i][j-1]==0 or k+1<rmm[i][j-1]) then
rec(i,j-1,k+1)
end
if dir==1 and (rm[i][j+1]==1 or rm[i][j+1]==2) 
and (rmm[i][j+1]==0 or k+1<rmm[i][j+1]) then
rec(i,j+1,k+1)
end
end

end

function adjacent(x,y)
for i=x-1,x+1 do
for j=y-1,y+1 do
if rm[i][j]==2 then
return true
end
end
end
return false
end

function add_room(x,y)
v={i=x,j=y}
table.insert(rm2,v)
end

function create_room(x,y,sx,sy)

for i=x,x+sx-1 do
mset(i,y,1)
end

for j=y,y+sy-1 do
mset(x,j,33)
mset(x+sx-1,j,33)
end

for i=x,x+sx-1 do
mset(i,y+sy-1,1)
end

for i=x+1,x+sx-2 do
for j=y+1,y+sy-2 do
mset(i,j,2)
end
end



end

function create_item(id,i,j,cost1,inside,pi,pj)
if id~=0 then
v={code=id,x=i,y=j,ey=math.floor(j),vx=math.random(-5,5)/10,
vy=math.random(-20,-10)/10,cost=cost1}
if inside then
if v.y>pj then
v.y=v.y-8
v.ey=math.floor(v.y)
v.ey=math.random(v.ey-4,v.ey-2)
else
v.ey=math.random(v.ey+2,v.ey+4)
end
if v.x>pi then
v.vx=math.random(-6,-5)/10
else
v.vx=math.random(5,6)/10
end
else
v.ey=math.random(v.ey+2,v.ey+4)
end
table.insert(items,v)
end
end

function create_bolt(x1,y1,i1,j1)
v={x=x1,y=y1,i=i1,j=j1,c=15,t=10}
table.insert(bolts,v)
end

function create_enemy(i,j,type)

if type==1 then
v={x=i,y=j,hp=2,id=65,sp=0.75,r=2,im=false,frozen=0,poison=0,big=0,cursed=0}
elseif type==2 then
v={x=i,y=j,hp=5,id=81,sp=0.25,r=3,im=false,frozen=0,poison=0,big=0,cursed=0}
elseif type==3 then
v={x=i,y=j,hp=1,id=97,sp=1,r=1,im=false,frozen=0,poison=0,big=0,cursed=0}
elseif type==4 then
v={x=i,y=j,hp=4,id=129,sp=0.75,r=3,im=false,frozen=0,big=0,poison=0,cursed=0}
elseif type==5 then
v={x=i,y=j,hp=1,id=177,sp=0.75,r=1,im=false,big=0,frozen=0,poison=0,cursed=0}
elseif type==6 then
v={x=i,y=j,hp=4,id=209,sp=0.25,r=2,im=false,frozen=0,
cdsp=math.random(100,200),poison=0,big=0,cursed=0}
elseif type==7 then
v={x=i,y=j,hp=1,id=225,sp=0.5,r=1,im=false,big=0,frozen=0,poison=0,cursed=0}
elseif type==8 then
v={x=i,y=j,hp=3,id=113,sp=0.1,r=2,im=false,frozen=0,
cdpr=math.random(100,200),poison=0,big=0,cursed=0}
elseif type==9 then
v={x=i,y=j,hp=80,id=229,sp=0.75,r=4,big=4,im=false,frozen=0,poison=0,
cdsw=math.random(200,300),deg=360,cursed=0}
elseif type==10 then
v={x=i,y=j,hp=3,id=86,sp=0.5,r=2,im=false,frozen=0,cursed=0,
cdfl=3,poison=0,big=0}
elseif type==11 then
v={x=i,y=j,hp=7,id=193,sp=0.25,r=3,im=false,big=0,frozen=0,poison=0,cursed=0}
elseif type==12 then
v={x=i,y=j,hp=40,id=197,sp=0.25,r=5,big=4,im=false,frozen=0,poison=0,
cdfball=math.random(300,400),cdfl=2,cdmball=math.random(200,300),cursed=0}
elseif type==13 then
v={x=i,y=j,hp=5,id=118,sp=0.25,r=3,im=false,big=0,frozen=0,poison=0,cursed=0,cdar=math.random(100,200)}
elseif type==14 then
v={x=i,y=j,hp=6,id=241,sp=0.5,r=3,im=false,big=0,frozen=0,poison=0,cursed=0,cdbeam=math.random(100,200)}
end

table.insert(enemies,v)

if type~=9 and type~=12 then
create_portal1(i+v.r+1,j,v.r)
end

end

function create_flame(xm,ym,type)

pxo=p.x+math.random(-3,3)
pyo=p.y+math.random(-3,3)

if pxo<xm then
r=-1
else
r=1
end

if xm-pxo~=0 then
m=(ym-(pyo))/(xm-(pxo))
if type==1 then
d=0.5
else
d=0.75
end
i=xm+r*d*(1/math.sqrt(1+m*m))
j=ym+r*d*m*(1/math.sqrt(1+m*m))
else

if pyo<ym then
r=-1
else
r=1
end
if type==1 then
d=0.6
else
d=0.75
end
i=xm
j=ym+r*d
end
v={id=0,x=xm,y=ym,xv=i-xm,yv=j-ym,color=nil,r=1,t=0,flame=true}
rand=math.random(1,2)
if rand==1 then
v.color=6
else
if type==1 then
v.color=9
else
v.color=14
end
end
table.insert(bolts,v)

end

function create_balldirection(xm,ym,xp,yp)
if xp<xm then
r=-1
else
r=1
end
if xm-xp~=0 then
m=(ym-yp)/(xm-xp)
d=0.9
i=xm+r*d*(1/math.sqrt(1+m*m))
j=ym+r*d*m*(1/math.sqrt(1+m*m))
else
if yp<ym then
r=-1
else
r=1
end
d=0.9
i=xm
j=ym+r*d
end
v={id=0,x=xm,y=ym,xv=i-xm,yv=j-ym,color=nil,r=3,t=0,ball=true}
rand=math.random(1,2)
if rand==1 then
v.color=6
else
v.color=14
end
table.insert(bolts,v)
end

function create_fireball(xm,ym)

if p.x<xm then
r=-1
else
r=1
end
if xm-p.x~=0 then
m=(ym-p.y)/(xm-p.x)
d=1.5
i=xm+r*d*(1/math.sqrt(1+m*m))
j=ym+r*d*m*(1/math.sqrt(1+m*m))
else
if p.y<ym then
r=-1
else
r=1
end
d=1.5
i=xm
j=ym+r*d
end
v={id=0,x=xm,y=ym,xv=i-xm,yv=j-ym,color=nil,r=9,t=0,ball=true}
rand=math.random(1,2)
if rand==1 then
v.color=6
else
v.color=14
end
table.insert(bolts,v)
end

function create_magic(xm,ym)

if p.x<xm then
r=-1
else
r=1
end

if xm-p.x~=0 then
m=(ym-p.y)/(xm-p.x)
d=0.75
i=xm+r*d*(1/math.sqrt(1+m*m))
j=ym+r*d*m*(1/math.sqrt(1+m*m))
else
if p.y<ym then
r=-1
else
r=1
end
d=0.75
i=xm
j=ym+r*d
end
v={x=xm,y=ym,xv=i-xm,yv=j-ym,id=56,t=0}
table.insert(bolts,v)
end

function move()

gk=1
ak=0.75
if weapons[equip].heavy then
gk=0.8
ak=0.6
end

if ((controls==1 and key(23))or(controls>=2 and btn(0))) and collide(p.x+3,p.y+4,3,0)==false then
if ((controls==1 and key(1))or(controls>=2 and btn(2))) and collide(p.x+3,p.y+4,3,2)==false then
p.y=p.y-ak
p.x=p.x-ak
mx=mx-ak
my=my-ak
walk=1
dir=1
elseif ((controls==1 and key(4))or(controls>=2 and btn(3))) and collide(p.x+3,p.y+4,3,3)==false then
p.y=p.y-ak
p.x=p.x+ak
mx=mx+ak
my=my-ak
walk=1
dir=0
else
p.y=p.y-gk
my=my-gk
walk=1
end
elseif ((controls==1 and key(19))or(controls>=2 and btn(1))) and collide(p.x+3,p.y+4,3,1)==false then
if ((controls==1 and key(1))or(controls>=2 and btn(2))) and collide(p.x+3,p.y+4,3,2)==false then
p.y=p.y+ak
p.x=p.x-ak
mx=mx-ak
my=my+ak
walk=1
dir=1
elseif ((controls==1 and key(4))or(controls>=2 and btn(3))) and collide(p.x+3,p.y+4,3,3)==false then
p.y=p.y+ak
p.x=p.x+ak
mx=mx+ak
my=my+ak
walk=1
dir=0
else
p.y=p.y+gk
my=my+gk
walk=1
end
elseif ((controls==1 and key(1))or(controls>=2 and btn(2))) and collide(p.x+3,p.y+4,3,2)==false then
p.x=p.x-gk
mx=mx-gk
walk=1
dir=1
elseif ((controls==1 and key(4))or(controls>=2 and btn(3))) and collide(p.x+3,p.y+4,3,3)==false then
p.x=p.x+gk
mx=mx+gk
walk=1
dir=0
end

ad=2
ml=math.floor(p.speed*weapons[equip].sp)
for i=1,weapons[equip].sp+1 do
ad=ad+math.floor(i/2)
end
--ml=math.floor((weapons[equip].sp)/2)
--if weapons[equip].sp==5 then
--ml=ml-1
--end



if equip~=0 then

if controls==1 then
if btn(3) then
deg=deg+(ad+ml)
if deg>360 then
deg=1
end
end
elseif controls==2 then
if btn(7) then
deg=deg+(ad+ml)
if deg>360 then
deg=1
end
end
elseif controls==3 then
if btn(5) then
deg=deg+(ad+ml)
if deg>360 then
deg=1
end
end
end

if controls==1 then
if btn(2) then
deg=deg-(ad+ml)
if deg<0 then
deg=359
end
end
elseif controls==2 then
if btn(6) then
deg=deg-(ad+ml)
if deg<0 then
deg=359
end
end
elseif controls==3 then
if btn(6) then
deg=deg-(ad+ml)
if deg<0 then
deg=359
end
end
end

end


for i,v in pairs(items) do
if math.abs(v.x+1-p.x)<8 and math.abs(v.y-p.y)<8 then
if btnp(4) then
bt4=0
if v.cost==0 then
aux=equip
equip=v.code
if aux~=0 then
v.code=aux
else
table.remove(items,i)
end
elseif p.gold>=v.cost then
p.gold=p.gold-v.cost
v.cost=0
end
elseif btnp(5) and p.scrapper==true then
for i2=1,3 do
create_gold(v.x+3,v.y+4)
end
quake=quake+10
items[i]=nil
end
end
end

local enemi=false
for i,v in pairs(enemies) do
enemi=true
if v.frozen==0 then
local direc={
[0]={x=0,y=0},
[1]={x=0,y=-1},
[2]={x=1,y=-1},
[3]={x=1,y=0},
[4]={x=1,y=1},
[5]={x=0,y=1},
[6]={x=-1,y=1},
[7]={x=-1,y=0},
[8]={x=-1,y=-1},
}
local mini=0
local miniv=1000
vx=(v.x+3)//8
vy=(v.y+4)//8
if rmpf[vy][vx]~=-1 then
for i=1,8 do
if rmpf[vy+direc[i].y][vx+direc[i].x]~=nil
and rmpf[vy+direc[i].y][vx+direc[i].x]~=-1 and
 rmpf[vy+direc[i].y][vx+direc[i].x]<rmpf[vy][vx] and
rmpf[vy+direc[i].y][vx+direc[i].x]<miniv then
mini=i
miniv=rmpf[vy+direc[i].y][vx+direc[i].x]
end
end
if direc[mini].x~=0 and direc[mini].y~=0 then
walk2=math.random(1,2)
if walk2==1 and wall[mget((v.x+3+(v.sp+v.r)*direc[mini].x)//8,(v.y+4)//8)]==false then
v.x=v.x+v.sp*direc[mini].x
elseif wall[mget((v.x+3)//8,(v.y+4+(v.sp+v.r)*direc[mini].y)//8)]==false then
v.y=v.y+v.sp*direc[mini].y
end
else
if wall[mget((v.x+3+(v.sp+v.r)*direc[mini].x)//8,(v.y+4+(v.sp+v.r)*direc[mini].y)//8)]==false then
v.x=v.x+v.sp*direc[mini].x
v.y=v.y+v.sp*direc[mini].y
end
end
else
walk2=math.random(1,2)
if walk2==1 or math.abs(p.y-v.y)<=1 then
if (p.x>v.x+v.big and collide(v.x+3+v.big,v.y+4+v.big,v.r,3)==false) then
v.x=v.x+v.sp
elseif p.x<v.x+v.big and collide(v.x+3+v.big,v.y+4+v.big,v.r,2)==false then
v.x=v.x-v.sp
end
elseif walk2==2 or math.abs(p.x-v.x)<=1  then
if p.y>v.y+v.big and collide(v.x+3+v.big,v.y+4+v.big,v.r,1)==false then
v.y=v.y+v.sp
elseif p.y<v.y+v.big and collide(v.x+3+v.big,v.y+4+v.big,v.r,0)==false then
v.y=v.y-v.sp
end
end
end

if (v.id==118 or v.id==134) and (v.x-p.x)*(v.x-p.x)+(v.y-p.y)*(v.y-p.y)<=(30+v.big)*(30+v.big) then

if walk2==1 or math.abs(p.y-v.y)<=1 then
if (p.x>v.x+v.big and collide(v.x+3+v.big,v.y+4+v.big,v.r,3)==false) then
v.x=v.x-v.sp-1
elseif p.x<v.x+v.big and collide(v.x+3+v.big,v.y+4+v.big,v.r,2)==false then
v.x=v.x+v.sp+1
end
elseif walk2==2 or math.abs(p.x-v.x)<=1  then
if p.y>v.y+v.big and collide(v.x+3+v.big,v.y+4+v.big,v.r,1)==false then
v.y=v.y-v.sp-1
elseif p.y<v.y+v.big and collide(v.x+3+v.big,v.y+4+v.big,v.r,0)==false then
v.y=v.y+v.sp+1
end
end
end

end


while wall[mget((v.x+3+v.big-v.r)//8,(v.y+4+v.big-v.r)//8)]==true 
and wall[mget((v.x+3+v.big+v.r)//8,(v.y+4+v.big-v.r)//8)]==true do
v.y=v.y+1
end
while wall[mget((v.x+3+v.big-v.r)//8,(v.y+4+v.big+v.r)//8)]==true 
and wall[mget((v.x+3+v.big+v.r)//8,(v.y+4+v.big+v.r)//8)]==true do
v.y=v.y-1
end
while wall[mget((v.x+3+v.big-v.r)//8,(v.y+4+v.big-v.r)//8)]==true 
and wall[mget((v.x+3+v.big-v.r)//8,(v.y+4+v.big+v.r)//8)]==true do
v.x=v.x+1
end
while wall[mget((v.x+3+v.r+v.big)//8,(v.y+4+v.big-v.r)//8)]==true 
and wall[mget((v.x+3+v.r+v.big)//8,(v.y+4+v.big+v.r)//8)]==true do
v.x=v.x-1
end
end


if enemi==true then
for i=((p.y+3)//8//16)*16,((p.y+3)//8//16)*16+16 do
for j=((p.x+3)//8//16)*16,((p.x+3)//8//16)*16+16 do
rmpf[i][j]=-1
end
end

local coad={}
local direc={
[1]={x=0,y=-1},
[2]={x=1,y=-1},
[3]={x=1,y=0},
[4]={x=1,y=1},
[5]={x=0,y=1},
[6]={x=-1,y=1},
[7]={x=-1,y=0},
[8]={x=-1,y=-1},
}
px=(p.x+3)//8
py=(p.y+4)//8
rmpf[py][px]=0
for i=1,8 do
if wall[mget(px+direc[i].x,py+direc[i].y)]==false then
rmpf[py+direc[i].y][px+direc[i].x]=1
table.insert(coad,{x=px+direc[i].x,y=py+direc[i].y})
end
end


while #coad>0 do
for i=1,8 do
if wall[mget(coad[1].x+direc[i].x,coad[1].y+direc[i].y)]==false and
 (rmpf[coad[1].y+direc[i].y][coad[1].x+direc[i].x]>rmpf[coad[1].y][coad[1].x]+1 or rmpf[coad[1].y+direc[i].y][coad[1].x+direc[i].x]==-1) then
rmpf[coad[1].y+direc[i].y][coad[1].x+direc[i].x]=rmpf[coad[1].y][coad[1].x]+1
table.insert(coad,{x=coad[1].x+direc[i].x,y=coad[1].y+direc[i].y})
end
end
table.remove(coad,1)
end
end
--pix((p.x-50)//8//5*1+xt,(p.y-28)//8//5*1+yt,6)
rmd[p.y//8//16+1][p.x//8//16+1]=1


if (rmt[p.y//8//16+1][p.x//8//16+1]==2 or rmt[p.y//8//16+1][p.x//8//16+1]==3)  and 
p.x>(p.x//8//16)*16*8+8 and p.x<(p.x//8//16)*16*8+14*8 and
p.y>(p.y//8//16)*16*8+8 and p.y<(p.y//8//16)*16*8+14*8 then

for i=0,9*16 do
for j=0,16*16 do
rmpf[i][j]=-1
end
end

local coad={}
local direc={
[1]={x=0,y=-1},
[2]={x=1,y=-1},
[3]={x=1,y=0},
[4]={x=1,y=1},
[5]={x=0,y=1},
[6]={x=-1,y=1},
[7]={x=-1,y=0},
[8]={x=-1,y=-1},
}
px=(p.x+3)//8
py=(p.y+4)//8
rmpf[py][px]=0
for i=1,8 do
if wall[mget(px+direc[i].x,py+direc[i].y)]==false then
rmpf[py+direc[i].y][px+direc[i].x]=1
table.insert(coad,{x=px+direc[i].x,y=py+direc[i].y})
end
end


while #coad>0 do
for i=1,8 do
if wall[mget(coad[1].x+direc[i].x,coad[1].y+direc[i].y)]==false and
 (rmpf[coad[1].y+direc[i].y][coad[1].x+direc[i].x]>rmpf[coad[1].y][coad[1].x]+1 or rmpf[coad[1].y+direc[i].y][coad[1].x+direc[i].x]==-1) then
rmpf[coad[1].y+direc[i].y][coad[1].x+direc[i].x]=rmpf[coad[1].y][coad[1].x]+1
table.insert(coad,{x=coad[1].x+direc[i].x,y=coad[1].y+direc[i].y})
end
end
table.remove(coad,1)
end


if rmt[p.y//8//16+1][p.x//8//16+1]==2 then
chesto=true
else
chesto=false
end
sfx(0,0,30,0)
quake=quake+10
if rm[p.y//8//16+1-1][p.x//8//16+1]==1 then
for i=6,9 do
mset((p.x//8//16)*16+i,(p.y//8//16)*16,17)
end
end
if rm[p.y//8//16+1+1][p.x//8//16+1]==1 then
for i=6,9 do
mset((p.x//8//16)*16+i,(p.y//8//16)*16+15,17)
end
end
if rm[p.y//8//16+1][p.x//8//16+1-1]==1 then
for i=6,9 do
mset((p.x//8//16)*16,(p.y//8//16)*16+i,16)
end
end
if rm[p.y//8//16+1][p.x//8//16+1+1]==1 then
for i=6,9 do
mset((p.x//8//16)*16+15,(p.y//8//16)*16+i,16)
end
end
if rmt[p.y//8//16+1][p.x//8//16+1]==2 then
rmt[p.y//8//16+1][p.x//8//16+1]=1
else
rmt[p.y//8//16+1][p.x//8//16+1]=4
end
spawni=p.y//8//16+1
spawnj=p.x//8//16+1
spawnk=1
if (lv-1)%5~=0 then
if lv%5~=0 then
tsp1=math.random(lv-1,lv)
else
tsp1=lv
end
else
tsp1=lv
end
tsp=math.random(1,#normsp[tsp1])
rand=math.random(1,4)
if lv%5==0 then
rand=1
end
if extrasp[lv]~=nil and rand==1 then
tsp2=lv
create_spawn((spawnj-1)*16,(spawni-1)*16,extrasp[tsp2].type,
extrasp[tsp2].timer,extrasp[tsp2].amount)
spawnk=spawnk+1
end
create_spawn((spawnj-1)*16,(spawni-1)*16,normsp[tsp1][tsp].type,
normsp[tsp1][tsp].timer,normsp[tsp1][tsp].amount)
end


end

function printset(s,x,y,c,i,j)
if selected.y==j then
s="< "..s.." >"
end
local w=print(s,0,-10,0,false,i)
print(s,(240-w)//2,y,c or 15,false,i)
end

function printc(s,x,y,c,i,j)
if menu[j]==true then
s="< "..s.." >"
end
local w=print(s,0,-10,0,false,i)
print(s,(240-w)//2,y,c or 15,false,i)
end


function collide(x,y,r,bt)


--mapx=rooms[room.t][room.i][room.j]%9*30-30
--mapy=rooms[room.t][room.i][room.j]//9*17
mapx=0
mapy=0

if bt==0 and (wall[mget((x-r)//8+mapx,(y-r-1)//8+mapy)]==true
or wall[mget((x+r)//8+mapx,(y-r-1)//8+mapy)]==true) then
return true
elseif bt==1 and (wall[mget((x-r)//8+mapx,(y+r+1)//8+mapy)]==true
or wall[mget((x+r)//8+mapx,(y+r+1)//8+mapy)]==true) then
return true
elseif bt==2 and (wall[mget((x-r-1)//8+mapx,(y+r)//8+mapy)]==true
or wall[mget((x-r-1)//8+mapx,(y-r)//8+mapy)]==true) then
return true
elseif bt==3 and (wall[mget((x+r+1)//8+mapx,(y+r)//8+mapy)]==true
or wall[mget((x+r+1)//8+mapx,(y-r)//8+mapy)]==true) then
return true
elseif bt==nil and (wall[mget((x+r)//8+mapx,(y+r)//8+mapy)]==true
or wall[mget((x+r)//8+mapx,(y-r)//8+mapy)]==true) then
return true
end

return false

end

function sword(cx,cy,cd,cc,cdeg,cid,cid2,showe,sdmg)

if weapons[equip].throw and bt4==2 then
bt4=0
equip=0
create_javelin(p.x,p.y,deg)
end

if weapons[equip].flail then
mx=(cx+3+((cd*4+8)/3+3)*math.cos(math.rad(cdeg))+0.5)
my=(cy+4+((cd*4+8)/3+3)*math.sin(math.rad(cdeg))+0.5)
else
mx=(cx+3+(cd*4+3+8)*math.cos(math.rad(cdeg))+0.5)
my=(cy+4+(cd*4+3+8)*math.sin(math.rad(cdeg))+0.5)
end
i=mx
j=my
if weapons[equip].flail then
d=(cd*4+8)/3+3
if math.sqrt((mx-mx2)*(mx-mx2)+(my-my2)*(my-my2))>d then
if mx<mx2 then
r=-1
else
r=1
end

if mx2-mx~=0 then
m=(my2-my)/(mx2-mx)
dp=1
mx2=mx2+r*dp*(1/math.sqrt(1+m*m))
my2=my2+r*dp*m*(1/math.sqrt(1+m*m))
else
if my<my2 then
r=-1
else
r=1
end
dp=1
mx2=mx2
my2=my2+r*dp

end
end

if math.sqrt((mx2-mx3)*(mx2-mx3)+(my2-my3)*(my2-my3))>d then
if mx2<mx3 then
r=-1
else
r=1
end

if mx3-mx2~=0 then
m=(my3-my2)/(mx3-mx2)
dp=1
mx3=mx3+r*dp*(1/math.sqrt(1+m*m))
my3=my3+r*dp*m*(1/math.sqrt(1+m*m))
else
if my2<my3 then
r=-1
else
r=1
end
dp=1
mx3=mx3
my3=my3+r*dp

end
end
else
d=cd*4+3+8
end

cox=0
coy=0
if weapons[equip].chakram==true then
cox=(cx+i)/2
coy=(cy+j)/2
end

for k,v in pairs(misc) do
if v.id==19 then
if (math.abs((i-cx)*(v.y+3)+(cy-j)*(v.x+3)+(cx-i)*cy+cx*(j-cy))/math.sqrt((i-cx)*(i-cx)+(cy-j)*(cy-j))<=3+(weapons[equip].sp*0.2+0.2)+1 
and (v.x-cx)*(v.x-cx)+(v.y-cy)*(v.y-cy)<=(d+3)*(d+3) and
(v.x-i)*(v.x-i)+(v.y-j)*(v.y-j)<=d*d and weapons[equip].chakram==nil and weapons[equip].flail==nil) 
or (weapons[equip].chakram==true and (math.sqrt((cox-v.x-3)*(cox-v.x-3)+(coy-v.y-4)*(coy-v.y-4))>=(cd*4+4+3) and math.sqrt((cox-v.x-3)*(cox-v.x-3)+(coy-v.y-4)*(coy-v.y-4))<=(cd*4+4+3+2))or
(math.sqrt((cox-v.x-3)*(cox-v.x-3)+(coy-v.y-4)*(coy-v.y-4))>=math.abs(cd*4+4-3) and math.sqrt((cox-v.x-3)*(cox-v.x-3)+(coy-v.y-4)*(coy-v.y-4))<=math.abs(cd*4+4-5)))
or (weapons[equip].flail==true and ((math.abs((mx2-i)*(v.y+3)+(j-my2)*(v.x+3)+(i-mx2)*j+i*(my2-j))/math.sqrt((mx2-i)*(mx2-i)+(j-my2)*(j-my2))<=3+(weapons[equip].sp*0.2+0.2)+1 
and (v.x-i)*(v.x-i)+(v.y-j)*(v.y-j)<=(d+3)*(d+3) and
(v.x-mx2)*(v.x-mx2)+(v.y-my2)*(v.y-my2)<=d*d) or (math.abs((i-cx)*(v.y+3)+(cy-j)*(v.x+3)+(cx-i)*cy+cx*(j-cy))/math.sqrt((i-cx)*(i-cx)+(cy-j)*(cy-j))<=3+(weapons[equip].sp*0.2+0.2)+1 
and (v.x-cx)*(v.x-cx)+(v.y-cy)*(v.y-cy)<=(d+3)*(d+3) and
(v.x-i)*(v.x-i)+(v.y-j)*(v.y-j)<=d*d) or math.abs((mx3-mx2)*(v.y+3)+(my2-my3)*(v.x+3)+(mx2-mx3)*my2+mx2*(my3-my2))/math.sqrt((mx3-mx2)*(mx3-mx2)+(my2-my3)*(my2-my3))<=3+(weapons[equip].sp*0.2+0.2)+1 
and (v.x-mx2)*(v.x-mx2)+(v.y-my2)*(v.y-my2)<=(d+3)*(d+3) and
(v.x-mx3)*(v.x-mx3)+(v.y-my3)*(v.y-my3)<=d*d ) or (math.sqrt((mx3-v.x-3)*(mx3-v.x-3)+(my3-v.y-4)*(my3-v.y-4))<=4+3)) then
v.id=20
rand=math.random(1,4)
if rand==1 then
rar=0
rand=math.random(0,100)
if rand==0 then
rar=4
elseif rand<=epicch then
rar=3
elseif rand<=rarech+epicch then
rar=2
else
rar=1
end
create_item(wrarities[rar][math.random(1,#wrarities[rar])],v.x+3,v.y+4,0)
else
rand=math.random(1,3)
for i=1,rand do
create_gold(v.x+3,v.y+4)
end
rand=math.random(0,2)
for i=1,rand do
create_heart(v.x+3,v.y+4)
end
end
end
end
if v.id==21 or v.id==22 then
if (v.x-p.x)*(v.x-p.x)+(v.y-p.y)*(v.y-p.y)<=(3+2)*(3+2)
and v.y>=v.ey then
p.gold=p.gold+1
misc[k]=nil
sfx(4,93,10,2)
end
end
if v.id==23 then
if (v.x-p.x)*(v.x-p.x)+(v.y-p.y)*(v.y-p.y)<=(3+2)*(3+2)
and v.y>=v.ey and p.hp<5 then
p.hp=p.hp+1
misc[k]=nil
sfx(5,93,10,2)
end
end
end

for k,v in pairs(enemies) do

if v.cursed==2 and cid2==0 then
add_curse(v.x-3+v.r+v.big,v.y-4+v.r+v.big,k+1)
end

if (math.abs((i-cx)*(v.y+v.big+4)+(cy-j)*(v.x+v.big+3)+(cx-i)*cy+cx*(j-cy))/math.sqrt((i-cx)*(i-cx)+(cy-j)*(cy-j))<=v.r+(weapons[equip].sp*0.3+0.3)+1 
and (v.x+v.big-cx)*(v.x+v.big-cx)+(v.y+v.big-cy)*(v.y+v.big-cy)<=(d+3)*(d+3) and
(v.x-i+v.big)*(v.x-i+v.big)+(v.y+v.big-j)*(v.y+v.big-j)<=d*d and weapons[equip].chakram==nil and weapons[equip].flail==nil) 
or (weapons[equip].chakram==true and (math.sqrt((cox-v.x-3)*(cox-v.x-3)+(coy-v.y-4)*(coy-v.y-4))>=(cd*4+4+v.r+(weapons[equip].sp*0.3+0.3)) and math.sqrt((cox-v.x-3)*(cox-v.x-3)+(coy-v.y-4)*(coy-v.y-4))<=(cd*4+4+v.r+(weapons[equip].sp*0.3+0.3)+2))or
(math.sqrt((cox-v.x-3)*(cox-v.x-3)+(coy-v.y-4)*(coy-v.y-4))>=math.abs(cd*4+4-(v.r+(weapons[equip].sp*0.3+0.3))) and math.sqrt((cox-v.x-3)*(cox-v.x-3)+(coy-v.y-4)*(coy-v.y-4))<=math.abs(cd*4+4-(v.r+(weapons[equip].sp*0.3+0.3)+2))))
or (weapons[equip].flail==true and ((math.abs((mx2-i)*(v.y+3)+(j-my2)*(v.x+3)+(i-mx2)*j+i*(my2-j))/math.sqrt((mx2-i)*(mx2-i)+(j-my2)*(j-my2))<=3+(weapons[equip].sp*0.2+0.2)+1 
and (v.x-i)*(v.x-i)+(v.y-j)*(v.y-j)<=(d+3)*(d+3) and
(v.x-mx2)*(v.x-mx2)+(v.y-my2)*(v.y-my2)<=d*d) or (math.abs((i-cx)*(v.y+3)+(cy-j)*(v.x+3)+(cx-i)*cy+cx*(j-cy))/math.sqrt((i-cx)*(i-cx)+(cy-j)*(cy-j))<=3+(weapons[equip].sp*0.2+0.2)+1 
and (v.x-cx)*(v.x-cx)+(v.y-cy)*(v.y-cy)<=(d+3)*(d+3) and
(v.x-i)*(v.x-i)+(v.y-j)*(v.y-j)<=d*d) or (math.abs((mx3-mx2)*(v.y+3)+(my2-my3)*(v.x+3)+(mx2-mx3)*my2+mx2*(my3-my2))/math.sqrt((mx3-mx2)*(mx3-mx2)+(my2-my3)*(my2-my3))<=3+(weapons[equip].sp*0.2+0.2)+1 
and (v.x-mx2)*(v.x-mx2)+(v.y-my2)*(v.y-my2)<=(d+3)*(d+3) and
(v.x-mx3)*(v.x-mx3)+(v.y-my3)*(v.y-my3)<=d*d)or(math.sqrt((mx3-v.x-3)*(mx3-v.x-3)+(my3-v.y-4)*(my3-v.y-4))<=4+v.r) )) then
if v.im==false and ((v.cursed==2 and cid-1~=k) or v.cursed==0) then 
if sdmg==nil then
v.hp=v.hp-weapons[equip].dmg
else
v.hp=v.hp-sdmg
end
v.im=true
touchid=cid
if weapons[equip].critical then
crit=weapons[equip].critical
else
crit=0
end
rand=math.random(1,100)
if rand<=crit+p.critical then
v.hp=v.hp-weapons[equip].dmg
quake=quake+6
end

if cid2==0 and v.cursed==0 and weapons[equip].curse then
v.cursed=2
end

if weapons[equip].poison then
v.poison=v.poison+30*weapons[equip].poison
end

if weapons[equip].thrust and 
(v.x+v.big-i)*(v.x+v.big-i)+(v.y+v.big-j)*(v.y+v.big-j)<=(d)*(d)/4 then
v.hp=v.hp-weapons[equip].thrust
end


if weapons[equip].frost==true and v.frozen==0 and v.id~=197 then
chance=math.random(1,5)
if chance==1 then
v.frozen=120
end
end

local d=p.knockback*6
if weapons[equip].maul==true then
d=d+6
end

if d>0 then
if cx-v.x~=0 then
m=-(cy-v.y)/(cx-v.x)
if v.x<cx then
v.x=v.x-d*(1/math.sqrt(1+m*m))
else
v.x=v.x+d*(1/math.sqrt(1+m*m))
end
if v.y<cy then
v.y=v.y-d*math.abs(m)*(1/math.sqrt(1+m*m))
else
v.y=v.y+d*math.abs(m)*(1/math.sqrt(1+m*m))
end
else
v.x=v.x
if v.y<cy then
v.y=v.y-d
else
v.y=v.y+d
end
end

end
if weapons[equip].electro==true then
tar=math.random(0,2)
v.hp=v.hp-1
boltt=10
boltx=v.x+1+v.r+v.big
bolty=v.y+4+v.big
create_bolt(boltx,bolty,boltx,bolty)
while tar>0 do
mini=3+(8+4*2)*2
minik=-1
for k2,v2 in pairs(enemies) do
if math.sqrt((v.x-v2.x-v2.big)*(v.x-v2.x-v2.big)+(v.y-v2.big-v2.y)*(v.y-v2.big-v2.y))<mini and v2.im==false then
mini=math.sqrt((v.x-v2.x-v2.big)*(v.x-v2.x-v2.big)+(v.y-v2.y-v2.big)*(v.y-v2.y-v2.big))
minik=k2
end
end
if minik~=-1 then
enemies[minik].hp=enemies[minik].hp-1
enemies[minik].im=true
create_bolt(boltx,bolty,enemies[minik].x+1+enemies[minik].r,enemies[minik].y+4)
boltx=enemies[minik].x+enemies[minik].r+1+enemies[minik].big
bolty=enemies[minik].y+4+enemies[minik].big
end
tar=tar-1
end
for i2,v2 in pairs(enemies) do
if i2~=k then
v2.im=false
end
end
end
end
elseif cid==touchid then
v.im=false
end

if (v.x+v.big-p.x)*(v.x+v.big-p.x)+(v.y+v.big-p.y)*(v.y+v.big-p.y)<=(3+v.r)*(3+v.r) and p.im==0 then
p.hp=p.hp-1
p.im=30
end


if v.hp<=0 then
sfx(2,math.random(0,11),6,0)
if v.id==65 or v.id==86 or v.id==102 or v.id==241 then
for i2=1,7 do
create_particle(v.x+v.r,v.y+4,6)
end
quake=quake+9
end
if v.id==193 then
for i2=1,10 do
create_particle(v.x+v.r,v.y+4,6)
end
quake=quake+9
end

if v.id==118 then
for i2=1,10 do
create_particle(v.x+v.r,v.y+4,2)
end
quake=quake+9
end
if v.id==229 then
for i2=1,30 do
create_particle(v.x+v.r+4,v.y+4+v.big,2)
end
quake=quake+40
for io,vo in pairs(spawns) do
spawns[io]=nil
end
spawnk=0
end
if v.id==197 then
for i2=1,30 do
rand=math.random(1,2)
if rand==1 then
create_particle(v.x+v.r+4,v.y+4+v.big,6)
else
create_particle(v.x+v.r+4,v.y+4+v.big,14)
end
end
for io,vo in pairs(spawns) do
spawns[io]=nil
end
spawnk=0
quake=quake+40
end
if v.id==209 then
for i2=1,7 do
create_particle(v.x+v.r,v.y+4,12)
end
quake=quake+9
end
if v.id==113 then
for i2=1,7 do
create_particle(v.x+v.r,v.y+4,12)
end
quake=quake+9
end
if v.id==129 then
for i2=1,10 do
create_particle(v.x+v.r,v.y+4,1)
end
quake=quake+9
end
if v.id==97 then
for i2=1,3 do
create_particle(v.x+v.r,v.y+4,13)
end
quake=quake+9
end
if v.id==225 then
for i2=1,3 do
create_particle(v.x+v.r,v.y+4,15)
end
quake=quake+3
end
if v.id==81 then
for i2=1,10 do
create_particle(v.x+v.r,v.y+4,11)
end
quake=quake+9
end
if v.id==177 then
create_bomber(v.x,v.y)
end
enemies[k]=nil
if weapons[equip].blood then
chance=math.random(7,100)
if chance<=7 and p.hp<p.mhp then
p.hp=p.hp+1
end
end
if weapons[equip].goldrin then
chance=math.random(1,100)
if chance<=13 then
create_gold(v.x+v.r,v.y+4)
end
end
end

end
--circb(p.x+3-cam.x,p.y+4-cam.y,weapons[equip].d*4+3+8,1)


if weapons[equip].thrust then
line(cx+3-cam.x,cy+4-cam.y,(i+cx+3)/2-cam.x,(j+cy+4)/2-cam.y,weapons[equip].c)
line((cx+3+i)/2-cam.x,(cy+4+j)/2-cam.y,i-cam.x,j-cam.y,6)
elseif weapons[equip].chakram then
circb((cx+3+mx)/2-cam.x,(cy+4+my)/2-cam.y,weapons[equip].d*4+4,15)
--line(cx+3-cam.x,cy+4-cam.y,mx-cam.x,my-cam.y,cc)
elseif weapons[equip].flail then
line(cx+3-cam.x,cy+4-cam.y,mx-cam.x,my-cam.y,cc)
line(mx-cam.x,my-cam.y,mx2-cam.x,my2-cam.y,cc)
line(mx2-cam.x,my2-cam.y,mx3-cam.x,my3-cam.y,cc)
circ(mx3-cam.x,my3-cam.y,3,cc)
elseif equip~=0 or showe then
line(cx+3-cam.x,cy+4-cam.y,mx-cam.x,my-cam.y,cc)
end

if cid2==0 and weapons[equip].dual then
sword(p.x,p.y,2,15,deg-180,2,1)
end
if cid2==0 and weapons[equip].scythe then
sword(mx-3,my-4,2,1,deg-110,2,1)
end
if cid2==0 and weapons[equip].shield then
iopa=mx
jopa=my
sword(iopa-3,jopa-4,-1,15,deg-90,2,1)
sword(iopa-3,jopa-4,-1,15,deg+90,3,1)
end
if cid2==0 and weapons[equip].curse then
for ios,vos in pairs(curses) do
circ(vos.x+3-cam.x,vos.y+4-cam.y,1,12)
sword(vos.x,vos.y,3,12,deg,vos.id,1)
curses[ios]=nil
end
end

--circb(p.x+3,p.y+3,p.d,15
end

function drawmenu()
cls(0)
printc("SWORDLINE",11.75*8,2*8,7,2,0)
printc("Start",15*8,5*8,15,1,1)
if t%60<=30 then
printc("Controls",15*8,7*8,6,1,2)
else
printc("!Controls!",15*8,7*8,6,1,2)
end
printc("Credits",15*8,9*8,15,1,3)
printc("Exit",15*8,11*8,15,1,4)
end

function drawgame2()

end

function drawgame()
cls(0)
map(0,0,240,136,-cam.x,-cam.y)
for i,v in pairs(particles) do
pix(v.x-cam.x,v.y-cam.y,v.c)
if v.y<v.ey then
v.x=v.x+v.vx
v.y=v.y+v.vy
if v.up then
else
v.vy=v.vy+0.1
end
else
particles[i]=nil
end
if v.t<=0 then
particles[i]=nil
else
v.t=v.t-1
end
end

for i,v in pairs(misc) do


if v.id==110 then
if v.activated==true then
spr(v.id,v.x-cam.x,v.y-cam.y,0,1,0,0,2,2)
if (v.x-p.x)*(v.x-p.x)+(v.y-p.y)*(v.y-p.y)<=(3+7)*(3+7) then

end
else
spr(v.id+32,v.x-cam.x,v.y-cam.y,0,1,0,0,2,2)
end
end


if v.id==46 then
if v.activated==true then
spr(v.id,v.x-cam.x,v.y-cam.y,0,1,0,0,2,2)
if t%10==0 then
for i=1,3 do
create_particle(v.x+8,v.y+8,12,true,30)
end
end
if (v.x-p.x)*(v.x-p.x)+(v.y-p.y)*(v.y-p.y)<=(3+7)*(3+7) then

end
else
spr(v.id+32,v.x-cam.x,v.y-cam.y,0,1,0,0,2,2)
if choose_t>0 then
choose_t=choose_t-1
if choose_t==39 then
for i=1,20 do
create_particle(v.x+8,v.y+8,12)
end
quake=quake+30
end
end
end
end

if v.id>=25 and v.id<=31 then
spr(v.id,v.x-cam.x,v.y-cam.y,0)
if v.cd<=0 then
v.t=v.t+1
else
v.cd=v.cd-1
end
if v.t%5==0 then
v.id=v.id+1
end
if v.id>31 then
v.id=25
v.cd=60
v.t=1
end
end

if v.area then
circb(v.x-cam.x,v.y-cam.y,3,12)
circb(v.x-cam.x,v.y-cam.y,15,12)
v.t=v.t+1
if v.t%45==0 then
create_explosion2(v.x,v.y)
sfx(3,93,10,2)
for i=1,15 do
create_particle(v.x,v.y,12,true)
end
misc[i]=nil
end
end

if v.id==21 or v.id==22 then
spr(v.id+t%(20-1)//(10),v.x-cam.x,v.y-cam.y,0)
if v.y<v.ey then
if wall[mget((v.x+(v.vx*6))//8,(v.y+3)//8)]==false then
v.x=v.x+v.vx
end
--if wall[mget((v.x+3)//8,(v.y+3+v.vy)//8)]==false then
v.y=v.y+v.vy
--end
v.vy=v.vy+0.1
end
v.t=v.t-1
if v.t<=0 then
misc[i]=nil
end
end

if v.id==23 then
spr(v.id,v.x-cam.x,v.y-cam.y,0)
if v.y<v.ey then
if wall[mget((v.x+(v.vx*6))//8,(v.y+3)//8)]==false then
v.x=v.x+v.vx
end
v.y=v.y+v.vy
v.vy=v.vy+0.1
end
v.t=v.t-1
if v.t<=0 then
misc[i]=nil
end
end

if v.id==24 then
spr(v.id,v.x-cam.x,v.y-cam.y,0)
end

if v.id==181 then
spr(v.id,v.x-cam.x,v.y-cam.y,0)
v.t=v.t-1
if v.t<=0 then
create_explosion(v.x+2,v.y+5)
sfx(7,math.random(13,23),20,2)
quake=quake+30
for ki=1,40 do
rand=math.random(1,2)
if rand==1 then
create_particle(v.x+2,v.y+5,6)
else
create_particle(v.x+2,v.y+5,14)
end
end
misc[i]=nil
end
end
if v.id>=40 and v.id<=45 then
spr(v.id,v.x-v.r-cam.x,v.y+1-cam.y,0)
v.t=v.t+1
if v.t%10==0 then
v.id=v.id+1
end
if v.id==46 then
misc[i]=nil
end
end




if v.id==19 or v.id==20 then
spr(v.id,v.x-cam.x,v.y-cam.y,0)
if v.id==20 then
v.t=v.t-1
if v.t<=0 then
misc[i]=nil
end
end
end
end
--map((rooms[room.t][room.i][room.j]%9*30-30),rooms[room.t][room.i][room.j]//9*17,30,17,0,0,-1,1)
for i,v in pairs(items) do
spr(weapons[v.code].id,v.x-cam.x,v.y-cam.y,0)
if v.cost~=0 then
v.vy=0
v.vx=0
v.ey=0
end
if v.y<v.ey or v.vy<0 then
if wall[mget((v.x+(v.vx*10))//8,(v.y+3)//8)]==false then
v.x=v.x+v.vx
end
v.y=v.y+v.vy
v.vy=v.vy+0.1
end
end
for i,v in pairs(enemies) do
if v.frozen==0 then

if v.cdbeam then
if v.cdbeam>0 then
v.cdbeam=v.cdbeam-1
else
v.cdbeam=math.random(300,400)
create_beam(v.x,v.y)
end
end

if v.cdar then
if v.cdar>0 then
v.cdar=v.cdar-1
else
v.cdar=math.random(200,300)
create_area(p.x+3,p.y+4)
end
end

if v.cdmball then
if v.cdmball>0 then
v.cdmball=v.cdmball-1
else
v.cdmball=math.random(200,300)
create_balldirection(v.x+4,v.y+4,v.x+4,v.y+4-10)
create_balldirection(v.x+4,v.y+4,v.x+4+10,v.y+4-10)
create_balldirection(v.x+4,v.y+4,v.x+4+10,v.y+4)
create_balldirection(v.x+4,v.y+4,v.x+4+10,v.y+4+10)
create_balldirection(v.x+4,v.y+4,v.x+4,v.y+4+10)
create_balldirection(v.x+4,v.y+4,v.x+4-10,v.y+4+10)
create_balldirection(v.x+4,v.y+4,v.x+4-10,v.y+4)
create_balldirection(v.x+4,v.y+4,v.x+4-10,v.y+4-10)
end
end

if v.cdfball then
if v.cdfball>0 then
v.cdfball=v.cdfball-1
else
v.cdfball=math.random(300,400)
create_fireball(v.x+4,v.y+4)
end
end

if v.cdfl and (v.x-p.x)*(v.x-p.x)+(v.y-p.y)*(v.y-p.y)<=(30+v.big)*(30+v.big) then
if v.id==86 then
v.id=102
end
if v.cdfl>0 then
v.cdfl=v.cdfl-1
else
v.cdfl=3-v.big//4
create_flame(v.x+v.big,v.y+v.big,1+v.big//4)
sfx(6,'C-2',5,0)
end
elseif v.cdfl and (v.x-p.x)*(v.x-p.x)+(v.y-p.y)*(v.y-p.y)>(30+v.big)*(30+v.big) then
if v.id==102 then
v.id=86
end
end

if v.cdsw then
if v.cdsw>0 then
v.cdsw=v.cdsw-1
else

mxb=(v.x+7+(3*4+3+8)*math.cos(math.rad(v.deg))+0.5)
myb=(v.y+8+(3*4+3+8)*math.sin(math.rad(v.deg))+0.5)

ib=mxb
jb=myb
db=3*4+3+8

if math.abs((ib-v.x-4)*(p.y+3)+(v.y+4-jb)*(p.x+3)+(v.x-ib+4)*(v.y+4)+(v.x+4)*(jb-v.y-4))/math.sqrt((ib-v.x-4)*(ib-v.x-4)+(v.y+4-jb)*(v.y+4-jb))<=3+1 
and (p.x-v.x-4)*(p.x-v.x-4)+(p.y-v.y-4)*(p.y-v.y-4)<=(db+3)*(db+3) and
(p.x-ib)*(p.x-ib)+(p.y-jb)*(p.y-jb)<=db*db and p.im==0 then
p.hp=p.hp-1
p.im=30
end

line(v.x+3+4-cam.x,v.y+8-cam.y,mxb-cam.x,myb-cam.y,15)

if v.deg>0 then
v.deg=v.deg-3
if v.deg<=0 then
v.deg=360
v.cdsw=math.random(200,300)
end
end

end
end

if v.cdpr then
if v.cdpr>0 then
v.cdpr=v.cdpr-1
else
v.cdpr=math.random(200,300)
create_magic(v.x,v.y)
end
end

if v.cdsp then
if v.cdsp>0 then
v.cdsp=v.cdsp-1
else
v.cdsp=math.random(200,300)
create_enemy(v.x-10,v.y,7)
create_enemy(v.x+10,v.y,7)
create_enemy(v.x,v.y-10,7)
create_enemy(v.x,v.y+10,7)
end
end
end

if v.big>0 then
if v.frozen==0 then
if v.x+2<p.x then
spr(v.id+t%((2-v.sp)*40-1)//((2-v.sp)*10)*2,v.x-cam.x-(4-v.r),v.y-cam.y,0,1,1,0,2,2)
else
spr(v.id+t%((2-v.sp)*40-1)//((2-v.sp)*10)*2,v.x-cam.x-(4-v.r),v.y-cam.y,0,1,0,0,2,2)
end
else
if v.x+2<p.x then
spr(v.id+2,v.x-cam.x-(4-v.r),v.y-cam.y,0,1,1,0,2,2)
else
spr(v.id+2,v.x-cam.x-(4-v.r),v.y-cam.y,0,1,0,0,2,2)
end
end
else
if v.frozen==0 then
if v.x+2<p.x then
if v.id==118 and (v.x-p.x)*(v.x-p.x)+(v.y-p.y)*(v.y-p.y)<=(30+v.big)*(30+v.big) then
spr(v.id+16+t%((2-v.sp)*40-1)//((2-v.sp)*10),v.x-cam.x-(4-v.r),v.y-cam.y,0,1,0)
else
spr(v.id+t%((2-v.sp)*40-1)//((2-v.sp)*10),v.x-cam.x-(4-v.r),v.y-cam.y,0,1,1)
end
else
if v.id==118 and (v.x-p.x)*(v.x-p.x)+(v.y-p.y)*(v.y-p.y)<=(30+v.big)*(30+v.big) then
spr(v.id+16+t%((2-v.sp)*40-1)//((2-v.sp)*10),v.x-cam.x-(4-v.r),v.y-cam.y,0,1,1)
else
spr(v.id+t%((2-v.sp)*40-1)//((2-v.sp)*10),v.x-cam.x,v.y-cam.y,0,1,0)
end
end
else
if v.x+2<p.x then
spr(v.id+1,v.x-cam.x-(4-v.r),v.y-cam.y,0,1,1)
else
spr(v.id+1,v.x-cam.x-(4-v.r),v.y-cam.y,0,1,0)
end
end
end
if v.frozen>0 then
circ(v.x+1+v.r-cam.x,v.y+4-cam.y,v.r+1+v.big,13)
v.frozen=v.frozen-1
end
if v.poison>0 then
v.poison=v.poison-1
if v.poison%10==0 then
for i=1,2 do
create_particle(v.x+v.r,v.y+4,5)
end
end
if v.poison%30==0 then
for i=1,3 do
create_particle(v.x+v.r,v.y+4,5)
end
quake=quake+3
v.hp=v.hp-1
end
end
end
if idanim~=nil then
spr(idanim//10,xianim-cam.x,yjanim-cam.y,0)
idanim=idanim+1
kanimo=kanimo+1
if kanimo>60 then
idanim=nil
end
end
if p.hp>0 then
sword(p.x,p.y,weapons[equip].d,weapons[equip].c,deg,1,0)
if weapons[equip].orbital then
circ(p.x-10-cam.x+3,p.y-10-cam.y+4,1,9)
circ(p.x+10-cam.x+3,p.y-10-cam.y+4,1,9)
circ(p.x+10-cam.x+3,p.y+10-cam.y+4,1,9)
circ(p.x-10-cam.x+3,p.y+10-cam.y+4,1,9)
sword(p.x-10,p.y-10,weapons[equip].d,9,deg-72,2,0)
sword(p.x+10,p.y-10,weapons[equip].d,9,deg-72*2,3,0)
sword(p.x+10,p.y+10,weapons[equip].d,9,deg-72*3,4,0)
sword(p.x-10,p.y+10,weapons[equip].d,9,deg-72*4,5,0)
end
if weapons[equip].stellar then
circ(p.x-cam.x+3,p.y-10-cam.y+4,1,12)
circ(p.x-cam.x+3,p.y+10-cam.y+4,1,12)
circ(p.x-8.66-cam.x+3,p.y-5-cam.y+4,1,12)
circ(p.x+8.66-cam.x+3,p.y-5-cam.y+4,1,12)
circ(p.x-8.66-cam.x+3,p.y+5-cam.y+4,1,12)
circ(p.x+8.66-cam.x+3,p.y+5-cam.y+4,1,12)
sword(p.x,p.y-10,weapons[equip].d,12,deg-60*0,2,0)
sword(p.x-8.66,p.y-5,weapons[equip].d,12,deg-60*1,3,0)
sword(p.x-8.66,p.y+5,weapons[equip].d,12,deg-60*2,4,0)
sword(p.x,p.y+10,weapons[equip].d,12,deg-60*3,5,0)
sword(p.x+8.66,p.y+5,weapons[equip].d,12,deg-60*4,6,0)
sword(p.x+8.66,p.y-5,weapons[equip].d,12,deg-60*5,7,0)
end
spr(anim,p.x-dir*1-cam.x,p.y-cam.y,0,1,dir)
end
for i,v in pairs(bolts) do

if v.javelin then
sword(v.x,v.y,v.d,15,v.deg,2,0,true,2)
--line(v.x-cam.x,v.y-cam.y,v.i-cam.x,v.j-cam.y,15)
vi=(v.i-v.x)/5
vj=(v.j-v.y)/5
v.x=v.x+vi
v.i=v.i+vi
v.y=v.y+vj
v.j=v.j+vj
local i1,i2,j1,j2
if v.x<v.i then
i1=v.x
i2=v.i
else
i1=v.i
i2=v.x
end
if v.y<v.j then
j1=v.y
j2=v.j
else
j1=v.j
j2=v.y
end

vi=math.abs(vi)
vj=math.abs(vj)

for o=0,5 do
o1=i1+vi*o
o2=j1+vj*o
if mget(o1//8,o2//8)==1 or mget(o1//8,o2//8)==33 or mget(o1//8,o2//8)==16 or mget(o1//8,o2//8)==17 then
create_item(28,o1,o2,0,true,v.pi,v.pj)
table.remove(bolts,i)
break
end
end

end

if v.c==12 then
circ(v.x-cam.x,v.y-cam.y,v.r,12)
if (v.x-p.x)*(v.x-p.x)+(v.y-p.y)*(v.y-p.y)<=(3+v.r)*(3+v.r) and p.im==0 then
p.hp=p.hp-1
p.im=30
end
v.t=v.t-1
if v.t==0 then
bolts[i]=nil
end
end

if v.ball then
circ(v.x+3-cam.x,v.y+4-cam.y,v.r,v.color)
if (v.x-p.x)*(v.x-p.x)+(v.y-p.y)*(v.y-p.y)<=(3+v.r)*(3+v.r)
and p.im==0 then
p.hp=p.hp-1
p.im=30
end
v.t=v.t+1
v.x=v.x+v.xv
v.y=v.y+v.yv
if v.t%3==0 then
rand=math.random(1,2)
if rand==1 then
v.color=14
else
v.color=6
end
for i=1,v.r//2 do
rand=math.random(1,2)
if rand==1 then
create_particle(v.x+3,v.y+4,14)
else
create_particle(v.x+3,v.y+4,6)
end
end
if v.t%300==0 then
bolts[i]=nil
end
end
end

if v.id and v.id>=56 and v.id<=61 then
spr(v.id,v.x-cam.x,v.y-cam.y,0)
if (v.x-p.x)*(v.x-p.x)+(v.y-p.y)*(v.y-p.y)<=(3+2)*(3+2)
and p.im==0 then
p.hp=p.hp-1
p.im=30
end
v.t=v.t+1
v.x=v.x+v.xv
v.y=v.y+v.yv
if v.t%10==0 then
v.id=v.id+1
if v.id>61 then
v.id=56
end
end
if v.t%300==0 or wall[mget((v.x+3)//8,(v.y+4)//8)]==true then
bolts[i]=nil
end
end

if v.flame then
circ(v.x+3-cam.x,v.y+4-cam.y,v.r,v.color)
if (v.x-p.x)*(v.x-p.x)+(v.y-p.y)*(v.y-p.y)<=(3+v.r)*(3+v.r)
and p.im==0 then
p.hp=p.hp-1
p.im=30
end
v.t=v.t+1
v.x=v.x+v.xv
v.y=v.y+v.yv
if v.t%10==0 then
v.r=v.r+1
end
if v.t%50==0 or collide(v.x+3,v.y+4,v.r-2) then
bolts[i]=nil
end
end

if v.id then
if v.id==241 then
ib=v.xv
jb=v.yv
db=25
if math.abs((ib-v.x-4)*(p.y+3)+(v.y+4-jb)*(p.x+3)+(v.x-ib+4)*(v.y+4)+(v.x+4)*(jb-v.y-4))/math.sqrt((ib-v.x-4)*(ib-v.x-4)+(v.y+4-jb)*(v.y+4-jb))<=3+1 
and (p.x-v.x-4)*(p.x-v.x-4)+(p.y-v.y-4)*(p.y-v.y-4)<=(db+3)*(db+3) and
(p.x-ib)*(p.x-ib)+(p.y-jb)*(p.y-jb)<=db*db and p.im==0 then
p.hp=p.hp-1
p.im=30
end
line(v.x-cam.x,v.y-cam.y,v.xv-cam.x,v.yv-cam.y,v.c0)
v.t=v.t-1
if v.t==5 then
v.c0=6
end
if v.t==0 then
bolts[i]=nil
end
end
end

if (v.c==15 or v.c==13) then
line(v.x-cam.x,v.y-cam.y,v.i-cam.x,v.j-cam.y,v.c)
v.t=v.t-1
if v.t==5 then
v.c=13
end
if v.t==0 then
bolts[i]=nil
end
elseif v.c==14 or v.c==6 then
circ(v.x-cam.x,v.y-cam.y,v.r,v.c)
if (v.x-p.x)*(v.x-p.x)+(v.y-p.y)*(v.y-p.y)<=(3+v.r)*(3+v.r) and p.im==0 then
p.hp=p.hp-1
p.im=30
end
v.t=v.t-1
if v.t==5 then
v.c=6
end
if v.t==0 then
bolts[i]=nil
end
end
end

for i,v in pairs(chats) do
if v.t>=150 then
table.remove(chats,i)
end
end
for i,v in pairs(chats) do
v.t=v.t+1
local w=print(v.s,-10,-10,15,false,1,true)
rect(4,15*8 - #chats*8 + i*8,w+1,7,0)
print(v.s,5,15*8 - #chats*8 + i*8 +1,15,false,1,true)
end

io=1
for i=io,p.hp do
spr(6,25*8-2+i*6,5,0)
end

for i=io,p.mhp do
spr(7,25*8-2+i*6,5,0)
end

spr(8,25*8+6*5-1,5+8,0)
local w=print(p.gold,0,-10,0,false,1,true)
print(p.gold,25*8+6*5-1-w,5+9,15,false,1,true)

if (controls<=2 and key(3) and p.hp>0) or (controls>2 and btn(7) and p.hp>0) then

--xt=30*8-15*3-6

local recty = 0

if equip~=0 then
recty=70-9*2-12

if weapons[equip].t1 then
recty=recty+9
end
if weapons[equip].t2 then
recty=recty+9
end
end

local s="Floor "..lv
local w=print(s,0,-10,0,false,1,true)
rect((240-w)//2-1,4,w+1,7,0)
print(s,(240-w)//2,5,15,false,1,true)

xt=5
yt=recty+8
--rect(xt-2,yt-2,15*3+4,8*3+4,15)
rect(xt-1,yt-1,15*3+2,8*3+2,0)
for i=1,8 do
for j=1,15 do
if rmd[i][j]==1 then
if rm[i][j]==2 then
if rmt[i][j]==1 or rmt[i][j]==2 then
rect(j*3-3+xt,i*3-3+yt,3,3,15)
elseif rmt[i][j]==3 or rmt[i][j]==4 then
rect(j*3-3+xt,i*3-3+yt,3,3,11)
elseif rmt[i][j]==5 then
rect(j*3-3+xt,i*3-3+yt,3,3,14)
end
if rm[i-1][j]==1 or rm[i-1][j]==2 then
pix(j*3-3+1+xt,i*3-3+yt-1,15)
end
if rm[i+1][j]==1 or rm[i+1][j]==2 then
pix(j*3-3+1+xt,i*3-3+2+yt+1,15)
end
if rm[i][j-1]==1 or rm[i][j-1]==2 then
pix(j*3-3+xt-1,i*3-3+1+yt,15)
end
if rm[i][j+1]==1 or rm[i][j+1]==2 then
pix(j*3-3+2+xt+1,i*3-3+1+yt,15)
end
elseif rm[i][j]==1 then
pix(j*3-3+1+xt,i*3-3+1+yt,15)
if rm[i-1][j]==1 or rm[i-1][j]==2 then
pix(j*3-3+1+xt,i*3-3+yt,15)
end
if rm[i+1][j]==1 or rm[i+1][j]==2 then
pix(j*3-3+1+xt,i*3-3+2+yt,15)
end
if rm[i][j-1]==1 or rm[i][j-1]==2 then
pix(j*3-3+xt,i*3-3+1+yt,15)
end
if rm[i][j+1]==1 or rm[i][j+1]==2 then
pix(j*3-3+2+xt,i*3-3+1+yt,15)
end
end
end
end
end
pix((p.x+6)//8//5.3*1+xt,(p.y+8)//8//5.3*1+yt,6)

for i,v in pairs(passives_eq) do
--rect(4+(i-1)*12-1,yt+3+8*3-1,12,12,15)
rect(4+(i-1)*12,yt+3+8*3,10,10,0)
spr(passives[v].id,5+(i-1)*12,yt+4+8*3,0)
end

--rect(3,4,50,recty+2,15)
if equip~=0 then
rect(4,5,48,recty,0)
spr(weapons[equip].id,7,8,0)
if weapons[equip].rarity==1 then
rectb(5,6,12,12,10)
elseif weapons[equip].rarity==2 then
rectb(5,6,12,12,9)
elseif weapons[equip].rarity==3 then
rectb(5,6,12,12,12)
elseif weapons[equip].rarity==4 then
rectb(5,6,12,12,locolor)
elseif weapons[equip].rarity==0 then
rectb(5,6,12,12,15)
end
if weapons[equip].rarity~=0 then
print(weapons[equip].name,5+12+3,9,15,false,1,true)
else
print(weapons[equip].name,5+12+1,9,15,false,1,true)
end
print("Damage:"..weapons[equip].dmg,5,6+12+3,15,false,1,true)
print("Speed:",5,6+12+3+9,15,false,1,true)
for i=1,weapons[equip].sp do
spr(3,5+15+i*5,6+12+2+9,0)
end
i=1
while i<=5 do
spr(4,5+15+i*5,6+12+2+9,0)
i=i+1
end
print("Range:",5,6+12+3+6+3+9,15,false,1,true)
for i=1,weapons[equip].d do
spr(3,5+15+i*5,6+12+2+18,0)
end
i=1
while i<=5 do
spr(4,5+15+i*5,6+12+2+18,0)
i=i+1
end

if weapons[equip].t1 then
print(weapons[equip].t1,5,48,15,false,1,true)
end
if weapons[equip].t2 then
print(weapons[equip].t2,5,57,15,false,1,true)
end
end

end

for i,v in pairs(misc) do

if math.abs(v.x+1-p.x)<8 and math.abs(v.y-p.y)<8 and v.id==24 and p.hp>0 then

local xi=v.x+5-cam.x
local yj=v.y-6-cam.y
local recty=10
rect(4+xi,5+yj,42,recty,0)
if controls<=2 then
spr(5,5+xi,6+yj,0)
else
spr(48,5+xi,6+yj,0)
end
print("-descend",6+xi+8,8+yj,15,false,1,true)

if btnp(4) and p.hp>0 then
bt4=0
next_dungeon()
loadingc=1
end

end
if (v.x+4-p.x)*(v.x+4-p.x)+(v.y+4-p.y)*(v.y+4-p.y)<=(3+8)*(3+8)  and v.id==46 and p.hp>0 and v.activated==true then

local xi=v.x+5-cam.x+5
local yj=v.y-6-cam.y+4
local recty=10
rect(4+xi,5+yj,48,recty,0)
if controls<=2 then
spr(5,5+xi,6+yj,0)
else
spr(48,5+xi,6+yj,0)
end
print("-offer 15",6+xi+8,8+yj,15,false,1,true)
spr(21,6+xi+8+32,6+yj+1,0)

if btnp(4) and p.gold>=15 and p.hp>0 then
sfx(8,'C-2',20,0)
bt4=0
p.gold=p.gold-15
v.activated=false
choose=true
choose_t=40
selected.x=1
koi=0
while koi<3 do
rand=math.random(1,#passives)
if passives[rand].ch==false and passives[rand].e==false then
passives[rand].ch=true
table.insert(passives_tc,rand)
koi=koi+1
end
end

end
end

if (v.x+4-p.x)*(v.x+4-p.x)+(v.y+4-p.y)*(v.y+4-p.y)<=(3+8)*(3+8)  and v.id==110 and p.hp>0 and v.activated==true then

local xi=v.x+5-cam.x+5
local yj=v.y-6-cam.y+4
local recty=10
rect(4+xi,5+yj,30,recty,0)
if controls<=2 then
spr(5,5+xi,6+yj,0)
else
spr(48,5+xi,6+yj,0)
end
print("-pull",6+xi+8,8+yj,15,false,1,true)

if btnp(4) and p.worthy==true and p.hp>0 then
bt4=0
sfx(8,'C-2',20,0)
v.activated=false
create_item(26,v.x+7,v.y+11,0)
quake=quake+15
for i=1,15 do
create_particle(v.x+7,v.y+11,13)
end
elseif btnp(4) and p.hp>0 then
bt4=0
create_chat("You are not worthy.")
end
end

end

for i,v in pairs(items) do
if math.abs(v.x+1-p.x)<8 and math.abs(v.y-p.y)<8 and p.hp>0 then

local xi=v.x+5-cam.x
local yj=v.y-4-cam.y
local recty=70-9*2

if weapons[v.code].t1 then
recty=recty+8
end
if weapons[v.code].t2 then
recty=recty+8
end
if p.scrapper==true then
recty=recty+9
end

while yj+recty>16*8+4 do
yj=yj-1
end


rect(4+xi,5+yj,48,recty,0)
spr(weapons[v.code].id,7+xi,8+yj,0)
if weapons[v.code].rarity==1 then
rectb(5+xi,6+yj,12,12,10)
elseif weapons[v.code].rarity==2 then
rectb(5+xi,6+yj,12,12,9)
elseif weapons[v.code].rarity==3 then
rectb(5+xi,6+yj,12,12,12)
elseif weapons[v.code].rarity==4 then
rectb(5+xi,6+yj,12,12,locolor)
elseif weapons[v.code].rarity==0 then
rectb(5+xi,6+yj,12,12,15)
end
if weapons[v.code].rarity~=0 then
print(weapons[v.code].name,20+xi,9+yj,15,false,1,true)
else
print(weapons[v.code].name,20+xi-2,9+yj,15,false,1,true)
end
print("Damage:"..weapons[v.code].dmg,5+xi,21+yj,15,false,1,true)
print("Speed:",5+xi,6+12+3+9+yj,15,false,1,true)
for i=1,weapons[v.code].sp do
spr(3,5+15+i*5+xi,6+12+2+9+yj,0)
end
i=1
while i<=5 do
spr(4,5+15+i*5+xi,6+12+2+9+yj,0)
i=i+1
end
print("Range:",5+xi,6+12+3+6+3+9+yj,15,false,1,true)
for i=1,weapons[v.code].d do
spr(3,5+15+i*5+xi,6+12+2+18+yj,0)
end
i=1
while i<=5 do
spr(4,5+15+i*5+xi,6+12+2+18+yj,0)
i=i+1
end

local j=0

if weapons[v.code].t1 then
print(weapons[v.code].t1,5+xi,48+yj+j*8,15,false,1,true)
j=j+1
end
if weapons[v.code].t2 then
print(weapons[v.code].t2,5+xi,48+yj+j*8,15,false,1,true)
j=j+1
end
if controls<=2 then
spr(5,5+xi,48+yj+j*8,0)
else
spr(48,5+xi,48+yj+j*8,0)
end
if v.cost==0 then
print("-equip",6+xi+8,49+yj+j*8,15,false,1,true)
else
print("-buy "..v.cost,6+xi+8,49+yj+j*8,15,false,1,true)
local w=print(v.cost,-10,-10,15,false,1,true)
spr(21,6+xi+8+16+w,48+yj+j*8,0)
end
j=j+1
if p.scrapper==true and v.cost==0 then
if controls<=2 then
spr(32,5+xi,48+yj+j*8+2,0)
else
spr(64,5+xi,48+yj+j*8+2,0)
end
print("-scrap 3",6+xi+8,49+yj+j*8+2,15,false,1,true)
spr(21,6+xi+8+24+w,48+yj+j*8+2,0)
end

end
end


end

function cd()
t=t+1
if p.im>0 then
p.im=p.im-1
end
if quake>0 then
quake=quake-1
end

for i,v in pairs(spawns) do
if v.type and p.hp>0 then
if v.amount>0 then
if v.cd<=0 then
if v.type[1]~=9 and v.type[1]~=12 then
xi=math.random(1,14)
yj=math.random(1,14)
while not (rmpf[v.j+yj][v.i+xi]~=-1 and rmpf[v.j+yj][v.i+xi]>=4) do
xi=math.random(1,14)
yj=math.random(1,14)
end
xi=xi*8
yj=yj*8
else
xi=(0.5*13+1)*8
yj=xi
end
if v.type[1]~=9 and v.type[1]~=12 then
create_enemy(v.i*8+xi,v.j*8+yj-1,v.type[math.random(1,#v.type)])
else
create_enemy(v.i*8+xi-8,v.j*8+yj-1-8,v.type[math.random(1,#v.type)])
end
v.amount=v.amount-1
v.cd=math.random(v.timer,v.timer*2)
if v.type[1]==9 then
for i2=1,15 do
create_particle(v.i*8+xi,v.j*8+yj-1,2)
end
quake=quake+15
end
if v.type[1]==12 then
for i2=1,15 do
rand=math.random(1,2)
if rand==1 then
create_particle(v.i*8+xi,v.j*8+yj-1,6)
else
create_particle(v.i*8+xi,v.j*8+yj-1,14)
end
end
quake=quake+15
create_explosion(v.i*8+xi,v.j*8+yj-1)
end
else
v.cd=v.cd-1
if v.type[1]==9 and v.cd==59 then
xianim=v.i*8+(0.5*13+1)*8
yjanim=v.j*8+(0.5*13+1)*8-1
idanim=720
kanimo=0
end
if v.type[1]==12 and v.cd==59 then
xianim=v.i*8+(0.5*13+1)*8
yjanim=v.j*8+(0.5*13+1)*8-1
idanim=90
kanimo=0
end
end
else
spawns[i]=nil
spawnk=spawnk-1
end
end
end

ok=1
for i,v in pairs(enemies) do
if v.id then
ok=0
break
end
end

if spawnk==0 and ok==1 then
if chesto==true then
create_chest((spawnj-1)*16*8+8*8-2,(spawni-1)*16*8+8*8-2)
else
create_stairs((spawnj-1)*16*8+8*8-2,(spawni-1)*16*8+8*8-2)
end
for i=0,15 do
for j=0,15 do
if mget((spawnj-1)*16+i,(spawni-1)*16+j)==17 or 
mget((spawnj-1)*16+i,(spawni-1)*16+j)==16 then
mset((spawnj-1)*16+i,(spawni-1)*16+j,2)
end
end
end
for i=6,9 do
for j=6,9 do
if mget((spawnj-1)*16+i,(spawni-1)*16+j)~=2 then
mset((spawnj-1)*16+i,(spawni-1)*16+j,2)
if mget((spawnj-1)*16+i,(spawni-1)*16+j-1)==33 then
mset((spawnj-1)*16+i,(spawni-1)*16+j-1,1)
end
end
end
end
spawnk=-1
end

end



function animo()
if walk==1 and t%10==0 then
anim=anim+1
if anim==49 or anim==51 or anim==53 then
sfx(1,21,9,1)
end
if anim>53 then
anim=50
end
end

if t%5==0 then
locolor=math.random(1,15)
end

if walk==0 then
anim=49
end
end


function loading()
cls()
print("Descending"..lod,107,130//2,15,false,1,true)
if t%20==0 then
lod=lod.."."
end
end

function drawsettings()
cls(0)
local m=5*8
local n=1*8
if controls==1 then
spr(176,3*8+m,3*8+n)
spr(160,3*8+m,4*8+1+n)
spr(144,2*8-1+m,4*8+1+n)
spr(192,4*8+1+m,4*8+1+n)
print("Move",2*8+1+m,5*8+3+n,15)
spr(80,9*8+m,4*8+1+n)
spr(96,10*8+1+m,4*8+1+n)
print("Rotate",8*8-1+m,5*8+3+n,15)
spr(208,15*8+5+m,4*8+1+n)
print("Menu",14*8+6+m,5*8+3+n,15)
printset("Computer Controls - Right Handed",15*8,10*8,15,1,1)
elseif controls==2 then
spr(128,3*8+m,3*8+n)
spr(112,3*8+m,4*8+1+n)
spr(80,2*8-1+m,4*8+1+n)
spr(96,4*8+1+m,4*8+1+n)
print("Move",2*8+1+m,5*8+3+n,15)
spr(144,9*8+m,4*8+1+n)
spr(160,10*8+1+m,4*8+1+n)
print("Rotate",8*8-1+m,5*8+3+n,15)
spr(208,15*8+5+m,4*8+1+n)
print("Menu",14*8+6+m,5*8+3+n,15)
printset("Computer Controls - Left Handed",15*8,10*8,15,1,1)
elseif controls==3 then
spr(128,3*8+m,3*8+n)
spr(112,3*8+m,4*8+1+n)
spr(80,2*8-1+m,4*8+1+n)
spr(96,4*8+1+m,4*8+1+n)
print("Move",2*8+1+m,5*8+3+n,15)
spr(240,9*8+m,4*8+1+n)
spr(64,10*8+1+m,4*8+1+n)
print("Rotate",8*8-1+m,5*8+3+n,15)
spr(224,15*8+5+m,4*8+1+n)
print("Menu",14*8+6+m,5*8+3+n,15)
printset("Mobile Controls",15*8,10*8,15,1,1)
end
printset("Back",15*8,12*8,15,1,2)
end

function drawchoose()
if btnp(2) then
if selected.x>1 then
selected.x=selected.x-1
end
end
if btnp(3) then
if selected.x<3 then
selected.x=selected.x+1
end
end
rect(12*8-4,5*8,7*8,6*8,0)
for i,v in pairs(passives_tc) do
spr(passives[v].id,12*8-1+(i-1)*21,5*8+3)
if selected.x==i then
rectb(12*8+2+(i-1)*21-1-4,5*8+1,12,12,15)
print(passives[v].t1,12*8-3,6*8+6,15,false,1,true)
print(passives[v].t2,12*8-3,7*8+6,15,false,1,true)
print(passives[v].t3,12*8-3,8*8+6,15,false,1,true)
end
if controls<=2 then
spr(5,12*8+5,9*8+6,0)
else
spr(48,12*8+5,9*8+6,0)
end
print("-confirm",12*8+13+1,9*8+6+1,15,false,1,true)
end

if btnp(4) then
bt4=0
ido=passives[passives_tc[selected.x]].id
passives[passives_tc[selected.x]].e=true
table.insert(passives_eq,passives_tc[selected.x])
if ido==256 then
p.speed=p.speed+0.5
elseif ido==257 then
p.scrapper=true
elseif ido==258 then
p.critical=p.critical+15
elseif ido==259 then
p.knockback=p.knockback+0.5
end
choose=false
for i,v in pairs(passives_tc) do
passives[v].ch=false
passives_tc[i]=nil
end
end
end

init()
function TIC()
cd()
if loadingc==0 then
if camera==0 then
if btnp(0) then
selected.y=selected.y-1
elseif btnp(1) then
selected.y=selected.y+1
elseif btnp(4) then
camera=selected.y
if camera>2 then
camera=0
end
if selected.y==1 then
next_dungeon()
end
selected.y=1
end

if selected.y==0 then
selected.y=4
elseif selected.y==5 then
selected.y=1
end

for i=1,4 do
menu[i]=false
end

menu[selected.y]=true

drawmenu()
elseif camera==1 then
walk=0
if btnp(4) then
bt4=1
end
if quake>40 then
quake=40
end
if p.hp<=0 then
sfx(3,0,25,0)
camera=4
create_item(equip,p.x+3,p.y+4,0)
quake=40
for i,v in pairs(enemies) do
v.frozen=0.5
end
for i=1,16 do
create_particle(p.x+3,p.y+4,7)
end
for i=1,p.gold do
create_gold(p.x+3,p.y+4)
end
p.gold=0
end
cam.x=p.x-120+math.random(-quake//5,quake//5)
cam.y=p.y-68+math.random(-quake//5,quake//5)
if choose==false then
move()
end
animo()
drawgame()
for i=((p.y+3)//8//16)*16,((p.y+3)//8//16)*16+15 do
for j=((p.x+3)//8//16)*16,((p.x+3)//8//16)*16+15 do
--print(rmpf[i][j],j*8-cam.x,i*8-cam.y,15,false,1,true)
end
end
--print(t%60,0,0)
if choose==true and choose_t<=0 then
drawchoose()
end
if bt4==1 then
bt4=2
end
elseif camera==2 then

if btnp(0) then
selected.y=selected.y-1
if selected.y<1 then
selected.y=2
end
elseif btnp(1) then
selected.y=selected.y+1
if selected.y>2 then
selected.y=1
end
elseif btnp(2) then
if selected.y==1 then
controls=controls-1
if controls<1 then
controls=3
end
end
elseif btnp(3) then
if selected.y==1 then
controls=controls+1
if controls>3 then
controls=1
end
end
elseif btnp(4) then
if selected.y==1 then
controls=controls+1
if controls>3 then
controls=1
end
end
if selected.y==2 then
camera=0
end
end

drawsettings()
elseif camera==3 then

drawcredits()
elseif camera==4 then
cam.x=p.x-120+math.random(-quake//5,quake//5)
cam.y=p.y-68+math.random(-quake//5,quake//5)
drawgame()
if controls<3 then
spr(32,25*8-1,16*8,0)
else
spr(64,25*8-1,16*8,0)
end
print("Main Menu",26*8+1,16*8+1,15,false,1,true)
if btnp(5) then
init()
end
end
else
loading()
if lod=="...." then
loadingc=0
lod=""
end
end
end
-- <TILES>
-- 001:8888888888888888333333333888388833333333883888383333333383888388
-- 002:3333333333333333333333333333333333333333333333333333333333333333
-- 003:0000000000000000000ff00000ffff0000ffff00000ff0000000000000000000
-- 004:0000000000000000000ff00000f00f0000f00f00000ff0000000000000000000
-- 005:0bbbbbb0bb5555bbbbbbb5bbbbb55bbbbb5bbbbbbb5555bb5bbbbbb505555550
-- 006:0000000000f0f0000fffff000fffff0000fff000000f00000000000000000000
-- 007:0000000000f0f0000f0f0f000f000f0000f0f000000f00000000000000000000
-- 008:0000000000f000000f0f00000f0f00000f0f000000f000000000000000000000
-- 009:00000000000000000000000000060000006e6000006e6000000e000000000000
-- 010:0000000000000000000000000000000000060000006e6000000e000000000000
-- 011:00000000000000000000000000060000006e6000006e6000000e000000000000
-- 012:000000000000000000000000000000000000000000060000000e000000000000
-- 013:0000000000060000006e600006eee60006eee60000eee000000e000000000000
-- 014:00060000006e600006eee6006eeeee606eeeee6006eee60000eee000000e0000
-- 016:8888888883333338888888888333333888888888833333388888888883333338
-- 017:8888888883838383838383838383838383838383838383838383838388888888
-- 018:14141414141414141414141414141414141414ee141414141414141414141414
-- 019:000000000111111001444410011ee11001444410014444100111111000000000
-- 020:01111110011ee110012222100111111001444410014444100111111000000000
-- 021:00000000000f000000fee00000fee00000fee000000e00000000000000000000
-- 022:0000000000000000000f0000000e0000000e0000000e0000000e000000000000
-- 023:000000000060600006f666000666660000666000000600000000000000000000
-- 024:0000000088888880831111808381118083831180838381808888888000000000
-- 025:00000000000000000000000005050000001b100000bbbe000b444b0000b0b000
-- 026:00000000000000000000000005050000001b1e0000bbbb000b44400000b0b000
-- 027:000000000000000000000e0005050000001b100000bbbb000b44400000b0b000
-- 028:0000000000000e000000000005050000001b100000bbbb000b44400000b0b000
-- 029:000000000000000000000e0005050000001b100000bbbb000b44400000b0b000
-- 030:00000000000000000000000005050000001b1e0000bbbb000b44400000b0b000
-- 031:00000000000000000000000005050000001b100000bbbe000b444b0000b0b000
-- 032:0666666066166166661661666661166666166166661661661666666101111110
-- 033:8888888888888888888888888888888888888888888888888888888888888888
-- 034:3333333333333333333333337777777777777777777777777777777777777777
-- 035:1111111114444441111111111444444114444441144444411444444111111111
-- 036:3111111331444413311111133144441331444413314444133111111333333333
-- 037:3111111331414413311111133144441331444113314444133111111333333333
-- 038:3111111331414413311111133141441331444113311444133111111333333333
-- 039:3111111331414413311111133141441331441113311414133111111333333333
-- 040:0000000000000000000000000000000001111100101010100111110000000000
-- 041:0000000000000000000000000000600006666600606060600666660000000000
-- 042:0000000000000000000006000060600006666600606060600666660000000000
-- 043:0000000000006000060006000060000006666600606060600666660000000000
-- 044:0000600000606000060000000000000006666600606060600666660000000000
-- 045:0006600000600000000000000000000006666600606060600666660000000000
-- 046:000000000000000200000022000000220000022c000002c2000002c2000002c2
-- 047:00000000200000002200000022000000c22000002c2000002c2000002c200000
-- 048:0bbbbbb0bbb55bbbbb5bb5bbbb5bb5bbbb5555bbbb5bb5bb5bbbbbb505555550
-- 049:000000000666000006aaa00000a3300000aaa00000aaa00000aaa00000a0a000
-- 050:06660000066aa00000aa300000aaa00000aaa00000aaa0000a000a0000000000
-- 051:000000000666000006aaa00000a3300000aaa00000aaa00000aaa00000a0a000
-- 052:0666000006aaa00000a3300000aaa00000aaa00000aaa0000a000a0000000000
-- 053:0000000006660000066aa00000aa300000aaa00000aaa00000aaa00000a0a000
-- 056:0000000000000000000f000000ccf0000ccccc0000fcc0000f0c000000000000
-- 057:000000000000000000ff000000ccc0000ccfcc0000fcc000000c000000000000
-- 058:000000000000000000fc000000ccc0000ccffc0000ccc000000c000000000000
-- 059:0000000000000000000c000000ccc0000cccfc0000cccf00000c000000000000
-- 060:0000000000000000000c000000ccc0000ccccc0000cccf00000c000000000000
-- 061:0000000000000000000c000000ccf0000ccccc0000ccc0000f0c000000000000
-- 062:000022c20000222c000022220000222200022222000222220002222200022222
-- 063:2c220000c2220000222200002222000022222000222220002222200022222000
-- 064:0666666066111666661661666611166666166166661116661666666101111110
-- 065:000000000a0000000aa000000666600066166600066660006000060000000000
-- 066:0000000000000000a00a0000aa0a000006666000016160000666600006006000
-- 067:00000000a00a0000aa0a00000666600061616600066660006000060000000000
-- 068:00000000000000000a0000000aa0000006666000061660000666600006006000
-- 070:0000000033333330333333303333333033333330333333303333333033333330
-- 072:0200020000000002000000000000000000000000000000000000000000000000
-- 073:0200020000202200000002000000000000000000000000000000000000000000
-- 074:0200020000202200a0020200002000a000000000000000000000000000000000
-- 075:020002000020020000a20a000002200000002000000000000000000000000000
-- 076:002002000020020000220a0000a2200000020000000200000000000000000000
-- 077:002002000a2222a00022220000a22a0000022000000200000000200000000000
-- 078:0000000000000002000000220000002200000222000002220000022200000222
-- 079:0000000020000000220000002200000022200000222000002220000022200000
-- 080:0777777077773777777337777733377777733777777737773777777303333330
-- 081:00000000a0a00000a0aa0000bbbbbb00bb1bbbb0bbbbbbb055bbbbb000005500
-- 082:00000000a00a0000a00aa000bbbbbb001bb1bbb0bbbbbbb0bbbbbbb005505500
-- 083:00000000a00a0000a00aa000bbbbbb001bb1bbb0bbbbbbb0bbb55bb005500000
-- 084:00000000a0a00000a0aa0000bbbbbb00bb1bbbb0bbbbbbb0bbbbbbb005505500
-- 086:0000000000000000000000000a0aa000a1a11100a1a666006666660000006600
-- 087:0000000000000000000000000aa0aa00a11a1100a11a66001111660006606600
-- 088:0000000000000000000000000aa0aa00a11a1100a11a66001116660006600000
-- 089:0000000000000000000000000a0aa000a1a11100a1a666000166660006606600
-- 094:0000222200002222000022220000222200022222000222220002222200022222
-- 095:2222000022220000222200002222000022222000222220002222200022222000
-- 096:0777777077737777777337777773337777733777777377773777777303333330
-- 097:00000000000000000a0000000a0000000d1d00000ddd0000d000d00000000000
-- 098:0000000000000000000000000a0a00000a0a000001d100000ddd00000d0d0000
-- 099:00000000000000000a0a00000a0a000001d100000ddd0000d000d00000000000
-- 100:0000000000000000000000000a0000000a0000000d1d00000ddd00000d0d0000
-- 102:0000000000000000000000000a0aa00001111100a9a66600a1a6660001006600
-- 103:0000000000000000000000000aa0aa0001111100a99a6600a11a660001116600
-- 104:0000000000000000000000000aa0aa0001111100a99a6600a11a660001110000
-- 105:0000000000000000000000000a0aa00001111100a9a66600a1a6660001606600
-- 110:0000000000000000000000000000000000000000000000000000000000000004
-- 111:0000000000000000000000000000000000000000000000000000000040000000
-- 112:0777777077777777733333377733337777733777777777773777777303333330
-- 113:000000000a00a0000a00a0000cccc00001cc1000cccccc000000000000000000
-- 114:000000000a00a0000a00a0000cccc00001cc1000cccccc000000000000000000
-- 115:00000000000000000a00a0000a00a0000cccc00001cc1000cccccc0000000000
-- 116:00000000000000000a00a0000a00a0000cccc00001cc1000cccccc0000000000
-- 118:00000000aa000000aa2202000222020022222220222202202222002002002000
-- 119:00000000a00a0000a22a02000212020022222c2022220c202222002002020000
-- 120:00000000a00a0000a22a02000212020022222c2022220c202222002020020000
-- 121:00000000aa000000aa2202000222020022222220222202202222002002020000
-- 126:000000e4000000ee0000000f0000077d000077d7000077d70007777700077777
-- 127:4e000000ee000000f00000007d7000007d7700007d77000077d7700077777000
-- 128:0777777077777777777337777733337773333337777777773777777303333330
-- 129:a00a0000a1aa0000016112000111212002111100200011000200001000000000
-- 130:a00a0000a1aa0000016112000111212002111100200011100200000000000000
-- 131:00000000a00a0000a1aa00000161120001112120021111002000110002000010
-- 132:00000000a00a0000a1aa00000161120001112120021111002000110002000100
-- 134:a00a0000a22a022002122cc22222000222222000022220000020200000000000
-- 135:a00a0000a22a0000021222002222cc2022222020022220000020200000000000
-- 136:00000000a00a0000a22a022002122cc222220002222220000222200000202000
-- 137:00000000a00a0000a22a0000021222002222cc20222220200222200000202000
-- 144:0777777077733777773773777737737777333377773773773777777303333330
-- 145:000000000a0a00000aaa00000a1a00000aaaa00000aaa0000000a00000000a00
-- 146:000000000a0a00000aaa00000a1a00000aaaa00000aaa0000000a00000000a00
-- 147:00000000000000000a0a00000aaa00000a1a00000aaaa00000aaa0000000aa00
-- 148:00000000000000000a0a00000aaa00000a1a00000aaaa00000aaa0000000aa00
-- 151:000000000000000000000000000000f000000f00000091f100009fff000090ff
-- 152:0000000000000000000000000f000000f0000000f9900000f0900000f0900000
-- 158:0000000000000000000000000000077700007777000077770007777700077777
-- 159:0000000000000000000000007770000077770000777700007777700077777000
-- 160:0777777077733377773777777773377777777377773337773777777303333330
-- 161:0a000000aa000000aa0000000a00000001110000055500005000500000000000
-- 162:000000000a0a0000a00a0000aa0a00000a0a0000011100000555000005050000
-- 163:0a0a0000a00a0000aa0a00000a0a000001110000055500005000500000000000
-- 164:000000000a000000aa000000aa0000000a000000011100000555000005050000
-- 167:000099fe000090f9000090f9000099f900000000000000000000000000000000
-- 168:9990000000900000009000009990000000000000000000000000000000000000
-- 176:0777777077377377773773777737737777333377773333773777777303333330
-- 177:0000000000000000000000000a00000004540000044400004000400000000000
-- 178:000000000000000000000000000000000a0a0000054500000444000004040000
-- 179:0000000000000000000000000a0a000005450000044400004000400000000000
-- 180:000000000000000000000000000000000a000000045400000444000004040000
-- 181:0000000000000000000000000a00a00005445000444444000444400004004000
-- 192:0777777077333777773773777737737777377377773337773777777303333330
-- 193:0a0a0000a0a0a000656000006666000000666000006660000600060006000060
-- 194:0a0a0000a0a0a000656000006666000000666000006660000060600000600600
-- 195:a00a0000a0a00000565000006666000000666000006660000600060006000060
-- 196:a00a0000a0a00000565000006666000000666000006660000060600000600600
-- 197:00000000000000000000a0000000aa0000000a66000e006e000066660006ee66
-- 198:0000000000000000e00a000000aa0000aaa00000600000006660000066e60000
-- 199:00000000000000000000a0e00000aa0000060a660000006e000066660006ee66
-- 200:0000000060000000000a000000aa0000aaa00000600000006660000066e60000
-- 201:0000000000000060000000000000a0000000aa0000000a66000e006e00006666
-- 202:000000000000000000000000000a000000aa0000aaa00000600e000066600000
-- 203:0000000000000000000000000000a0000000aa0000060a660000006e00006666
-- 204:000000000000000000000000000a000000aa0000aaa600006000000066600000
-- 208:0777777077733377773777777737777777377777777333773777777303333330
-- 209:0000000000000000a20a0000a1aa0000012200000222200002c222000c0c2200
-- 210:0000000000000000a02a0000aa1a0000021220000222220002c2220000cc2200
-- 211:0000000000000000a02a0000aa1a0000021220000222220002c222000c0c2200
-- 212:0000000000000000a20a0000a1aa0000012200000222200002c2220000cc2200
-- 213:0006e0e60000e0ee0000000e0000000000000000000000000000000000000000
-- 214:60ee0000e0e00000e0000000ee0000000e000000000000000000000000000000
-- 215:0006e0e60000e0ee0000000e0000000000000000000000000000000000000000
-- 216:60ee0000e0e00000e0000000ee0000000e000000000000000000000000000000
-- 217:0006ee66000ee0e6000e00ee0000000e00000000000000000000000000000000
-- 218:66e6000060ee0000e00e0000e00e0000ee0000000e0000000000000000000000
-- 219:0006ee66000ee0e6000e00ee0000000e00000000000000000000000000000000
-- 220:66e6000060ee0000e00e0000e00e0000ee0000000e0000000000000000000000
-- 224:0999999099499499994994999994449999999499999449994999999404444440
-- 225:0000000000000000000000000f0000000f3f00000fff0000f000f00000000000
-- 226:000000000000000000000000000000000f0f000003f300000fff00000f0f0000
-- 227:0000000000000000000000000f0f000003f300000fff0000f000f00000000000
-- 228:000000000000000000000000000000000f0000000f3f00000fff00000f0f0000
-- 229:00000000000000000000000000000a0000000aa2000000120000002200000022
-- 230:0000000000000000000000000000000020000f002000ff002a0ff00022ff0000
-- 231:0000000000000000000000000000000000000a0a00000a2a0000001100000a22
-- 232:000000000000000000000000000000000000000020000f002000ff002a0ff000
-- 233:00000000000000000000000000000a0a00000a2a0000001100000a2200000222
-- 234:0000000000000000000000000000000020000f002000ff002a0ff00022ff0000
-- 235:0000000000000000000000000000000000000a0000000aa20000001200000022
-- 236:000000000000000000000000000000000000000020000f002000ff002a0ff000
-- 240:0888888088288288882882888882288888288288882882882888888202222220
-- 241:0016660001f6666009f66f600fafa6600afa6660060606060060606000000000
-- 242:0016660001f6666009f66f600fafa6600afa6660060606060606060000000000
-- 243:0000000000616600061f6660069f66f00fafaf600afaf6600606060600606060
-- 244:0000000000616600061f6660069f66f00fafaf600afaf6600606060606060600
-- 245:0000002200000022000002060000020000000000000000000000000000000000
-- 246:2220000023000000626000000020000000000000000000000000000000000000
-- 247:0000022200000622000006220000002000000020000000000000000000000000
-- 248:22ff000022200000236000002000000020000000000000000000000000000000
-- 249:0000062200000022000002060000020000000000000000000000000000000000
-- 250:2220000023000000626000000020000000000000000000000000000000000000
-- 251:0000002200000022000000220000002000000020000000000000000000000000
-- 252:22ff000022200000236000002000000020000000000000000000000000000000
-- </TILES>

-- <SPRITES>
-- 000:0000d0000d000d0000d0000f000d00ffd0000ff00d07ff000007700000700000
-- 001:0f00000ffee000fffee00ff00e000000000f0000000ff0000077700000070000
-- 002:00000060000006f600006ff60006ff60007ff600007760000700000000000000
-- 003:0000000000044000000411000000114000040440004000000400000000000000
-- 005:0000000000777700077777700667766007777770077007700070070000000000
-- 224:0000000000000f0000000ff000000ff00000ff000006f0000060000000000000
-- 225:0000000000000440000044400001440000011000001000000000000000000000
-- 226:0000000000000770000070700007070000707000007700000700000000000000
-- 227:0001110000111110000001100000100000010000001000000100000010000000
-- 228:00000000000050a0000505a50000aa50000aa000001105000100050000000000
-- 229:000000000f9000f009400f000000f0000009000000900f900000094000000000
-- 230:000000000000000000044000004aa400004aa400000440000000000000000000
-- 231:00000000000000a000000a0000004a000004400000aa00000a00000000000000
-- 232:00000000000000c000000cc00000cc00022cc000002200000202000000000000
-- 233:0000000000000ff00000dff000edfd000eefd000004ee000040e000000000000
-- 234:00000a000000077a0000a770000770a000700000070000000700000000000000
-- 235:00000000000000f00000ff0000007f0000070000007000000700000070000000
-- 236:fc0000fcc20000c200000c000000c0000002000000200000fc0000fcc20000c2
-- 237:000000000000004000000f400000f0a0000f004000f00400044a400000000000
-- 240:00000000000000f000000ff00000ff00007ff000007700000700000000000000
-- 241:000000000000000000000f000007ff000007f000007000000000000000000000
-- 242:00000000000000000000a0000000aa00000aa000004000000000000000000000
-- 243:0000aa00000aaa40000aa4aa00004aaa00040aa0004000000400000040000000
-- 244:00000a000000aaa000000aaa000040a000040000004000000400000040000000
-- 245:0000000000000000000ee00000e00e0000400e000004e0000000000000000000
-- 246:0000000000000aa000000aa00000400000040000004000000000000000000000
-- 247:000000000000005000000a500007aa000007a000007000000000000000000000
-- 248:00000000000000f000000f000000f000000dd00000d000000000000000000000
-- 249:0000006000000660000006600000660000066000001100000100000000000000
-- 250:00000000000000d000000dd00000ddd0000dd00000aa00000a00000000000000
-- 251:0000000a000000aa000006aa0000460000040000004000000400000040000000
-- 252:00000000000000e000000e000007ee000007e000007000000000000000000000
-- 253:0000000f000000f0000006000000400000040000004000000400000040000000
-- 254:00000000000000a000000a000000a000007a0000007700000700000000000000
-- 255:0000000000000700000007700000077000007700000470000040400000040000
-- </SPRITES>

-- <WAVES>
-- 000:33333333333333345666666666666666
-- 001:0123456789abcdeffedcba9876543210
-- 002:00000000ffffffff000000000eeeeeee
-- 003:000000ffffffffffffffffffff000000
-- </WAVES>

-- <SFX>
-- 000:940094009400a400b400c400c400c400c400c400c400c400d400e400e400e400e400f400f400f400f400f400f400f400f400f400f400f400f400f400000000000000
-- 001:a000b000c000d000d000e000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000109000000000
-- 002:a400b400c400d400e400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400f400009000000000
-- 003:9480949084a084b094b09440a4c0a4d0b4e0b400c400c400c400c400c400c400c400d400d400d400e400e400f400f400f400f400f400f400f400f400000000000000
-- 004:a080a090a090a0b0a0b0a0c0c0d0f0e0f0f0f0f0f0f0f020f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000709000000000
-- 005:80b090b090b0a020b0a0b0a0c0a0e0a0e0a0f0a0f0a0f0a0f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000f000709000000000
-- 006:d330d320d300e300d310d330d340e340e330e320e300e310e310e330e330d340d310e300e300e310e320e340e340d320d300d310d320d330d350d330100000000000
-- 007:94f694e694e5a4e5a4d5a4d4b4c4b4c4c4b4c4b3c4a3d4a2d492d482d472e461e461e451e440e430f420f410f400f400f400f400f400f400f400f400100000000000
-- 008:95f0a5e0a5d0a5c0b5c0b5b0b5b0b5a0c5a0d590d570e560e550e530e520f520f520f510f510f510f500f500f500f500f500f500f500f500f500f500100000000000
-- 009:9520a540a560b580b590b5a0c5b0c5c0d5d0d5d0e5e0e5f0f5f0f500f500f500f500f500f500f500f500f500f500f500f500f500f500f500f500f500100000000000
-- </SFX>

-- <FLAGS>
-- 000:00100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- </FLAGS>

-- <SCREEN>
-- 000:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 001:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 002:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 003:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 004:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 005:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 006:00000000000000000000000000000000000000000007777777733333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333337777777700000000000000000000000000000000000f0f000f0f000f0f000f0f000f0f0000000
-- 007:0000000000000000000000000000000000000000000777777773333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333777777770000000000000000000000000000000000fffff0fffff0fffff0fffff0f0f0f000000
-- 008:0000000000000000000000000000000000000000000777777773333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333777777770000000000000000000000000000000000fffff0fffff0fffff0fffff0f000f000000
-- 009:00000000000000000000000000000000000000000007777777733333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333337777777700000000000000000000000000000000000fff000fff000fff000fff000f0f0000000
-- 010:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000f00000f00000f00000f00000f00000000
-- 011:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 012:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 013:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 014:0000000000000000000000000000000000000000000777777773333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333777777770000000000000000000000000000000000000000000000000000000ff000f00000000
-- 015:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000f0f00f0f0000000
-- 016:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000f0f00f0f0000000
-- 017:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000f0f00f0f0000000
-- 018:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000ff0000f00000000
-- 019:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 020:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 021:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 022:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 023:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 024:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 025:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 026:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 027:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 028:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 029:00000000000000000000000000000000000000000007777777733333333333333333333333333333333333333333333333333333333333a33a333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 030:00000000000000000000000000000000000000000007777777733333333333333333333333333333333333333333333333333333333333a3aa333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 031:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333366663333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 032:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333361613333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 033:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333366663333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 034:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333363363333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 035:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 036:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 037:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 038:00000000000000000000000000000000000000000007777777733333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333a33a333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 039:00000000000000000000000000000000000000000007777777733333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333aa3a333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 040:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333666633333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 041:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333161633333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 042:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333666633333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 043:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333633633333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 044:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 045:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 046:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 047:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 048:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 049:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 050:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 051:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 052:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 053:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 054:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 055:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 056:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 057:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 058:00000000000000000000000000000000000000000007777777733333333333333333333333333333333333333333333333333333333333333333333333333333333333333333f333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 059:0000000000000000000000000000000000000000000777777773333333333333333333333333333333333333333333333333333333333333333333333333333333333333333f3333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 060:00000000000000000000000000000000000000000007777777733333333333333333333333333333333333333333333333333333333333333333333333333333333333333ff33333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 061:0000000000000000000000000000000000000000000777777773333333333333333333333333333333333333333333333333333333333333333333333333333333333333f3333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 062:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333f33333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 063:0000000000000000000000000000000000000000000777777773333333333333333333333333333333333333333333333333333333333333333333333333333333333ff333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 064:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333f33333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 065:00000000000000000000000000000000000000000007777777733333333333333333333333333333333333333333333333333333333333333333333333333333333f333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 066:0000000000000000000000000000000000000000000777777773333333333333333333333333333333333333333333333333333333333333333333333333333333f3333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 067:00000000000000000000000000000000000000000007777777733333333333333333333333333333333333333333333333333333333333333333333333333333ff33333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 068:0000000000000000000000000000000000000000000777777773333333333333333333333333333333333333333333333333333333333333333333333333333f3333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 069:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333336663f33333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 070:0000000000000000000000000000000000000000000777777773333333333333333333333333333333333333333333333333333333333333333333333aa66f333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 071:00000000000000000000000000000000000000000007777777733333333333333333333333333333333333333333333333333333333333333333333333aa33333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 072:000000000000000000000000000000000000000000077777777333333333333333333333333a33a333333333333333333333333333333333333333333aaa33333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 073:000000000000000000000000000000000000000000077777777333333333333333333333333a3aa333333333333333333333333333333333333333333aaa33333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 074:0000000000000000000000000000000000000000000777777773333333333333333333333366663333333333333333333333333333333333333333333aaa33333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 075:0000000000000000000000000000000000000000000777777773333333333333333333333361613333333333333333333333333333333333333333333a3a33333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 076:000000000000000000000000000000000000000000077777777333333333333333333333336666333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 077:000000000000000000000000000000000000000000077777777333333333333333333333336336333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 078:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 079:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 080:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 081:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 082:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 083:000000000000000000000000000000000000000000077777777333333333333333333333363333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 084:000000000000000000000000000000000000000000077777777333333333333333333363633333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 085:000000000000000000000000000000000000000000077777777333333333333333333666663333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 086:000000000000000000000000000000000000000000077777777333333333333333336363636333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 087:000000000000000000000000000000000000000000077777777333333333333333333666663333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 088:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 089:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 090:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 091:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 092:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 093:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 094:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 095:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 096:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 097:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 098:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 099:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 100:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 101:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 102:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 103:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 104:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 105:000000000000000000000000000000000000000000077777777333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333377777777000000000000000000000000000000000000000000000000000000000000000000000
-- 106:000000000000000000000000000000000000000000077777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777000000000000000000000000000000000000000000000000000000000000000000000
-- 107:000000000000000000000000000000000000000000077777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777000000000000000000000000000000000000000000000000000000000000000000000
-- 108:000000000000000000000000000000000000000000033333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333000000000000000000000000000000000000000000000000000000000000000000000
-- 109:000000000000000000000000000000000000000000037773777377737773777377737773777377737773777377737773777377737773777377737773777377737773777377737773777377737773777377737773777000000000000000000000000000000000000000000000000000000000000000000000
-- 110:000000000000000000000000000000000000000000033333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333000000000000000000000000000000000000000000000000000000000000000000000
-- 111:000000000000000000000000000000000000000000077377737773777377737773777377737773777377737773777377737773777377737773777377737773777377737773777377737773777377737773777377737000000000000000000000000000000000000000000000000000000000000000000000
-- 112:000000000000000000000000000000000000000000033333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333000000000000000000000000000000000000000000000000000000000000000000000
-- 113:000000000000000000000000000000000000000000073777377737773777377737773777377737773777377737773777377737773777377737773777377737773777377737773777377737773777377737773777377000000000000000000000000000000000000000000000000000000000000000000000
-- </SCREEN>

-- <PALETTE>
-- 000:140c1c44243430346d4e4a4e854c30346524d04648757161597dced27d2c8595a16daa2c8940c66dc2cadad45edeeed6
-- 001:282828000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- </PALETTE>

