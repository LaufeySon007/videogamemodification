_AdminPickup()
{
self endon("disconnect");

while(1)
{	
while(!self secondaryoffhandButtonPressed())
{
wait 0.05;
}

start = self getEye();
end = start + maps\mp\_utility::vector_scale(anglestoforward(self getPlayerAngles()), 999999);
trace = bulletTrace(start, end, true, self);
dist = distance(start, trace["position"]);

ent = trace["entity"];

if(isDefined(ent) && ent.classname == "player")
{
if(isPlayer(ent))
ent IPrintLn("^1You've Been Picked Up By ^2" + self.name + "^1!");

self IPrintLn("^1You've Picked Up ^2" + ent.name + "^1!");

linker = spawn("script_origin", trace["position"]);
ent linkto(linker);

while(self secondaryoffhandButtonPressed())
{
wait 0.05;
}

while(!self secondaryoffhandButtonPressed() && isDefined(ent))
{
start = self getEye();
end = start + maps\mp\_utility::vector_scale(anglestoforward(self getPlayerAngles()), dist);
trace = bulletTrace(start, end, false, ent);
dist = distance(start, trace["position"]);

if(self fragButtonPressed() && !self adsButtonPressed())
dist -= 15;
else if(self fragButtonPressed() && self adsButtonPressed())
dist += 15;

end = start + maps\mp\_utility::vector_Scale(anglestoforward(self getPlayerAngles()), dist);
trace = bulletTrace(start, end, false, ent);
linker.origin = trace["position"];

wait 0.05;
}

if(isDefined(ent))
{
ent unlink();

if(isPlayer(ent))
ent IPrintLn("^1You've Been Dropped By ^2" + self.name + "^1!");

self IPrintLn("^1You've Dropped ^2" + ent.name + "^1!");
}

linker delete();
}

while(self secondaryoffhandButtonPressed())
{
wait 0.05;
}
}
}
