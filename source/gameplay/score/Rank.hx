package gameplay.score;

enum abstract ScoringRank(String)
{
  var PERFECT_GOLD;
  var PERFECT;
  var EXCELLENT;
  var GREAT;
  var GOOD;
  var SHIT;

  /**
   * Converts ScoringRank to an integer value for comparison.
   * Better ranks should be tied to a higher value.
   */
  static function getValue(rank:Null<ScoringRank>):Int
  {
    if (rank == null) return -1;
    switch (rank)
    {
      case PERFECT_GOLD:
        return 5;
      case PERFECT:
        return 4;
      case EXCELLENT:
        return 3;
      case GREAT:
        return 2;
      case GOOD:
        return 1;
      case SHIT:
        return 0;
      default:
        return -1;
    }
  }

  // Yes, we really need a different function for each comparison operator.
  @:op(A > B) static function compareGT(a:Null<ScoringRank>, b:Null<ScoringRank>):Bool
  {
    if (a != null && b == null) return true;
    if (a == null || b == null) return false;

    var temp1:Int = getValue(a);
    var temp2:Int = getValue(b);

    return temp1 > temp2;
  }

  @:op(A >= B) static function compareGTEQ(a:Null<ScoringRank>, b:Null<ScoringRank>):Bool
  {
    if (a != null && b == null) return true;
    if (a == null || b == null) return false;

    var temp1:Int = getValue(a);
    var temp2:Int = getValue(b);

    return temp1 >= temp2;
  }

  @:op(A < B) static function compareLT(a:Null<ScoringRank>, b:Null<ScoringRank>):Bool
  {
    if (a != null && b == null) return true;
    if (a == null || b == null) return false;

    var temp1:Int = getValue(a);
    var temp2:Int = getValue(b);

    return temp1 < temp2;
  }

  @:op(A <= B) static function compareLTEQ(a:Null<ScoringRank>, b:Null<ScoringRank>):Bool
  {
    if (a != null && b == null) return true;
    if (a == null || b == null) return false;

    var temp1:Int = getValue(a);
    var temp2:Int = getValue(b);

    return temp1 <= temp2;
  }

  // @:op(A == B) isn't necessary!

  /**
   * Delay in seconds
   */
  public function getMusicDelay():Float
  {
    switch (abstract)
    {
      case PERFECT_GOLD | PERFECT:
        // return 2.5;
        return 95 / 24;
      case EXCELLENT:
        return 0;
      case GREAT:
        return 5 / 24;
      case GOOD:
        return 3 / 24;
      case SHIT:
        return 2 / 24;
      default:
        return 3.5;
    }
  }

  public function getBFDelay():Float
  {
    switch (abstract)
    {
      case PERFECT_GOLD | PERFECT:
        // return 2.5;
        return 95 / 24;
      case EXCELLENT:
        return 97 / 24;
      case GREAT:
        return 95 / 24;
      case GOOD:
        return 95 / 24;
      case SHIT:
        return 95 / 24;
      default:
        return 3.5;
    }
  }

  public function getFlashDelay():Float
  {
    switch (abstract)
    {
      case PERFECT_GOLD | PERFECT:
        // return 2.5;
        return 129 / 24;
      case EXCELLENT:
        return 122 / 24;
      case GREAT:
        return 109 / 24;
      case GOOD:
        return 107 / 24;
      case SHIT:
        return 186 / 24;
      default:
        return 3.5;
    }
  }

  public function getHighscoreDelay():Float
  {
    switch (abstract)
    {
      case PERFECT_GOLD | PERFECT:
        // return 2.5;
        return 140 / 24;
      case EXCELLENT:
        return 140 / 24;
      case GREAT:
        return 129 / 24;
      case GOOD:
        return 127 / 24;
      case SHIT:
        return 207 / 24;
      default:
        return 3.5;
    }
  }

  public function getFreeplayRankIconAsset():String
  {
    switch (abstract)
    {
      case PERFECT_GOLD:
        return 'PERFECTSICK';
      case PERFECT:
        return 'PERFECT';
      case EXCELLENT:
        return 'EXCELLENT';
      case GREAT:
        return 'GREAT';
      case GOOD:
        return 'GOOD';
      case SHIT:
        return 'LOSS';
      default:
        return 'LOSS';
    }
  }

  public function getHorTextAsset()
  {
    switch (abstract)
    {
      case PERFECT_GOLD:
        return 'resultScreen/rankText/rankScrollPERFECT';
      case PERFECT:
        return 'resultScreen/rankText/rankScrollPERFECT';
      case EXCELLENT:
        return 'resultScreen/rankText/rankScrollEXCELLENT';
      case GREAT:
        return 'resultScreen/rankText/rankScrollGREAT';
      case GOOD:
        return 'resultScreen/rankText/rankScrollGOOD';
      case SHIT:
        return 'resultScreen/rankText/rankScrollLOSS';
      default:
        return 'resultScreen/rankText/rankScrollGOOD';
    }
  }

  public function getVerTextAsset()
  {
    switch (abstract)
    {
      case PERFECT_GOLD:
        return 'resultScreen/rankText/rankTextPERFECT';
      case PERFECT:
        return 'resultScreen/rankText/rankTextPERFECT';
      case EXCELLENT:
        return 'resultScreen/rankText/rankTextEXCELLENT';
      case GREAT:
        return 'resultScreen/rankText/rankTextGREAT';
      case GOOD:
        return 'resultScreen/rankText/rankTextGOOD';
      case SHIT:
        return 'resultScreen/rankText/rankTextLOSS';
      default:
        return 'resultScreen/rankText/rankTextGOOD';
    }
  }
}