class PlayerHighlightStatus {
  int soraNum = 0;
  int pageNum = 0;
  int ayaNum = 0;

  PlayerHighlightStatus();

  PlayerHighlightStatus.our_constructor(
      this.soraNum, this.pageNum, this.ayaNum);

  clear()
  {
     soraNum = 0;
     pageNum = 0;
     ayaNum = 0;
  }
}
