
LevelMaker=Class{}

function LevelMaker.createMap(level)
 local bricks={}
local rows=math.random(1,5)

local column=math.random(7,13)
column=column%2==0 and (column+1) or column


local highestTier=math.min(3,math.floor(level/5))

local highestcolor=math.min(5, level % 5 + 3)

local levelflag= true



for y=1,rows do
	local skipPattern=math.random(1,2)==1 and true or false



	local alternatePattern=math.random(1,2)==1 and true or false

	local alternatecolor1=math.random(1,highestcolor)
	local alternatecolor2=math.random(1,highestcolor)
	local alternatetier1=math.random(0,highestTier)
	local alternatetier2=math.random(0,highestTier)

     local skipflag=math.random(2)==1 and true or false

	local alternateflag=math.random(2)==1 and true or false


	local solidcolor=math.random(1,highestcolor)

	local solidtier=math.random(0,highestTier)

	for x=1,column do

		if skipPattern and skipflag then

			skipflag=not skipflag

			goto continue
		
	    else
		    skipflag=not skipflag
          end

		b=Brick(
                -- x-coordinate
                (x-1)                   -- decrement x by 1 because tables are 1-indexed, coords are 0
                * 32                    -- multiply by 32, the brick width
                + 8                     -- the screen should have 8 pixels of padding; we can fit 13 cols + 16 pixels total
                + (13 - column) * 16,  -- left-side padding for when there are fewer than 13 columns
                
                -- y-coordinate
                y * 16                  -- just use y * 16, since we need top padding anyway
            )
              if levelflag then
              	keyflag=true
              	b=Key( (x-1)                   -- decrement x by 1 because tables are 1-indexed, coords are 0
                * 32                    -- multiply by 32, the brick width
                + 8                     -- the screen should have 8 pixels of padding; we can fit 13 cols + 16 pixels total
                + (13 - column) * 16,  -- left-side padding for when there are fewer than 13 columns
                
                -- y-coordinate
                y * 16 , keyflag 

              		)
                levelflag=not levelflag
            end

		if alternatePattern and alternateflag then
			b.color=alternatecolor1
			b.tier=alternatetier1
			alternateflag=not alternateflag
		else
			b.color=alternatecolor2
			b.tier=alternatetier2
            alternateflag=not alternateflag
		end
		if not alternatePattern then
			b.color=solidcolor
			b.tier=solidtier
		end

		table.insert(bricks,b)

		::continue::
        end
end
	
 if #bricks == 0 then
        return self.createMap(level)
    else
        return bricks
    end
end
