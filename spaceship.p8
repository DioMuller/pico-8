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

-- background
local stars = {}
local star_count = 64
local star_speed = 4

-------------------
-- game lifetime
-------------------
function _init()
	-- init player
	player.x = 64
	player.y = 120
	player.speed = 2
	
	-- init background
	for i=1,star_count do
		add(stars, {x=rnd(128),y=rnd(128)})
	end
end

function _update()
	-- player
	update_player()
	
	-- background
	for star in all(stars) do
		star.y += star_speed
		
		if star.y > 128 then
			star.y = 0
			star.x = rnd(128)
		end
	end
end

function _draw()
	cls()
	
	-- background
	for star in all(stars) do
		pset(star.x, star.y,13)
	end
	
	-- player
	spr(1, player.x, player.y)
end

-------------------
-- helper methods
-------------------
function update_player()
	if btn(0) and player.x > 0 then
		player.x -= player.speed
	end
	
	if btn(1) and player.x < 120 then
		player.x += player.speed
	end
	
	if btn(2) and player.y > 0 then
		player.y -= player.speed
	end
	
	if btn(3) and player.y < 120 then
		player.y += player.speed
	end		
end

function update_background()

end

__gfx__
00000000000dd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700007777000000000000099000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000d007700d00099000009aa900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770007077770700099000009aa900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700777cc7770000000000900900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000777cc7770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000007d77d700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
