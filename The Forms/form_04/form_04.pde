int n = (int)random(0,100);
int sizeN = (int)random(0,8);
size(400,400);
strokeWeight(sizeN*17%5+1);
line(n,n*2,n*3,n*4);
line(n*2,n,n*4,n*3);
