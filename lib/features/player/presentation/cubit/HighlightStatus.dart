class HighlightStatus
{

  int soraNum = 0 ;
  int fromHighLightedAyaNum =0;
  int toHighLightedAyaNum = 0;
  int bookMarkAyaNum = 0;

  HighlightStatus();

  HighlightStatus.our_constructor(this.soraNum, this.fromHighLightedAyaNum,
      this.toHighLightedAyaNum,this.bookMarkAyaNum);

  HighlightStatus.clone(HighlightStatus highlightStatus):
        this.our_constructor(highlightStatus.soraNum, highlightStatus.fromHighLightedAyaNum
          , highlightStatus.toHighLightedAyaNum, highlightStatus.bookMarkAyaNum);
}