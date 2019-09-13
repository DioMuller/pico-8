pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
-------------------
-- data
-------------------

-- player
local player = {
	x = 0,
	y = 0,
	speed = 0
}

-- aux
local shooting = false

-- bullets
local bullets = {}

-- game state
local score = 0
local high = 0
local lives = 3

-- background
local stars = {}
local star_count = 64
local star_speed = 3

-------------------
-- game lifetime
-------------------
function _init()
	-- init player
	player.x = 64
	player.y = 118
	player.speed = 2
	
	-- init background
	for i=1,star_count do
		add(stars, {x=rnd(128),y=rnd(128)})
	end
end

function _update()
	-- player
	update_player()
	
	-- bullets
	update_bullets()
	
	-- background
	update_background()
end

function _draw()
	cls()
	
	-- background
	for star in all(stars) do
		pset(star.x, star.y,13)
	end
	
	-- bullets
	for bullet in all(bullets) do
		spr(2, bullet.x, bullet.y)
	end
	
	-- player
	spr(1, player.x, player.y)
	
	-- ui
	rectfill(0,0,127,15,1)
	print('score: '..score, 3, 3, 6)
	print('high : '..high, 3, 10, 6)
	
	spr(1, 100, 4)
	print(lives,114,6)
	
	-- border
	rect(0,16,127,127,1)
end

-------------------
-- update methods
-------------------
function update_player()
	if btn(0) and player.x > 2 then
		player.x -= player.speed
	end
	
	if btn(1) and player.x < 118 then
		player.x += player.speed
	end
	
	if btn(2) and player.y > 18 then
		player.y -= player.speed
	end
	
	if btn(3) and player.y < 118 then
		player.y += player.speed
	end		
	
	if btn(4) then
		if not shooting then
			sfx(0)
			create_bullet()
			shooting = true
		end
	else
		shooting = false
	end
end

function update_background()
	for star in all(stars) do
		star.y += star_speed
		
		if star.y > 128 then
			star.y = 0
			star.x = rnd(128)
		end
	end
end

function update_bullets()
	local to_remove = {}
	
	for bullet in all(bullets) do
		bullet.y -= 2
		
		if bullet.y < 0 then
			del(bullets, bullet)
		end
	end
end

-------------------
-- helper methods
-------------------
function create_bullet()
	add(bullets, {x = player.x, y = player.y})
end

__gfx__
00000000000440000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700007777000000000000099000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770004007700400099000009aa900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770007077770700099000009aa900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700777cc7770000000000900900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000777cc7770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000074774700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100001d45014450114500d4500c4500c4500c4500c4500d4500d4500f450104502445036450214501b450194501545012450114500e4500d4500b4500a4500945009450084500845008450094500a4500b450
