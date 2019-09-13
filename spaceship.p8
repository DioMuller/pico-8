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
local enemy_bullets = {}
local bullet_speed = 4

-- enemies
local enemies = {}
local count_col = 3
local count_row = 11

-- game state
local score = 0
local high = 0
local lives = 3
local kills = 0

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
	
	-- init enemies
	for i=1,count_row do
		for j=1,count_col do
			create_enemy(i*10,20+j*12,15+j,j*100) 
		end
	end
end

function _update()
	update_player()
	update_enemies()
	update_bullets()
	update_background()
end

function _draw()
	cls()
	
	draw_background()
	draw_bullets()
	draw_enemies()
	draw_player()
	
	draw_ui()
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

function update_enemies()
	for enemy in all(enemies) do
		for bullet in all(bullets) do
			if intersect(enemy.x,enemy.y,8,8,bullet.x,bullet.y,8,8) then
				score += enemy.score
				del(enemies,enemy)
				del(bullets,bullet)
				sfx(1)
			end
		end
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
	for bullet in all(bullets) do
		bullet.y -= bullet_speed
		
		if bullet.y < 0 then
			del(bullets, bullet)
		end
	end
end

-------------------
-- draw methods
-------------------
function draw_player()
	spr(1, player.x, player.y)
end

function draw_enemies()
	for enemy in all(enemies) do
		spr(enemy.type,enemy.x,enemy.y)
	end
end

function draw_background()
	for star in all(stars) do
		pset(star.x, star.y,13)
	end
end

function draw_bullets()
	for bullet in all(bullets) do
		spr(2, bullet.x, bullet.y)
	end
end

function draw_ui()
	-- top ui
	rectfill(0,0,127,15,1)
	print('score: '..score, 3, 3, 6)
	print('high : '..high, 3, 10, 6)
	
	print('lives: '..lives, 94, 3, 6)
	print('kills: '..kills, 94,10, 6)
	
	-- border
	rect(0,16,127,127,1)
end

-------------------
-- builder methods
-------------------
function create_bullet()
	add(bullets, {x = player.x, y = player.y})
end

function create_enemy(pos_x,pos_y,enemy_type,enemy_score)
	add(enemies, {x=pos_x, y=pos_y,type=enemy_type,score=enemy_score})
end

-------------------
-- helper methods
-------------------
function intersect(x1,y1,w1,h1,x2,y2,w2,h2)
	return x1<x2+w2 and x2<x1+w1 and y1<y2+h2 and y2<y1+h1
end

__gfx__
00000000000990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700007777000000000000099000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770009007700900099000009aa900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770007077770700099000009aa900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700777cc7770000000000900900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000777cc7770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000079779700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0e0ee0e0055555504440044400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eeecceee005005004444444400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
eeecceee50555505444cc44400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e0eeee0e555cc555044cc44000088000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
800ee008505cc5054444444400088000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000ee00050555505404cc40400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000ee00080055008804cc40800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00088000000880000004400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000c35010350143501b3502a350203501635014350113500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0001000021450284502f4502c450274501e4501b450274502c4502845017450164501845020450314502e4502045018450194501d4503645033450144501445015450174502f4502a45013450124501345026450
