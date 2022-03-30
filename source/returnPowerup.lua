returnPowerup=Class{}
function returnPowerup(table)
  ptable=table
    local bricks={}
counter=1
  for k,power in pairs(table) do
         if power.z==true then
          keypowerup=true

     elseif math.random(2)==1 and true or false then
      t=math.random(1,9)
      bricks[counter]=Powerup(power.x,power.y,t,math.random(1,3))
      counter=counter+1
    end
end
if #bricks==0 then
  self:returnPowerup(ptable)
end
if keypowerup==true then
  t=10

  key=math.random(1,counter)
  bricks[key]=Powerup(bricks[key].x,bricks[key].y,t,1)
end
return bricks
end