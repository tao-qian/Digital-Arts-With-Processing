import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
/*
Musicplayer used to play music.
 Must take in a minim instance 
 because it must be initialized in the main application.
 
  Author: Tao Qian
 */
class MusicPlayer {

  Minim minim;
  AudioPlayer song;

  MusicPlayer(Minim minim, String filePath)
  {
    this.minim = minim;
    song = minim.loadFile(filePath);
  }


  void start()
  {
    song.rewind();
    song.play();
  }

  void stop()
  {
    song.close();
    minim.stop();
  }
}

