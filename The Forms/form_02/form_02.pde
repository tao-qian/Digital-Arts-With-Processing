size(200, 200);
noStroke();
int[] randomPoints = new int[8];
for (int j = 0;j<randomPoints.length;j++)
{
  randomPoints[j] = (int)random(0, 40);
}
for(int i = 1;i<5;i++)
{
fill(i*40);
quad(randomPoints[0]*i, randomPoints[1]*i, randomPoints[2]*i, randomPoints[3]*i, randomPoints[4]*i, randomPoints[5]*i, randomPoints[6]*i, randomPoints[7]*i);
}
