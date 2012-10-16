noFill();
smooth();
size(200,200);
int x = 40;
int y = 100;
curve(x,y/1.2,x,y,200-x,y,200-x,y/1.2);
curve(x,y/2,x,y,200-x,y,200-x,y/2);
curve(x,y/4,x,y,200-x,y,200-x,y/4);
curve(x,y/32,x,y,200-x,y,200-x,y/32);
curve(x,200-y/1.2,x,y,200-x,y,200-x,200-y/1.2);
curve(x,200-y/2,x,y,200-x,y,200-x,200-y/2);
curve(x,200-y/4,x,y,200-x,y,200-x,200-y/4);
curve(x,200-y/32,x,y,200-x,y,200-x,200-y/32);

