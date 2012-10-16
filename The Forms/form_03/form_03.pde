size(400,400);
int n = (int)random(0,100);
strokeWeight(5);
stroke(3*n%255,5*n%255,7*n%255);
line(n,n*2,n*3,n*4);
line(n*2,n,n*4,n*3);
